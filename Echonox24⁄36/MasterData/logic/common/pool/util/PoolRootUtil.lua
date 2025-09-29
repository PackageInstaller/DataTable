-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/util/PoolRootUtil.lua

module("logic.common.pool.util.PoolRootUtil", package.seeall)

local M = {}
local kSceneRoot = goutil.find("SCENEROOT")
local kScenePoolRoot = goutil.create("ScenePools", false)
local kUIPoolRoot = goutil.create("UIPools", true)

goutil.setActive(kScenePoolRoot, false)
goutil.setActive(kUIPoolRoot, false)
goutil.addChildToParent(kScenePoolRoot, kSceneRoot)
goutil.addChildToParent(kUIPoolRoot, kSceneRoot)

function M.getUIPoolRoot()
	return kUIPoolRoot
end

function M.getScenePoolRoot()
	return kScenePoolRoot
end

function M.createUIPoolRoot(name)
	local poolRoot = goutil.create(name, true)

	goutil.addChildToParent(poolRoot, kUIPoolRoot)

	return poolRoot
end

function M.createScenePoolRoot(name)
	local poolRoot = goutil.create(name, false)

	goutil.addChildToParent(poolRoot, kScenePoolRoot)

	return poolRoot
end

return M
