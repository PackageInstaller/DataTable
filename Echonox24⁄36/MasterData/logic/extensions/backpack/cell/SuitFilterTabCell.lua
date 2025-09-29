-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/SuitFilterTabCell.lua

module("logic.extensions.backpack.cell.SuitFilterTabCell", package.seeall)

local M = class("SuitFilterTabCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("cellComp", SuitFilterTabComp)
end

function M:onSelect(isSelected)
	self:getComponent("cellComp"):setSelect(isSelected)
end

return M
