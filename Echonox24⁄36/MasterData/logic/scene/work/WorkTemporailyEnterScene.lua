-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkTemporailyEnterScene.lua

module("logic.scene.work.WorkTemporailyEnterScene", package.seeall)

local M = class("WorkTemporailyEnterScene", WorkBase)

function M:onEnter(context)
	self._sceneType = context.info.sceneType
	self._sceneId = context.info.sceneId
	self._flow = context.info.flow

	SceneFace.instance:printMsg(string.format("temporaily enter sceneTyp[%s]id[%s]", self._sceneType, self._sceneId), false)

	if SceneMgr.instance:getCurSceneId() == self._sceneId then
		self:onDone(WorkResult.Succeed)

		return
	end

	self:_setEvent(true)

	if self._flow then
		self._flow:_notifyComponents(SceneFunctionName.onEnter, context.info.flowInfo)
	end

	SceneMgr.instance:enterDirectly(self._sceneType, self._sceneId, 0, 0)
end

function M:onExit(isInterrupt)
	self:_setEvent(false)

	self._sceneType = nil
	self._sceneId = nil
	self._flow = nil
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
