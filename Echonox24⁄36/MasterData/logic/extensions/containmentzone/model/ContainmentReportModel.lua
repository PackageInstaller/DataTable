-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/model/ContainmentReportModel.lua

module("logic.extensions.containmentzone.model.ContainmentReportModel", package.seeall)

local M = class("ContainmentReportModel", BaseModel)

function M:ctor()
	self._roomReport = {}
	self._unReadFailReport = {}
end

function M:onInit()
	return
end

function M:onReset()
	self._roomReport = {}
	self._unReadFailReport = {}
	self._unReadFailReportCount = {}
end

function M:getCanReceiveReportCount(roomId)
	local count = 0

	if self._roomReport[roomId] then
		for key, value in pairs(self._roomReport[roomId]) do
			count = count + (value:getRecive() and 0 or 1)
		end
	end

	return count
end

function M:getCanReceiveReportLst(roomId)
	local reportLst = {}

	if self._roomReport[roomId] then
		for _, value in pairs(self._roomReport[roomId]) do
			if not value:getRecive() then
				table.insert(reportLst, value)
			end
		end
	end

	return reportLst
end

function M:getAllRoomCanReceiveReport()
	local allReport = {}

	for roomId, rLst in pairs(self._roomReport or {}) do
		for uuid, reportData in pairs(rLst or {}) do
			if not reportData:getRecive() then
				table.insert(allReport, reportData)
			end
		end
	end

	return allReport
end

function M:getReportLst(roomId)
	if self._roomReport[roomId] then
		return self._roomReport[roomId]
	else
		return {}
	end
end

function M:getReportByRoomIdAndUuid(roomId, uuid)
	if self._roomReport[roomId] then
		return self._roomReport[roomId][uuid]
	end

	return nil
end

function M:updateNewReportLst(dataLst)
	if dataLst and #dataLst > 0 then
		for index, value in ipairs(dataLst) do
			print(string.format("<color=#00FFFF>接受推送报告[%s],收容室[%d],failLv[%d]</color>", value.uuid, value.roomId, value.failLevel))
			self:updateRoomReport(value, false, true)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLDROOM_REPORT_CHANGE)
end

function M:updateSpeedUpReport(data, broadcastChange, broadcastBreach)
	if data ~= nil then
		print(string.format("<color=#00FFFF>加速报告[%s],收容室[%d],failLv[%d],read[%s]</color>", data.uuid, data.roomId, data.failLevel, data.read))
		self:updateRoomReport(data, broadcastChange, broadcastBreach)
	end
end

function M:updateRoomReportLst(dataLst)
	if dataLst and #dataLst > 0 then
		local roomId = dataLst[1].roomId or 0

		for index, value in ipairs(dataLst) do
			self:updateRoomReport(value, false)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLDROOM_REPORT_CHANGE)
end

function M:updateRoomReport(data, broadcastChange, broadcastBreach)
	local theMo

	if data == nil then
		return theMo
	end

	local roomId = data.roomId
	local uuid = data.uuid

	if not self._roomReport[roomId] then
		self._roomReport[roomId] = {}
	end

	if not self._roomReport[roomId][uuid] then
		self._roomReport[roomId][uuid] = ContainmentReportMo.New()
	end

	theMo = self._roomReport[roomId][uuid]

	theMo:updateFromServer(data)

	if broadcastChange then
		GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLDROOM_REPORT_CHANGE)
	end

	if broadcastBreach and data.failLevel > 0 then
		local info = {}

		info.roomId = data.roomId
		info.uuid = data.uuid
		info.protomerId = data.protomerId
		info.failLevel = data.failLevel
		info.heroId = data.heroId
		info.touchWay = data.touchWay
		info.totalDuration = theMo:getFailEffectByCode(4)

		print(string.format("<color=#00FFFF>---收容失效广播:收容室[%d],heroId[%d],failLv[%d],duration[%d]</color>", data.roomId, data.heroId, data.failLevel, info.totalDuration))
		GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLDROOM_CONTAINMENT_BREACH, info)
	end

	if not data.receive and data.failLevel > 0 and not data.read then
		self:addUnReadFailReport(data.roomId, data.uuid)
	end

	return theMo
end

function M:reciveReportLst(reportDataLst)
	local recReportLst = {}

	if reportDataLst and #reportDataLst > 0 then
		for index, value in ipairs(reportDataLst) do
			local theReport = self:updateRoomReport(value, false)

			table.insert(recReportLst, theReport)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLDROOM_REPORT_CHANGE)
	GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLD_REPORT_RECEIVE, recReportLst)
end

function M:reciveReport(reportData)
	local recReportLst = {}
	local theReport = self:updateRoomReport(reportData, true)

	table.insert(recReportLst, theReport)
	GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLD_REPORT_RECEIVE, recReportLst)

	return theReport
end

function M:getAllUnReadFailReportInfoLst()
	local lst = {}

	for roomId, rLst in pairs(self._roomReport or {}) do
		local theRoomId = roomId

		if self._unReadFailReport[theRoomId] then
			for uuid, report in pairs(rLst or {}) do
				if self._unReadFailReport[theRoomId][uuid] then
					table.insert(lst, report)
				end
			end
		end
	end

	return lst
end

function M:addUnReadFailReport(roomId, uuid)
	if not self._unReadFailReport then
		self._unReadFailReport = {}
	end

	if not self._unReadFailReport[roomId] then
		self._unReadFailReport[roomId] = {}
	end

	self._unReadFailReport[roomId][uuid] = 1

	self:saveUnReadFailReportLst(roomId)
end

function M:removeUnReadFailReport(roomId)
	local uuidLst = {}

	for uuid, _ in pairs(self._unReadFailReport[roomId] or {}) do
		table.insert(uuidLst, uuid)
	end

	self._unReadFailReport[roomId] = {}

	self:saveUnReadFailReportLst(roomId)

	if #uuidLst > 0 then
		ContainmentZoneAgent.instance:sendSetReportsReadRequest(uuidLst)
	end
end

function M:removeSingleUnReadFailReport(roomId, uuid)
	if self._unReadFailReport and self._unReadFailReport[roomId] and self._unReadFailReport[roomId][uuid] then
		self._unReadFailReport[roomId][uuid] = nil

		self:saveUnReadFailReportLst(roomId)

		local uuidLst = {}

		table.insert(uuidLst, uuid)
		ContainmentZoneAgent.instance:sendSetReportsReadRequest(uuidLst)
	end
end

function M:removeAllUnReadFailReport()
	local uuidLst = {}

	for roomId, roomUuidLst in pairs(self._unReadFailReport or {}) do
		for uuid, _ in pairs(roomUuidLst or {}) do
			table.insert(uuidLst, uuid)
		end

		self._unReadFailReport[roomId] = {}
	end

	self:saveAllUnReadFailReportLst()

	if #uuidLst > 0 then
		ContainmentZoneAgent.instance:sendSetReportsReadRequest(uuidLst)
	end
end

function M:saveUnReadFailReportLst(roomId)
	local totalCount = 0

	for uuid, _ in pairs(self._unReadFailReport[roomId] or {}) do
		totalCount = totalCount + 1
	end

	self:setUnReadFailReportCount(roomId, totalCount)
	self:_afterSaveUnReadFailReport()
end

function M:saveAllUnReadFailReportLst()
	for roomId, ulst in pairs(self._unReadFailReport or {}) do
		local totalCount = 0

		for uuid, _ in pairs(ulst) do
			totalCount = totalCount + 1
		end

		self:setUnReadFailReportCount(roomId, totalCount)
	end

	self:_afterSaveUnReadFailReport()
end

function M:_afterSaveUnReadFailReport()
	local failReportNum = self:getAllUnReadFailReportCount()

	HouseMainRoomModel.instance:setBackLogNum(HouseMainEnum.BackLogTyp.failReportNum, failReportNum)
end

function M:setUnReadFailReportCount(roomId, count)
	if not self._unReadFailReportCount then
		self._unReadFailReportCount = {}
	end

	self._unReadFailReportCount[roomId] = count
end

function M:getUnReadFailReportCount(roomId)
	if not self._unReadFailReportCount then
		self._unReadFailReportCount = {}
	end

	return self._unReadFailReportCount[roomId] or 0
end

function M:getAllUnReadFailReportCount()
	local totalCount = 0

	for key, value in pairs(self._unReadFailReportCount or {}) do
		totalCount = totalCount + value
	end

	return totalCount
end

M.instance = M.New()

return M
