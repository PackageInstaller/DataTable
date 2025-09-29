-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/BackpackD6ItemCell.lua

module("logic.extensions.backpack.cell.BackpackD6ItemCell", package.seeall)

local M = class("BackpackD6ItemCell", BackpackItemCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("operate", BackpackOperateComponent)
	self:_addComponent("lock", LockComponent)
	self:_addComponent("breakpoint", BreakPointComponent)
	self:_addComponent("animation", BackpackAnimationComponent)
	self:_addComponent("CanvasGroup", BackpackCanvasGroupComponet)
	self:_addComponent("preset", PresetComponent)
	self:_addComponent("d6", BackpackD6ItemCellComponet)
	self:_addComponent("levelNum", LevelHideComponent)
	self:_addComponent("holeCount", HoleCountHideComponent)
	self:_addComponent("equip", BackpackEquipItemCellHideComponet)
	self:_addComponent("notGetType", BackpackNotGetTypeHideComponent)
	self:_addComponent("usingType", BackpackUsingTypeHideComponent)
	self:_addComponent("sign", BackpackSignHideComponent)
end

function M:onSelect(isPreview, isSelected)
	local normalComp = self:getComponent("normal")

	normalComp:setItemSelect(isPreview or isSelected)

	local operateComp = self:getComponent("operate")

	operateComp:setImgOperateGoVisible(isSelected)
	operateComp:setBtnCutGoVisible(isSelected)
end

function M:unSelect()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_RECYCLE_ITEM_SUB_CLICK, self._data)
end

return M
