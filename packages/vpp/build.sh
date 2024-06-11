#!/bin/sh
set -e

sudo apt-get update -y && sudo apt-get install -y llvm clang

SRC=vpp
if [ ! -d ${SRC} ]; then
    echo "Source directory does not exists, please 'git clone'"
    exit 1
fi

cd ${SRC}

PATCH_DIR=../patches
if [ -d $PATCH_DIR ]; then
    for patch in $(ls ${PATCH_DIR})
    do
        echo "I: Apply patch: ${patch} to main repository"
        git apply ${PATCH_DIR}/${patch}
    done
fi


export UNATTENDED=y
make install-dep && make build-release && make pkg-deb
