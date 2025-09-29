-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/cell/EquipIntencifyRecycleItem.lua

module("logic.extensions.charactersystem.view.cell.EquipIntencifyRecycleItem", package.seeall)

local M = class("EquipIntencifyRecycleItem", BackpackItemCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("operate", BackpackOperateComponent)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("levelNum", LevelComponent)
	self:_addComponent("lock", LockComponent)
	self:_addComponent("breakpoint", BreakPointComponent)
	self:_addComponent("equip", BackpackEquipItemCellComponet)
	self:_addComponent("sign", BackpackSignHideComponent)
	self:_addComponent("notGetType", BackpackNotGetTypeHideComponent)
	self:_addComponent("usingType", BackpackUsingTypeHideComponent)

	self._evt = EventType.EQUIP_INTENCIFY_RECYCLE_ITEM_CLICK
end

function M:onSelect(isPreview, isSelected)
	local normalComp = self:getComponent("normal")

	normalComp:setItemSelect(isPreview or isSelected)

	local operateComp = self:getComponent("operate")

	operateComp:setImgOperateGoVisible(isSelected)
	operateComp:setBtnCutGoVisible(isSelected)
end

function M:unSelect()
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_INTENCIFY_RECYCLE_ITEM_SUB_CLICK, self._data)
end

return M
