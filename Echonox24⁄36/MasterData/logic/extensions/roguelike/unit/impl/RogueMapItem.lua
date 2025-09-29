-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/impl/RogueMapItem.lua

module("logic.extensions.roguelike.unit.impl.RogueMapItem", package.seeall)

local M = class("RogueMapItem", RogueUnitBase)

function M:_initComponents()
	self:_addComponent("mapItem", RogueUnitMapItem)
	self:_addComponent("followUIComp", RogueUnitCompUIFollow)
end

function M:getCapacity()
	return 200
end

return M
