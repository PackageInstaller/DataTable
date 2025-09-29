-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomDistributionItemShelter.lua

module("logic.extensions.housemain.cell.RoomDistributionItemShelter", package.seeall)

local M = class("RoomDistributionItemShelter", RoomDistributionItemCell)

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

function M:reflashData()
	M.super.reflashData(self)

	if self:getRoomOpenState() == HouseMainEnum.RoomOpenTyp.OpenActive then
		local protomerId = ContainmentModel.instance:getProtomerId(self:getRoomId())
		local working = protomerId > 0

		goutil.setActive(self._goTypRootNormal, working)
		goutil.setActive(self._goTypeUnUse, not working)
	end
end

function M:onCellSetData()
	self:updateWorkingStateHint(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
	self:updateProcess(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
	self:updateSign(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
end

function M:updateWorkingStateHint(roomId, roomType, roomOpenState)
	local hint

	if roomOpenState == HouseMainEnum.RoomOpenTyp.OpenUnActive then
		hint = lang("tip_no_activate")
	else
		local protomerId = ContainmentModel.instance:getProtomerId(roomId)

		if protomerId > 0 then
			local roomRunningReport = ContainmentModel.instance:getRunningReport(roomId)

			hint = roomRunningReport:getIsVaild() and lang("tip_working") or string.format("<color=#fc7171>%s</color>", lang("tip_stop"))
		else
			hint = lang("tip_in_the_free")
		end
	end

	self._txtHint.text = hint
end

function M:updateSign(roomId, roomType, roomOpenState)
	local maxReportNum = ContainmentConfig.instance:getConstByKey("MaxReportCount")
	local reportNum = ContainmentModel.instance:getRoomReportCount(roomId)
	local reportFailNum = ContainmentModel.instance:getRoomFailReportCount(roomId)
	local signMark
	local rootType = 1

	self:hideSign()

	signMark = HouseMainEnum.SignMark.TradeStorageFull

	if maxReportNum <= reportNum then
		-- block empty
	end

	signMark = HouseMainEnum.SignMark.HoldReportFail

	if reportFailNum > 0 then
		self:createSign(signMark, rootType)
	end
end

function M:updateProcess(roomId, roomType, roomOpenState)
	local roomOpenTyp = HouseMainEnum.RoomOpenTyp

	if roomOpenState == roomOpenTyp.OpenActive then
		local reportNum = ContainmentModel.instance:getRoomTotalReportCount(roomId)
		local maxReportNum = ContainmentConfig.instance:getConstByKey("MaxReportCount") or 10
		local process = reportNum / maxReportNum

		process = math.floor(process * 100)

		self:setProgress(true, process)
	else
		self:setProgress(false)
	end
end

return M
