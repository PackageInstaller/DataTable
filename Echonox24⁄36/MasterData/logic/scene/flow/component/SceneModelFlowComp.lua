-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/flow/component/SceneModelFlowComp.lua

module("logic.scene.flow.component.SceneModelFlowComp", package.seeall)

local M = class("SceneModelFlowComp", ISceneFlowComp)

function M:ctor(flow)
	M.super.ctor(self, flow)

	self._sceneId = 0
	self._sceneType = SceneType.Room
	self._mainPlayerInitPos = nil
end

function M:onEnter(sceneInfo)
	M.super.onEnter(sceneInfo)

	sceneInfo = sceneInfo or {}
	self._sceneId = sceneInfo.sceneId or self._sceneId
	self._sceneType = sceneInfo.sceneType or self._sceneType
	self._mainPlayerInitPos = sceneInfo.mainPlayerPos
end

function M:onExit()
	return
end

function M:onDestroy()
	return
end

function M:getSceneId()
	return self._sceneId
end

function M:getSceneType()
	return self._sceneType
end

function M:getMainPlayerInitPos()
	return self._mainPlayerInitPos
end

return M
