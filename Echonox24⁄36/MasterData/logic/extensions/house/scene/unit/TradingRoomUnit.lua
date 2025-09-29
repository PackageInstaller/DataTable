-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/TradingRoomUnit.lua

module("logic.extensions.house.scene.unit.TradingRoomUnit", package.seeall)

local M = class("TradingRoomUnit", HouseRoomUnit)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("goodsMgr", UnitCompRoomGoodsMgr)
end

return M
