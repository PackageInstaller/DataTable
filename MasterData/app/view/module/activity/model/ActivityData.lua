local var_0_0 = g.core.const.ConstMgr.ActivityConst
local var_0_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local ActivityConfig = require("app.view.module.activity.const.ActivityConfig")
local var_0_3 = "EMPTY"
local var_0_4 = checknumber((g.core.common.Storage:load("activity_log_switch.json", false) or {}).logActType)
local ActivityData = class("ActivityData", require("app.view.module.activity.model.ActivityTimeData"))

function ActivityData:ctor(arg_1_1)
	self.super.ctor(self)

	self._activityType = nil
	self._activityValue = nil
	self._functionId = nil
	self._inActivityMainLayer = false
	self._activityName = var_0_3
	self._compName = ""
	self._info = {}
	self._activityConfig = {}

	self:initParams(arg_1_1)
end

function ActivityData:initParams(arg_2_1)
	self:_initTimeData(arg_2_1)

	arg_2_1 = arg_2_1 or {}
	self._activityType = arg_2_1.activityType
	self._activityValue = arg_2_1.activityValue

	local var_2_0 = arg_2_1.info or {}

	if var_2_0.toObject then
		var_2_0 = var_2_0:toObject()
	end

	self._info = var_2_0

	if self._activityType and ActivityConfig[self._activityType] then
		self._inActivityMainLayer = true
		self._activityConfig = ActivityConfig[self._activityType]
	else
		self._activityConfig = {}
	end

	self._functionId = var_2_0.function_id or self._activityConfig.functionId
	self._activityName = self._activitySourceType == var_0_1.CONFIG_TABLE and var_2_0.name or var_2_0.title
	self._compName = self._activityConfig.compName
end

function ActivityData:_initTimeData(arg_3_1)
	local var_3_0 = arg_3_1.info or {}

	if arg_3_1.activitySourceType == var_0_1.CONFIG_TABLE then
		self:initTimeData({
			activitySourceType = arg_3_1.activitySourceType,
			timeType = var_3_0.time_type,
			previewTime = var_3_0.open_time,
			startTime = var_3_0.open_time,
			finishTime = var_3_0.finish_time,
			expireTime = var_3_0.reward_finish_time
		})
	else
		self:initTimeData({
			activitySourceType = arg_3_1.activitySourceType,
			timeType = var_3_0.time_type,
			serverLimit = var_3_0.server_limit,
			previewTime = var_3_0.preview_time,
			startTime = var_3_0.start_time,
			finishTime = var_3_0.finish_time,
			expireTime = var_3_0.expire_time
		})
	end
end

function ActivityData:logInfo()
	if not config.DEBUG_VERSION then
		return
	elseif not self:isActLogEnable() then
		return
	elseif var_0_4 > 0 and var_0_4 ~= self._activityType then
		return
	end

	local var_4_0 = g.core.log

	g.core.log:info("======================      活动信息 begin     =======================")
	var_4_0:info("活动：", self:getActivityName())
	var_4_0:info("活动是否显示：", tostring(self:isShow()))
	var_4_0:info("活动是否开启：", tostring(self:isOpen()))
	var_4_0:info(string.format("actType = %s, configActValue = %s", tostring(self._activityType), tostring(self:getConfigActivityValue())))
	var_4_0:info("功能id：", tostring(self:getFunctionId()))
	self.super.logInfo(self)
	var_4_0:info("======================      活动信息 end     =======================")
end

function ActivityData:getActivityId()
	return self._info.id
end

function ActivityData:getActivityType()
	return self._activityType
end

function ActivityData:getStartTime()
	return self._startTime
end

function ActivityData:getActivityValue()
	return self._activityValue
end

function ActivityData:getConfigActivityValue()
	if self:getActivitySourceType() == var_0_1.CUSTOM and self._info and self._info.sub_activity_id then
		return self._info.sub_activity_id
	end

	return self._activityValue
end

function ActivityData:getFunctionId()
	return self._functionId
end

function ActivityData:getSortWeight()
	return self._info.sort or 1
end

function ActivityData:getActivityName()
	return self._activityName or var_0_3
end

function ActivityData:getTabIconConfig()
	return self._activityConfig.tabIconConfig
end

function ActivityData:getCompName()
	return self._compName
end

function ActivityData:getBg()
	return self._activityConfig.bg
end

function ActivityData:getTopBarId()
	return self._activityConfig.topBarId or 1
end

function ActivityData:getInfo()
	return self._info
end

function ActivityData:_isUserLvMeet()
	if self._activitySourceType == var_0_0.ACTIVITY_SOURCE_TYPE.CUSTOM then
		return ((not self._info.min_level or nil) and 0) <= g.core.model.User:getLevel()
	end

	return true
end

function ActivityData:isShow()
	if not self:isDuringDisplay() then
		return false
	end

	if self._functionId and self._functionId ~= 0 and not g.core.common.ModuleUnlock:isModuleShow(self._functionId) then
		return false
	elseif not self:_isUserLvMeet() then
		return false
	end

	if type(self._activityConfig.additionalOpenFunc) == "function" then
		return checkbool(self._activityConfig.additionalOpenFunc())
	end

	return true
end

function ActivityData:isOpen()
	if self:isDuringOpening() and self:isShow() then
		if self._functionId and self._functionId ~= 0 then
			return g.core.common.ModuleUnlock:isModuleUnlock(self._functionId)
		else
			return true
		end
	end

	return false
end

function ActivityData:isAwardPeriod()
	if self:isShow() then
		local var_21_0 = self:getActivityState()

		return var_21_0 == var_0_0.ACTIVITY_STATE.START or var_21_0 == var_0_0.ACTIVITY_STATE.END
	end

	return false
end

function ActivityData:getTabRedPointId()
	return self._activityConfig.tabRedPointId
end

function ActivityData:isInActivityMainLayer()
	return self._inActivityMainLayer
end

function ActivityData:getLogActType()
	return var_0_4
end

function ActivityData:setLogActType(arg_25_1)
	var_0_4 = checknumber(arg_25_1)
end

return ActivityData
