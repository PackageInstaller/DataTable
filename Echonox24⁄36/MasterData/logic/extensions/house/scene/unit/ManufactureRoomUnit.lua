-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/ManufactureRoomUnit.lua

module("logic.extensions.house.scene.unit.ManufactureRoomUnit", package.seeall)

local M = class("ManufactureRoomUnit", HouseRoomUnit)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("goodsMgr", UnitCompRoomGoodsMgr)
end

return M
