-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/ShelterRoomUnit.lua

module("logic.extensions.house.scene.unit.ShelterRoomUnit", package.seeall)

local M = class("ShelterRoomUnit", HouseRoomUnit)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("goodsMgr", UnitCompRoomGoodsMgr)
	self:_addComponent("shelterPerform", UnitCompShelterRoomPerform)
	self:_addComponent("shelterBillboard", UnitCompShelterRoomBillBoard)
end

function M:getComponents(compName)
	local comp
	local len = #self._compList

	if len > 0 then
		comp = self[compName]
	end

	return comp
end

return M
