local var_0_0 = g.core.const.ConstMgr.ActivityConst
local var_0_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local var_0_2 = checkbool((g.core.common.Storage:load("activity_log_switch.json", false) or {}).openActLog)
local var_0_3 = g.core.common.ServerTime
local ActivityTimeData = class("ActivityTimeData")

function ActivityTimeData:ctor(arg_1_1)
	self._openedInServer = false
	self._serverLimit = 1
	self._serverLimitTimestamp = var_0_3:getTimeByOpenDay(self._serverLimit)
	self._activitySourceType = var_0_1.CUSTOM
	self._timeType = var_0_0.TIME_TYPE.RESIDENT
	self._previewTime, self._expireTime = -1, -1
	self._startTime, self._finishTime = -1, -1
	self._orgPreviewTime, self._orgExpireTime = -1, -1
	self._orgStartTime, self._orgFinishTime = -1, -1

	self:initTimeData(arg_1_1)
end

function ActivityTimeData:initTimeData(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._serverLimit = arg_2_1.serverLimit or 1
	self._activitySourceType = arg_2_1.activitySourceType or var_0_1.CUSTOM
	self._timeType = arg_2_1.timeType or var_0_0.TIME_TYPE.RESIDENT
	self._orgStartTime = arg_2_1.startTime or 0
	self._orgFinishTime = arg_2_1.finishTime or 0
	self._orgPreviewTime = arg_2_1.previewTime or self._orgStartTime
	self._orgExpireTime = arg_2_1.expireTime or self._orgFinishTime

	self:updateTimes()
end

function ActivityTimeData:updateTimes()
	self._serverLimitTimestamp = var_0_3:getTimeByOpenDay(self._serverLimit)

	if self._timeType == var_0_0.TIME_TYPE.RESIDENT then
		self._previewTime, self._expireTime = -1, -1
		self._startTime, self._finishTime = -1, -1
	elseif self._timeType == var_0_0.TIME_TYPE.TIME_STAMP or self._timeType == var_0_0.TIME_TYPE.CLEAN_TIME_STAMP then
		self._startTime = self._orgStartTime
		self._finishTime = self._orgFinishTime
		self._previewTime = self._orgPreviewTime
		self._expireTime = self._orgExpireTime
	elseif self._timeType == var_0_0.TIME_TYPE.NATURAL then
		self._startTime = self:_convertStr2Time(self._orgStartTime)
		self._finishTime = self:_convertStr2Time(self._orgFinishTime)
		self._previewTime = self:_convertStr2Time(self._orgPreviewTime)
		self._expireTime = self:_convertStr2Time(self._orgExpireTime)
	elseif self._timeType == var_0_0.TIME_TYPE.OPEN_SERVER then
		self._startTime = var_0_3:getTimeByOpenDay(self._orgStartTime)
		self._finishTime = var_0_3:getTimeByOpenDay(self._orgFinishTime)
		self._previewTime = var_0_3:getTimeByOpenDay(self._orgPreviewTime)
		self._expireTime = var_0_3:getTimeByOpenDay(self._orgExpireTime)
	elseif self._timeType == var_0_0.TIME_TYPE.CREATE_ROLE then
		self._startTime = var_0_3:getTimeByCreateRole(self._orgStartTime)
		self._finishTime = var_0_3:getTimeByCreateRole(self._orgFinishTime)
		self._previewTime = var_0_3:getTimeByCreateRole(self._orgPreviewTime)
		self._expireTime = var_0_3:getTimeByCreateRole(self._orgExpireTime)
	end

	self:logInfo()
end

function ActivityTimeData:logInfo()
	if not config.DEBUG_VERSION then
		return
	elseif not var_0_2 then
		return
	end

	local var_4_0 = g.core.log

	local function var_4_1(arg_5_0)
		if type(arg_5_0) == "number" and arg_5_0 > 0 then
			return var_0_3:getTimeString(self._orgPreviewTime)
		else
			return tostring(arg_5_0)
		end
	end

	g.core.log:info("--------------------      活动时间信息 begin     --------------------")

	local var_4_2 = var_0_3:getTime()

	var_4_0:info("当前时间：", var_0_3:getTimeString(var_4_2))
	var_4_0:info("当前是否在显示时间内：", tostring(self:isDuringDisplay(var_4_2)))
	var_4_0:info("当前是否在开启时间内：", tostring(self:isDuringOpening(var_4_2)))
	var_4_0:info(string.format("活动来源类型：%s = %d", tostring((table.keyof(var_0_1, self._activitySourceType))), self._activitySourceType))

	if self._timeType == var_0_0.TIME_TYPE.OPEN_SERVER then
		var_4_0:info("服务器是否开启了该活动：", tostring(self._openedInServer))
	end

	var_4_0:info(string.format("活动时间类型：%s = %d", tostring((table.keyof(var_0_0.TIME_TYPE, self._timeType))), self._timeType))
	var_4_0:info(string.format("活动开服时间限制：开服第 %d 天0点开始，活动可开启，即 %s", self._serverLimit, var_4_1(self._serverLimitTimestamp)))
	var_4_0:info("服务器下发或配置表配置的活动时间信息：")
	var_4_0:info(string.format("\t活动预览时间：%d ===> %s", self._orgPreviewTime, var_4_1(self._orgPreviewTime)))
	var_4_0:info(string.format("\t活动开始时间：%d ===> %s", self._orgStartTime, var_4_1(self._orgStartTime)))
	var_4_0:info(string.format("\t活动结束时间：%d ===> %s", self._orgFinishTime, var_4_1(self._orgFinishTime)))
	var_4_0:info(string.format("\t活动过期时间：%d ===> %s", self._orgExpireTime, var_4_1(self._orgExpireTime)))
	var_4_0:info("客户端处理后的活动时间信息：")
	var_4_0:info(string.format("\t活动预览时间：%d ===> %s", self._previewTime, var_4_1(self._previewTime)))
	var_4_0:info(string.format("\t活动开始时间：%d ===> %s", self._startTime, var_4_1(self._startTime)))
	var_4_0:info(string.format("\t活动结束时间：%d ===> %s", self._finishTime, var_4_1(self._finishTime)))
	var_4_0:info(string.format("\t活动过期时间：%d ===> %s", self._expireTime, var_4_1(self._expireTime)))
	var_4_0:info("--------------------      活动时间信息 end     --------------------")
end

function ActivityTimeData:isResident()
	return self._timeType == var_0_0.TIME_TYPE.RESIDENT
end

function ActivityTimeData:setOpenedInServer(arg_7_1)
	self._openedInServer = checkbool(arg_7_1)
end

function ActivityTimeData:getActivitySourceType()
	return self._activitySourceType
end

function ActivityTimeData:getTimeType()
	return self._timeType
end

function ActivityTimeData:getActivityState()
	if self._activitySourceType == var_0_1.CONFIG_TABLE then
		if self._timeType == var_0_0.TIME_TYPE.RESIDENT then
			return var_0_0.ACTIVITY_STATE.START
		elseif self._timeType == var_0_0.TIME_TYPE.OPEN_SERVER and not self._openedInServer then
			return var_0_0.ACTIVITY_STATE.EXPIRE
		end
	end

	local var_10_0 = var_0_3:getTime()
	local var_10_1 = math.max(self._serverLimitTimestamp, self._previewTime)

	if var_10_0 < var_10_1 then
		return var_0_0.ACTIVITY_STATE.BEFORE_PREVIEW
	elseif var_10_1 <= var_10_0 and var_10_0 < self._startTime then
		return var_0_0.ACTIVITY_STATE.PREVIEW
	elseif var_10_0 >= self._startTime and var_10_0 < self._finishTime then
		return var_0_0.ACTIVITY_STATE.START
	elseif var_10_0 >= self._finishTime and var_10_0 < self._expireTime then
		return var_0_0.ACTIVITY_STATE.END
	else
		return var_0_0.ACTIVITY_STATE.EXPIRE
	end
end

function ActivityTimeData:isDuringDisplay(arg_11_1)
	if self._activitySourceType == var_0_1.CONFIG_TABLE then
		if self._timeType == var_0_0.TIME_TYPE.RESIDENT then
			return true
		elseif self._timeType == var_0_0.TIME_TYPE.OPEN_SERVER then
			return self._openedInServer
		else
			arg_11_1 = arg_11_1 or var_0_3:getTime()

			return arg_11_1 >= self._previewTime and arg_11_1 < self._expireTime
		end
	else
		local var_11_0

		if not arg_11_1 then
			arg_11_1 = var_0_3:getTime()
			var_11_0 = arg_11_1 >= self._previewTime and arg_11_1 < self._expireTime
		end

		return arg_11_1 >= self._serverLimitTimestamp and var_11_0
	end
end

function ActivityTimeData:isDuringOpening(arg_12_1)
	if self._activitySourceType == var_0_1.CONFIG_TABLE then
		if self._timeType == var_0_0.TIME_TYPE.RESIDENT then
			return true
		else
			if self._timeType == var_0_0.TIME_TYPE.OPEN_SERVER and not self._openedInServer then
				return false
			end

			arg_12_1 = arg_12_1 or var_0_3:getTime()

			return arg_12_1 >= self._startTime and arg_12_1 < self._finishTime
		end
	else
		local var_12_0

		if not arg_12_1 then
			arg_12_1 = var_0_3:getTime()
			var_12_0 = arg_12_1 >= self._startTime and arg_12_1 < self._finishTime
		end

		return arg_12_1 >= self._serverLimitTimestamp and var_12_0
	end
end

function ActivityTimeData:getPreviewTime()
	return self._previewTime
end

function ActivityTimeData:getStartTime()
	return self._startTime
end

function ActivityTimeData:getFinishTime()
	return self._finishTime
end

function ActivityTimeData:getExpireTime()
	return self._expireTime
end

function ActivityTimeData:_convertStr2Time(arg_17_1)
	if string.match(arg_17_1, "%d+-%d+-%d+ %d+:%d+:%d+") then
		local var_17_0 = {}

		for iter_17_0 in string.gmatch(arg_17_1, "%d+") do
			table.insert(var_17_0, tonumber(iter_17_0))
		end

		return (os.time({
			year = var_17_0[1],
			month = var_17_0[2],
			day = var_17_0[3],
			hour = var_17_0[4],
			min = var_17_0[5],
			sec = var_17_0[6]
		}))
	else
		g.core.log:info("ActivityTimeData _convertStr2Time error time format: ", arg_17_1)

		return 0
	end
end

function ActivityTimeData:isActLogEnable()
	return var_0_2
end

function ActivityTimeData:setActLogEnable(arg_19_1)
	var_0_2 = checkbool(arg_19_1)
end

return ActivityTimeData
