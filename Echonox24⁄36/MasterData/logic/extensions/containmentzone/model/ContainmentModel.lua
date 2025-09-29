-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/model/ContainmentModel.lua

module("logic.extensions.containmentzone.model.ContainmentModel", package.seeall)

local M = class("ContainmentModel", BaseModel)

function M:ctor()
	self._roomGroup = {}
	self._lastUpdateRoomLstTimeStamp = 0
	self._hasLoadAgentData = false
end

function M:onInit()
	return
end

function M:onReset()
	self._roomGroup = {}
	self._hasLoadAgentData = false
end

function M:getLastUpdateRoomLstTS()
	return self._lastUpdateRoomLstTimeStamp
end

function M:onUpdateJobSchedule(schedule)
	local roomIds = {}

	for i, v in ipairs(schedule or {}) do
		local workerCfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, v.job)

		if workerCfg and workerCfg.roomType == HouseEnum.RoomType.Shelter then
			roomIds[workerCfg.zoneId] = 1
		end
	end

	for theRoomId, _ in pairs(roomIds) do
		ContainmentZoneAgent.instance:sendGetSingleHoldRoomInfoRequest(theRoomId)
	end
end

function M:updateRoomInfoLst(dataLst)
	if dataLst and #dataLst > 0 then
		for k, v in ipairs(dataLst) do
			self:updateRoomInfo(v, false)
		end
	else
		printWarn("收容室数量为0")
	end

	self._hasLoadAgentData = true

	GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLDROOM_INFO_CHANGE)

	self._lastUpdateRoomLstTimeStamp = ServerTime.now()
end

function M:updateRoomInfo(data, needBroadCast)
	local roomId = data.roomId or data:getRoomId()

	if not self._roomGroup[roomId] then
		self._roomGroup[roomId] = ContainmentMo.New()
	end

	local theMo = self._roomGroup[roomId]

	theMo:updateFromServer(data)
	self:reflashRunningReport(roomId)
	ContainmentZoneAgent.instance:sendGetReportsRequest(roomId)

	local heroId = theMo:getHeroId()

	if heroId > 0 then
		HouseAgent.instance:sendGetSingleHeroFeatureRequest(heroId)
	end

	if needBroadCast then
		GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLDROOM_INFO_CHANGE)
	end
end

function M:hasLoadAgentData()
	return self._hasLoadAgentData
end

function M:getAllCanReceiveReportRoomInfo()
	local roomLst = {}

	for _, value in pairs(self._roomGroup or {}) do
		if value:getTotalReportCount() > 0 then
			table.insert(roomLst, value)
		end
	end

	return roomLst
end

function M:getRoomName(roomId)
	local roomInfoMo = self:getRoomInfoById(roomId)

	if roomInfoMo ~= nil then
		return roomInfoMo:getRoomName()
	else
		return self:getRoomIdName(roomId)
	end
end

function M:getRoomIdName(roomId)
	local showUpRoomId = roomId > 1100 and roomId - 1100 or roomId

	return string.format(lang("tip_house_holdroom_idname"), showUpRoomId)
end

function M:getRoomLv(roomId)
	return self._roomGroup[roomId] and self._roomGroup[roomId]:getRoomLv() or 0
end

function M:getRoomHeroCount(roomId)
	return self._roomGroup[roomId] and self._roomGroup[roomId]:getHeroCount() or 0
end

function M:getRoomInfoById(roomId)
	return self._roomGroup[roomId]
end

function M:getRoomInfoExist(roomId)
	return self._roomGroup[roomId] ~= nil
end

function M:getActiveRoomCount()
	return self._roomGroup and #self._roomGroup or 0
end

function M:getActiveRoomIds()
	local roomIds = {}

	for roomId, roomInfoMo in pairs(self._roomGroup or {}) do
		local showUpRoomId = roomId

		table.insert(roomIds, showUpRoomId)
	end

	return roomIds
end

function M:getHeroId(roomId)
	if self._roomGroup[roomId] == nil then
		return 0
	end

	return self._roomGroup[roomId]:getHeroId()
end

function M:getProtomerInfo(roomId)
	local protomerId = self:getProtomerId(roomId)

	if protomerId > 0 then
		return ProtomerModel.instance:getProtomerInfo(protomerId)
	else
		return nil
	end
end

function M:getProtomerId(roomId)
	if self._roomGroup[roomId] == nil then
		return 0
	end

	return self._roomGroup[roomId]:getProtomerId()
end

function M:removeRoomProtomerCache(roomId)
	if self._roomGroup[roomId] then
		self._roomGroup[roomId]:removeProtomer()
	end
end

function M:getRoomProtomerCanLvUp(roomId)
	local protomerInfo = self:getProtomerInfo(roomId)

	if protomerInfo == nil then
		return false
	end

	local canUpgradeModuleIdLst = protomerInfo:hasModuleCanUpGrade(protomerInfo:getModulePoint())

	return #canUpgradeModuleIdLst > 0
end

function M:getProductSpeed(roomId)
	if self._roomGroup[roomId] == nil then
		return 0
	end

	return self._roomGroup[roomId]:getProductSpeed()
end

function M:getRoomReportCount(roomId)
	if self._roomGroup[roomId] then
		return self._roomGroup[roomId]:getReportCount()
	end

	return 0
end

function M:getRoomFailReportCount(roomId)
	if self._roomGroup[roomId] then
		return self._roomGroup[roomId]:getFailReportCount()
	end

	return 0
end

function M:getAllRoomFailReportCount()
	local totalNum = 0

	for key, value in pairs(self._roomGroup or {}) do
		totalNum = totalNum + value:getFailReportCount()
	end

	return totalNum
end

function M:getRoomTotalReportCount(roomId)
	if self._roomGroup[roomId] then
		return self._roomGroup[roomId]:getTotalReportCount()
	end

	return 0
end

function M:getAllRoomTotalReportCount()
	local totalReportCount = 0

	for key, value in pairs(self._roomGroup or {}) do
		totalReportCount = totalReportCount + value:getTotalReportCount()
	end

	return totalReportCount
end

function M:getHasReportRoomCount()
	local roomCount = 0

	for key, value in pairs(self._roomGroup or {}) do
		if value:getTotalReportCount() > 0 then
			roomCount = roomCount + 1
		end
	end

	return roomCount
end

function M:decimal2bin(n)
	return bit._d2b(n)
end

function M:bin2decimal(binCodeTable)
	return bit._b2d(binCodeTable)
end

function M:getRunningReport(roomId)
	if not self._runningReport then
		self._runningReport = {}
	end

	if not self._runningReport[roomId] then
		self._runningReport[roomId] = self:createRunningReport(roomId)
	end

	return self._runningReport[roomId]
end

function M:setRunningReport(roomId, reportData)
	if not self._runningReport then
		self._runningReport = {}
	end

	self._runningReport[roomId] = reportData
end

function M:createRunningReport(roomId)
	local tmpReport = ContainmentReportMo.New()

	if self._roomGroup[roomId] == nil then
		tmpReport:createRunningReport(roomId, nil, 0)
		tmpReport:setIsVaild(false)
	else
		local roomInfo = self._roomGroup[roomId]
		local maxReportCount = ContainmentConfig.instance:getConstByKey("MaxReportCount")

		if maxReportCount <= roomInfo:getTotalReportCount() then
			tmpReport:createRunningReport(roomId, nil, 0)
			tmpReport:setIsVaild(false)
		else
			local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(roomInfo:getProtomerId())

			if protomerInfoMo then
				tmpReport:createRunningReport(roomId, protomerInfoMo, roomInfo:getHeroId())
				tmpReport:setIsVaild(true)
			else
				tmpReport:createRunningReport(roomId, nil, 0)
				tmpReport:setIsVaild(false)
			end
		end
	end

	self._runningReport[roomId] = tmpReport

	if tmpReport:getIsVaild() then
		self:reflashRunningReport(roomId)
	end

	return tmpReport
end

function M:reflashRunningReport(roomId)
	local roomInfoMo = self._roomGroup[roomId]
	local tmpReport = self:getRunningReport(roomId)

	if roomInfoMo == nil then
		tmpReport:setIsVaild(false)
	else
		local maxReportCount = ContainmentConfig.instance:getConstByKey("MaxReportCount")

		if maxReportCount <= roomInfoMo:getTotalReportCount() then
			tmpReport:setIsVaild(false)
		else
			local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(roomInfoMo:getProtomerId())

			if protomerInfoMo then
				tmpReport:setIsVaild(true)
			else
				tmpReport:setIsVaild(false)
			end
		end
	end

	if tmpReport:getIsVaild() then
		local protomerId = roomInfoMo:getProtomerId()
		local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)

		tmpReport:setProtomerId(protomerId)
		tmpReport:setHeroId(roomInfoMo:getHeroId())
		tmpReport:setTouchWay(protomerInfoMo:getTouchWay())

		local cfgProtomer = ContainmentConfig.instance:getProtomerCoById(protomerId)
		local p_total_need = cfgProtomer.productivity
		local p_now = protomerInfoMo:getProductivity()
		local p_remain_need = p_total_need - p_now
		local p_base = ContainmentConfig.instance:getConstByKey("BaseDefaultProduction")
		local p_hero = roomInfoMo:getProductHero()
		local p_house_multi = roomInfoMo:getProductHouseRatio()
		local t_lastUpdateTS = roomInfoMo:getUpdateTimeStamp()
		local t_perScheduleTime = HouseMainEnum.ServerScheduleTime
		local t_scheduleTime = roomInfoMo:getScheduleTime()
		local v_speed = (p_base + p_hero) * (1 + p_house_multi)

		v_speed = roomInfoMo:getProductSpeed()

		local result_t_totalTime_minute = math.ceil(p_total_need / v_speed)
		local remainSecond = 0

		if p_remain_need <= 0 then
			remainSecond = t_scheduleTime
		else
			local p_next_Schedule = p_now + v_speed
			local p_next_remain_need = p_total_need - p_next_Schedule

			p_next_remain_need = p_next_remain_need < 0 and 0 or p_next_remain_need
			remainSecond = remainSecond + t_scheduleTime

			if p_next_remain_need > 0 then
				local tmp_remainMinute = math.floor(p_next_remain_need / v_speed)

				if p_next_remain_need / v_speed - tmp_remainMinute > 0 then
					remainSecond = remainSecond + t_perScheduleTime
				end

				remainSecond = tmp_remainMinute * t_perScheduleTime + remainSecond
			end
		end

		tmpReport:setRunningReportTotalSecond(result_t_totalTime_minute * t_perScheduleTime)
		tmpReport:setRunningReportRemainSecond(remainSecond)
		tmpReport:setRunningReportUpdateTimeStamp(t_lastUpdateTS)
		tmpReport:setRunningReportSpeed(v_speed)
	end
end

M.instance = M.New()

return M
