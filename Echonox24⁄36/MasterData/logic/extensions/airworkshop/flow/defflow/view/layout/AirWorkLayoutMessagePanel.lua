-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/layout/AirWorkLayoutMessagePanel.lua

module("logic.extensions.airworkshop.flow.defflow.view.layout.AirWorkLayoutMessagePanel", package.seeall)

local M = class("AirWorkLayoutMessagePanel")

function M:ctor(container)
	self._go = container.gameObject
	self._imgQuality = goutil.findChild(self._go, "backpack_item/imgQuality")
	self._imgIcon = goutil.findChild(self._go, "backpack_item/imgIcon")
	self._txtPosition = goutil.findChildTextComponent(self._go, "txtPosition")
	self._btnDelete = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnDelete"))
	self._btnEdit = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnEdit"))

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnDelete:AddClickListener(self._onDelete, self)
	self._btnEdit:AddClickListener(self._onEdit, self)
end

function M:_unbindEvents()
	self._btnDelete:RemoveClickListener()
	self._btnEdit:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:updateData(data, index)
	self._data = data or {}

	local buildingCo = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioBuilding, self._data:getId())

	self._txtPosition.text = string.format("(%s,%s)", AirWorkShopUtil.convertToXY(index))

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, buildingCo.icon)
end

function M:_onDelete()
	local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("删除留言建筑会清除所有留言设置，是否继续进行操作？"))

	dialog:setConfirmListener(function()
		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_LAYOUT_CHANGE, self._data)
	end, self)
end

function M:_onEdit()
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._data:getEntityId())

	ViewMgr.instance:open(ViewName.AirWorkShopDefMessageSetView, unit.property:getUnitMO())
end

return M
