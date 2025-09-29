-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/ResolveEquipItemCell.lua

module("logic.extensions.backpack.cell.ResolveEquipItemCell", package.seeall)

local M = class("ResolveEquipItemCell", BackpackItemCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("equip", BackpackEquipItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
end

function M:dealSelect()
	return
end

function M:onSelect(isSelected)
	return
end

function M:unSelect()
	return
end

function M:updateData(data)
	M.super.updateData(self, data)

	local numComp = self:getComponent("num")
	local color = Astral.ColorUtil.ParseColor("#000000")

	numComp:setTextColor(color)
end

return M
