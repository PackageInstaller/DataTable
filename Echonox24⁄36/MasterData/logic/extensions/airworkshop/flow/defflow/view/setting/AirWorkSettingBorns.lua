-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSettingBorns.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSettingBorns", package.seeall)

local M = class("AirWorkSettingBorns", AirWorkMapBaseView)

function M:ctor(container)
	M.super.ctor(self)

	self._mainGO = container.gameObject

	self:buildUI()
	self:bindEvents()
end

function M:buildUI()
	self._mapRootGo = goutil.findChild(self._mainGO, "gridGroup")
	self._mapGridGo = goutil.findChild(self._mainGO, "gridGroup/air_workshop_terrain_grid_item")

	goutil.setActive(self._mapGridGo, false)

	self._btnEdit = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGO, "btnEdit"))

	self:createMap()
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnEdit:AddClickListener(self._onClickEdit, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnEdit:RemoveClickListener()
end

function M:onEnter(mapData)
	local currModel = AirWorkShopDefMgr.instance:getModel()

	self._mapData = currModel:getModiedMapMO()

	self:_setMapData()
end

function M:onExit()
	M.super.onExitFinished(self)
end

function M:OnDestroy()
	M.super.destroyUI(self)
	self:unbindEvents()
end

function M:_onGridClick(index)
	return
end

function M:_onClickEdit()
	GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_SETTING_GOSELECT, AirWorkShopEnum.DefState.BornPosSet)
	ViewMgr.instance:close(ViewName.AirWorkShopSettingView)
end

return M
