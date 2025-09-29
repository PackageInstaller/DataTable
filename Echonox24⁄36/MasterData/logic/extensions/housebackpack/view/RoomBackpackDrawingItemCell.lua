-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackDrawingItemCell.lua

module("logic.extensions.housebackpack.view.RoomBackpackDrawingItemCell", package.seeall)

local M = class("RoomBackpackDrawingItemCell", BackpackItemCell)

function M:Awake()
	M.super.Awake(self)

	local numComp = self:getComponent("num")

	numComp:setVisible(false)
end

return M
