-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/BackpackEquipItemCell.lua

module("logic.extensions.backpack.cell.BackpackEquipItemCell", package.seeall)

local M = class("BackpackEquipItemCell", BackpackItemCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("operate", BackpackOperateComponent)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("levelNum", LevelComponent)
	self:_addComponent("lock", LockComponent)
	self:_addComponent("breakpoint", BreakPointComponent)
	self:_addComponent("animation", BackpackAnimationComponent)
	self:_addComponent("CanvasGroup", BackpackCanvasGroupComponet)
	self:_addComponent("equip", BackpackEquipItemCellComponet)
	self:_addComponent("preset", PresetComponent)
	self:_addComponent("sign", BackpackSignHideComponent)
	self:_addComponent("notGetType", BackpackNotGetTypeHideComponent)
	self:_addComponent("usingType", BackpackUsingTypeHideComponent)

	local normalComp = self:getComponent("normal")

	normalComp:setRedPointType(CommEnum.RedPointIconType.New)
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

function M:refreshRed()
	local item = self._data

	if not item then
		return false
	end

	local redPoint = self:getComponent("normal"):getRedPoint()
	local isRed = item:getRedPointIsNew()

	goutil.setActive(redPoint, isRed)
end

return M
