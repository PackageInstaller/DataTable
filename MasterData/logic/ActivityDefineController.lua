-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/controller/ActivityDefineController.lua

module("logic.extensions.scratch.controller.ActivityDefineController", package.seeall)

local ActivityDefineController = class("ActivityDefineController", BaseController)

function ActivityDefineController:ctor()
	self._originTime = os.time({
		hour = 0,
		month = 1,
		year = 2000,
		min = 0,
		sec = 0,
		day = 1
	})
end

function ActivityDefineController:onInit()
	self:onReset()
end

function ActivityDefineController:onReset()
	self._foreverActTime = nil
end

function ActivityDefineController:getActTimeShow(activityId)
	local activityType = self:getActTypeByActId(activityId)
	local cfg = ActivityDefineConfig.instance:getCfgById(activityType, activityId)

	return cfg and self:getActTimeDesc(activityType, activityId) or "活动时间：--"
end

local dayTimestamp = 86400

function ActivityDefineController:getActTimeShowWithOpenDay(activityId, openDay)
	if openDay == nil and enableDebug then
		printError(">>>>>>>>>>>>>> 注意查看代码或者配置 ！！")
	end

	openDay = checknumber(openDay)

	local nowTime = ServerTime.now()
	local activityType = self:getActTypeByActId(activityId)
	local startTimestamp, endTimestamp = self:getStartTimeAndEndTime(activityType, activityId)
	local offsetDay = checknumber(openDay) - 1
	local startTime = startTimestamp + dayTimestamp * offsetDay

	if startTime <= nowTime and nowTime < endTimestamp then
		return "", false
	else
		local date = GameUtil.time2date(startTime)
		local str = langPara("%s.%s.%s 开启", date.year, date.month, date.day)

		return str, true
	end
end

function ActivityDefineController:getActTimeDesc(activityType, activityId, timeFormat, showType)
	local stime, etime = self:getStartTimeAndEndTime(activityType, activityId)

	return self:getTimeDescByStamp(stime, etime, timeFormat, showType)
end

function ActivityDefineController:getTimeDescByStamp(stime, etime, timeFormat, showType)
	timeFormat = timeFormat or "活动时间：%s"

	if self._foreverActTime == nil then
		self._foreverActTime = GameUtil.string2time(GameUtil.ForeverActTimeString)
	end

	if etime >= self._foreverActTime then
		return string.format(timeFormat, "常驻")
	else
		local timeTxt = GameUtil.getTimeTxt(stime, etime, showType or GameEnum.TimeTxt.M_D_H)

		return string.format(timeFormat, timeTxt)
	end
end

function ActivityDefineController:getActTypeByActId(activityId)
	return (math.floor(activityId / 1000))
end

function ActivityDefineController:checkIsInActivityTimeByActivityId(activityId)
	activityId = checknumber(activityId)

	return self:isInActivityTimeById(self:getActTypeByActId(activityId), activityId)
end

function ActivityDefineController:isTimeGateProcessType(activityId)
	local activityType = self:getActTypeByActId(activityId)
	local cfg = ActivityDefineConfig.instance:getCfgById(activityType, activityId)

	return cfg and cfg.processType == 5
end

function ActivityDefineController:isAoqiGodProcessType(activityId)
	local activityType = self:getActTypeByActId(activityId)
	local cfg = ActivityDefineConfig.instance:getCfgById(activityType, activityId)

	return cfg and cfg.processType == 6
end

function ActivityDefineController:isInActivityTimeById(activityType, activityId)
	local cfg = ActivityDefineConfig.instance:getCfgById(activityType, activityId)

	if cfg then
		if self:isRelateServerBy(cfg.relatedAreaIds) and self:_isInActivityTimeByCfg(cfg) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function ActivityDefineController:isInActivityNotOverTimeById(activityType, activityId)
	local cfg = ActivityDefineConfig.instance:getCfgById(activityType, activityId)

	if cfg then
		if self:isRelateServerBy(cfg.relatedAreaIds) then
			local boo, type = self:checkIsInTime(cfg.processType, cfg.startDay, cfg.durationDay, cfg.startTime, cfg.endTime)

			if boo and type ~= GameUtil.afterTimePeriod then
				return true
			end
		else
			return false
		end
	else
		return false
	end
end

function ActivityDefineController:isCurServerAvailable(activityType)
	local cfg = self:getActivityCfgByType(activityType)

	if cfg then
		return true
	else
		return false
	end
end

function ActivityDefineController:getActTimePeriod(activityType, activityId)
	local startTimeStamp, endTimeStamp = self:getStartTimeAndEndTime(activityType, activityId)

	return GameUtil.getTimePeriodTypeBySec(startTimeStamp, endTimeStamp)
end

function ActivityDefineController:getStartTimeAndEndTime(activityType, activityId)
	local cfg = ActivityDefineConfig.instance:getCfgById(activityType, activityId)

	if not cfg then
		printError("test getStartTimeAndEndTime 配置不存在", activityType, activityId)

		return self._originTime, self._originTime
	end

	if cfg.processType == 1 then
		local openTimestamp = RoleModel.instance:getAreaOpenTimeSec()

		return GameUtil.getTimestampOnStartAndEnd(openTimestamp, cfg.startDay, cfg.durationDay)
	elseif cfg.processType == 2 then
		local createTimestamp = RoleModel.instance:getActiveTimeSec()

		return GameUtil.getTimestampOnStartAndEnd(createTimestamp, cfg.startDay, cfg.durationDay)
	elseif cfg.processType == 3 then
		return self:_getStartAndEndTimestamp(GameUtil.string2time(cfg.startTime), GameUtil.string2time(cfg.endTime))
	elseif cfg.processType == 5 then
		return GameUtil.getStartAndEndInWeek(ServerTime.now())
	elseif cfg.processType == 6 then
		return AoqiGodController.instance:getStartTimeAndEndTime()
	else
		return GameUtil.string2time(cfg.startTime), GameUtil.string2time(cfg.endTime)
	end
end

function ActivityDefineController:isRelateServerBy(relatedAreaIds)
	if string.nilorempty(relatedAreaIds) then
		return false
	end

	if relatedAreaIds == "all" then
		return true
	end

	local areaId = RoleModel.instance:getAreaId()
	local strList = string.split(relatedAreaIds, "#")

	for i, v in ipairs(strList) do
		if string.find(v, "-") then
			local startId, endId = string.match(v, "(%d+)-(%d+)")

			if startId and endId then
				if areaId >= checknumber(startId) and areaId <= checknumber(endId) then
					return true
				end
			else
				printError("test 起始id或者结束id不存在", startId, endId)
			end
		else
			local serverId = tonumber(v) or -1

			if serverId == areaId then
				return true
			end
		end
	end

	return false
end

function ActivityDefineController:getActivityCfgByType(activityType)
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(activityType)

	for i, cfg in ipairs(cfgs) do
		if self:isRelateServerBy(cfg.relatedAreaIds) and self:_isInActivityTimeByCfg(cfg) then
			return cfg
		end
	end

	return nil
end

function ActivityDefineController:getActivityIdByType(activityType)
	local cfg = self:getActivityCfgByType(activityType)

	if cfg then
		return cfg.activityId
	else
		return 0
	end
end

function ActivityDefineController:_isInActivityTimeByCfg(cfg)
	if UltimateTrialController.instance:isUltTrialClg(cfg.activityId) then
		return UltimateTrialController.instance:isInUltTrialTime(cfg.activityId)
	end

	return self:checkIsInTime(cfg.processType, cfg.startDay, cfg.durationDay, cfg.startTime, cfg.endTime)
end

function ActivityDefineController:checkIsInTime(processType, startDay, durationDay, startTime, endTime)
	if processType == 1 then
		local type = GameUtil.getOpenDayPeriodType(startDay, durationDay)

		return type == GameUtil.inTimePeriod, type
	elseif processType == 2 then
		local type = GameUtil.getCreateRoleDayPeriodType(startDay, durationDay)

		return type == GameUtil.inTimePeriod, type
	elseif processType == 3 then
		local openDays = GameUtil.getOpenAreaDaysForFive()

		if openDays <= 7 then
			return false, GameUtil.beforeTimePeriod
		else
			local type = GameUtil.getTimePeriodType(startTime, endTime)

			return type == GameUtil.inTimePeriod, type
		end
	elseif processType == 4 then
		local type = GameUtil.getTimePeriodType(startTime, endTime)

		return type == GameUtil.inTimePeriod, type
	elseif processType == 5 then
		return true, GameUtil.inTimePeriod
	elseif processType == 6 then
		local startTime, endTime = AoqiGodController.instance:getStartTimeAndEndTime()
		local type = GameUtil.getTimePeriodTypeBySec(startTime, endTime)

		return type == GameUtil.inTimePeriod, type
	end

	return false, GameUtil.errorTimePeriod
end

function ActivityDefineController:getActivityPeriodByType(activityType)
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(activityType)

	if cfgs and #cfgs > 0 then
		local earliestTime, earliestTarget, latestTime, latestTarget

		for i, cfg in ipairs(cfgs) do
			if self:isRelateServerBy(cfg.relatedAreaIds) == true then
				if cfg.processType == 4 or cfg.processType == 3 then
					local timeStart = GameUtil.string2time(cfg.startTime)
					local timeEnd = GameUtil.string2time(cfg.endTime)

					if earliestTarget == nil or timeStart < earliestTime then
						earliestTarget = cfg.startTime
						earliestTime = timeStart
					end

					if latestTarget == nil or latestTime < timeEnd then
						latestTarget = cfg.endTime
						latestTime = timeEnd
					end
				else
					if earliestTarget == nil or earliestTarget > cfg.startDay then
						earliestTarget = cfg.startDay
					end

					if latestTarget == nil or latestTime < cfg.startDay + cfg.durationDay then
						latestTarget = cfg.startDay + cfg.durationDay
						latestTime = cfg.startDay + cfg.durationDay
					end
				end
			end
		end

		if cfgs[1].processType == 1 then
			return GameUtil.getOpenDayPeriodType(earliestTarget, latestTarget - earliestTarget)
		elseif cfgs[1].processType == 2 then
			return GameUtil.getCreateRoleDayPeriodType(earliestTarget, latestTarget)
		elseif cfgs[1].processType == 3 then
			local openDays = GameUtil.getOpenAreaDaysForFive()

			if openDays <= 7 then
				return GameUtil.beforeTimePeriod
			else
				return GameUtil.getTimePeriodType(earliestTarget, latestTarget)
			end
		else
			return GameUtil.getTimePeriodType(earliestTarget, latestTarget)
		end
	else
		return GameUtil.inTimePeriod
	end
end

function ActivityDefineController:_getStartAndEndTimestamp(startTime, endTime)
	startTime = GameUtil.string2time(startTime)
	endTime = GameUtil.string2time(endTime)

	local openTimestamp = RoleModel.instance:getAreaOpenTimeSec()
	local startTimestamp, endTimestamp = GameUtil.getTimestampOnStartAndEnd(openTimestamp, 1, 7)
	local resultStartTime = startTime

	if startTime <= endTimestamp then
		resultStartTime = endTimestamp
	end

	return resultStartTime, (endTime <= endTimestamp or nil) and endTimestamp
end

function ActivityDefineController:isInTimeForMultiplyReward(effectType, id)
	local list = ActivityPopupConfig.instance:getCfgByEffectType(effectType)

	for i, v in ipairs(list) do
		if self:_isIdMatch(v.validatorParam, id) then
			local isInTime = self:isInActivityTimeById(GameEnum.ActivityType.Double, v.id)

			if isInTime then
				local startTime, endTime = self:getStartTimeAndEndTime(GameEnum.ActivityType.Double, v.id)

				return true, v.title, startTime, endTime, v
			end
		end
	end

	return false, ""
end

function ActivityDefineController:_isIdMatch(validatorParam, id)
	if string.nilorempty(validatorParam) then
		return true
	end

	if not id then
		return true
	end

	local params = string.split(validatorParam, ",")
	local strId = tostring(id)

	for k, v in pairs(params) do
		if v == strId then
			return true
		end
	end

	return false
end

function ActivityDefineController:getActivityCurrentDay(inputActivityId)
	local activityId = checknumber(inputActivityId)
	local activityType = self:getActTypeByActId(activityId)
	local cfg = ActivityDefineConfig.instance:getCfgById(activityType, activityId)

	if not cfg then
		print("test getActivityCurrentDay 配置不存在", activityType, activityId)

		return -1
	end

	if cfg.processType ~= 3 and cfg.processType ~= 4 then
		print("test getActivityCurrentDay 只适用于绝对时间的常规活动", activityType, activityId, cfg.processType)

		return -1
	end

	local startTime, endTime = GameUtil.string2time(cfg.startTime), GameUtil.string2time(cfg.endTime)
	local nowTime = ServerTime.now()

	if startTime <= nowTime and nowTime <= endTime then
		return GameUtil.getDaysByTimestamp(startTime, ServerTime.now())
	else
		print("test getActivityCurrentDay 不在活动时间内", activityType, activityId)

		return -1
	end
end

ActivityDefineController.instance = ActivityDefineController.New()

return ActivityDefineController
