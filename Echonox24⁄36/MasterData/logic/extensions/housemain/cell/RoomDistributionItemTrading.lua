-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomDistributionItemTrading.lua

module("logic.extensions.housemain.cell.RoomDistributionItemTrading", package.seeall)

local M = class("RoomDistributionItemTrading", RoomDistributionItemCell)

function M:onCellBindUI()
	return
end

function M:onCellDestroyUI()
	return
end

function M:onCellBindEvents()
	return
end

function M:onCellUnBindEvents()
	return
end

function M:onCellEnter()
	return
end

function M:onCellExit()
	return
end

function M:onCellClick()
	return
end

function M:onCellSetData()
	self:updateWorkingStateHint(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
	self:updateProcess(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
	self:updateSign(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
end

function M:updateWorkingStateHint(roomId, roomType, roomOpenState)
	local orderFull = self:_orderFull()
	local storeFull = self:_storeFull()
	local hint = orderFull and string.format("<color=#fc7171>%s</color>", lang("tip_stop")) or lang("tip_production")

	self._txtHint.text = hint
end

function M:updateSign(roomId, roomType, roomOpenState)
	local rootType = 1

	self:hideSign()

	local orderFull = self:_orderFull()
	local signMark = HouseMainEnum.SignMark.TradeOrderFull

	if orderFull then
		self:createSign(signMark, rootType)
	end

	local storeFull = self:_storeFull()

	signMark = HouseMainEnum.SignMark.TradeStorageFull

	if storeFull then
		self:createSign(signMark, rootType)
	end
end

function M:updateProcess(roomId, roomType, roomOpenState)
	local orderFull = self:_orderFull()

	if orderFull then
		self:setProgress(true, 100)
	else
		local progress = TradingModel.instance:getTotalProductProgress()

		self:setProgress(true, progress * 100)
	end
end

function M:_orderFull()
	local point = HouseMainRoomModel.instance:getBackLogTypNum(HouseMainEnum.BackLogTyp.tradeOrderFull)

	return point > 0
end

function M:_storeFull()
	local point = HouseMainRoomModel.instance:getBackLogTypNum(HouseMainEnum.BackLogTyp.tradeGoodsFull)

	return point > 0
end

return M
