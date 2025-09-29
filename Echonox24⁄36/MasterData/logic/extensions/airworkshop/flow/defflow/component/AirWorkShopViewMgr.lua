-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkShopViewMgr.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkShopViewMgr", package.seeall)

local M = class("AirWorkShopViewMgr", IAirWorkShopFlowComp)

function M:onResourceLoaded()
	ViewMgr.instance:open(ViewName.AirWorkShopDefSceneMainView)
	ScenePickerViewFacade.instance:open(AirWorkShopConst.DefaultKey)
end

function M:onStart()
	BattleLog.init()
end

function M:onClear(isRestart)
	ScenePickerViewFacade.instance:close(AirWorkShopConst.DefaultKey)
	ViewMgr.instance:close(ViewName.AirWorkShopDefSceneMainView)
	BattleLog.clear()
end

return M
