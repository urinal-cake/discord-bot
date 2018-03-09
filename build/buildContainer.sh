#!/bin/bash

set -e

function validateEnv() {
    if [ -z "${CONTAINER_NAME}" ] ; then
        echo "ENV variable CONTAINER_NAME is not set!"
        exit 1
    fi

    if [ -z "${REGISTRY_ADDRESS}" ] ; then
        echo "ENV variable REGISTRY_ADDRESS is not set!"
        exit 1
    fi
}

# build container
function buildContainer() {
    echo "Building Container..."
    docker build -t ${CONTAINER_NAME}:latest .
    docker tag ${CONTAINER_NAME}:latest ${REGISTRY_ADDRESS}/${CONTAINER_NAME}:latest
    echo "Building PHP Container... DONE"
}

validateEnv
buildContainer

echo "Pushing all containers..."
docker push ${REGISTRY_ADDRESS}/${CONTAINER_NAME}:latest
echo "Pushing all containers... DONE"

echo "ALL DONE"
