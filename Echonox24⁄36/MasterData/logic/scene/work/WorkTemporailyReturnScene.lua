-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkTemporailyReturnScene.lua

module("logic.scene.work.WorkTemporailyReturnScene", package.seeall)

local M = class("WorkTemporailyReturnScene", WorkBase)

function M:onEnter(context)
	self._sceneType = context.infoBack.sceneType
	self._sceneId = context.infoBack.sceneId
	self._readyLeaveFlow = context.infoBack.readyLeaveFlow
	self._readyBackFlow = context.infoBack.readyBackFlow

	local passThroughParam = context.infoBack.passThroughParam

	SceneFace.instance:printMsg(string.format("return temporaily leave sceneTyp[%s]id[%s]", self._sceneType, self._sceneId))

	if self._readyLeaveFlow then
		self._readyLeaveFlow:exitScene()
	else
		SceneMgr.instance:exitCurScene()
	end

	SceneFace.instance:printMsg("exit temporaily scene, return cache scene")

	local backScene = SceneMgr.instance:getScene(self._sceneType)

	if backScene.onReturnScene then
		backScene:onReturnScene(passThroughParam)
	end

	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	self._sceneType = nil
	self._sceneId = nil
	self._readyLeaveFlow = nil
	self._readyBackFlow = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
	end
end

function M:_onSceneLoaded(e, sceneType, sceneId)
	if sceneType == self._sceneType then
		self:onDone(WorkResult.Succeed)
	end
end

return M
