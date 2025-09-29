-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CommonEquipSuitCellView.lua

module("logic.extensions.charactersystem.view.equip.CommonEquipSuitCellView", package.seeall)

local M = class("CommonEquipSuitCellView", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("cellComp", CommonEquipSuitCellComp)
end

function M:onSelect(isSelected)
	self:getComponent("cellComp"):setSelect(isSelected)
end

return M
