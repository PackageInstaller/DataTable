-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomDistributionItemSupervisor.lua

module("logic.extensions.housemain.cell.RoomDistributionItemSupervisor", package.seeall)

local M = class("RoomDistributionItemSupervisor", RoomDistributionItemCell)

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
	local storeFull = self:_storeFull()
	local hint = storeFull and string.format("<color=#fc7171>%s</color>", lang("tip_stop")) or lang("tip_production")

	self._txtHint.text = hint
end

function M:updateSign(roomId, roomType, roomOpenState)
	local rootType = 1

	self:hideSign()

	local storeFull = self:_storeFull()
	local signMark = HouseMainEnum.SignMark.TradeStorageFull

	if storeFull then
		self:createSign(signMark, rootType)
	end
end

function M:updateProcess(roomId, roomType, roomOpenState)
	local supervisorLv = SupervisorModel.instance:getSupervisorLv()

	if supervisorLv then
		local limit = SupervisorModel.instance:getLimitStore()
		local curStore = SupervisorModel.instance:getCurrStore()
		local process = curStore / limit

		process = math.floor(process * 100)

		self:setProgress(true, process)
	end
end

function M:_storeFull()
	local supervisorLv = SupervisorModel.instance:getSupervisorLv()

	if supervisorLv then
		return SupervisorModel.instance:isStoreFulled()
	end

	return false
end

return M
