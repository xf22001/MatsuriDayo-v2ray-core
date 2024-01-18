#!/bin/bash

#================================================================
#   
#   
#   文件名称：compile.sh
#   创 建 者：肖飞
#   创建日期：2021年03月05日 星期五 22时11分43秒
#   修改日期：2021年10月31日 星期日 21时13分59秒
#   描    述：
#
#================================================================
set -x
function main() {
	#export GOPATH=$(pwd)/deps
	export CGO_ENABLED=0
	CODENAME="user"
	NOW=$(date '+%Y%m%d-%H%M%S')
	BUILDNAME=$NOW
	local VERSIONTAG=$(git describe --abbrev=0 --tags)
	#LDFLAGS="-s -w -buildid= -X v2ray.codename=${CODENAME} -X v2ray.build=${BUILDNAME} -X v2ray.version=${VERSIONTAG}"
	LDFLAGS="-buildid= -X v2ray.codename=${CODENAME} -X v2ray.build=${BUILDNAME} -X v2ray.version=${VERSIONTAG}"
	CFLAGS="-N -l"

	#go build -v -n -o v2ray -ldflags "$LDFLAGS" ./main
	go build -o v2ray -gcflags "$CFLAGS" -ldflags "$LDFLAGS" ./main > log 2>&1
	#go build -v -n -o "v2ctl" -tags confonly -ldflags "$LDFLAGS" ./infra/control/main
	#go build -o "v2ctl" -tags confonly -gcflags "$CFLAGS" -ldflags "$LDFLAGS" ./infra/control/main
}

main $@
