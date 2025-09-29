-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/work/AirWorkShopWorkLoadScene.lua

module("logic.extensions.airworkshop.flow.defflow.work.AirWorkShopWorkLoadScene", package.seeall)

local M = class("AirWorkShopWorkLoadScene", WorkBase)

function M:onEnter(context)
	local sceneCode = context.model:getBattleSceneCode()

	if SceneMgr.instance:isInTargetScene(SceneType.AirWorkShop, sceneCode) then
		self:onDone(WorkResult.Succeed)

		return
	end

	self._loadingSceneCode = sceneCode

	GlobalDispatcher:addEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
	SceneFace.instance:enterAirWorkShopScene(sceneCode)
end

function M:onExit(isInterrupt)
	GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
end

function M:_onSceneLoaded(_, sceneType, sceneId)
	if sceneType == SceneType.AirWorkShop and self._loadingSceneCode == sceneId then
		self:onDone(WorkResult.Succeed)
	end
end

return M
