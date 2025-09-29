-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/GetwayCell.lua

module("logic.extensions.backpack.cell.GetwayCell", package.seeall)

local M = class("GetwayCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("getway", GetWayComponent)
end

return M
