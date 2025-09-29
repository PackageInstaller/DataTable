-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/scene/AirWorkShopSceneVisualCulling.lua

module("logic.extensions.airworkshop.flow.defflow.scene.AirWorkShopSceneVisualCulling", package.seeall)

local M = class("AirWorkShopSceneVisualCulling", BattleSceneVisualCulling)

function M:_setEvent(add)
	if add then
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_ENTER_AIR_SCENE_FINISH, self._onEnterSceneFinished, self)
	else
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_ENTER_AIR_SCENE_FINISH, self._onEnterSceneFinished, self)
	end
end

function M:_onEnterSceneFinished()
	self._isEnableCulling = true

	self:_reloadObject()
end

return M
