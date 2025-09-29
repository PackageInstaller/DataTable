-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/flow/work/HouseWorkLoadScene.lua

module("logic.extensions.house.scene.flow.work.HouseWorkLoadScene", package.seeall)

local M = class("HouseWorkLoadScene", WorkBase)

function M:onEnter(context)
	local sceneCode = context.model:getSceneCode()

	if SceneMgr.instance:getCurSceneId() == sceneCode then
		self:_onSceneLoaded()

		return
	end

	GlobalDispatcher:addEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
	SceneMgr.instance:enter(SceneType.House, sceneCode, 0, 0)
end

function M:onExit(isInterrupt)
	GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
end

function M:_onSceneLoaded(sceneType, sceneId)
	GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
	self:onDone(WorkResult.Succeed)
end

return M
