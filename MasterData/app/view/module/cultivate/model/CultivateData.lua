local CultivatePassCardData = require("app.view.module.cultivate.model.CultivatePassCardData")
local CultivateTaskData = require("app.view.module.cultivate.model.CultivateTaskData")
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_3 = g.core.config.cultivate_activity_info
local CultivateData = class("CultivateData")

function CultivateData:ctor(arg_1_1)
	self:initData(arg_1_1)
end

function CultivateData:initData(arg_2_1)
	self._cfgId = arg_2_1.activity_id
	self._actData = arg_2_1
	self._taskData = nil
	self._passCardData = nil
	self._startTime = arg_2_1.start_time
	self._endTime = arg_2_1.end_time
	self._expireTime = arg_2_1.expire_time
	self._isGetSvrData = false
	self._svrRedPoint = arg_2_1.has_red_point
	self._lvMin = arg_2_1.min_level
	self._lvMax = arg_2_1.max_level

	local var_2_0 = self:getActivityCfg()

	self._taskData = self._taskData or CultivateTaskData.new(var_2_0.activity_task, arg_2_1)
	self._passCardData = self._passCardData or CultivatePassCardData.new(var_2_0.cultivate_activity_passcard, arg_2_1)
end

function CultivateData:isGetInfo()
	return self._isGetSvrData
end

function CultivateData:hasSvrRedPoint()
	return self._svrRedPoint
end

function CultivateData:getTaskData()
	return self._taskData
end

function CultivateData:getPassCardData()
	return self._passCardData
end

function CultivateData:getExpireTime()
	return self._expireTime
end

function CultivateData:getEndTime()
	return self._endTime
end

function CultivateData:getTimeData()
	return self._startTime, self._endTime, self._expireTime
end

function CultivateData:isInNormalOpenTime()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CULTIVATE_ACTIVITY) then
		return false
	end

	if self._lvMin and self._lvMax then
		local var_10_0 = g.core.model.User:getLevel()

		if var_10_0 < self._lvMin or var_10_0 > self._lvMax then
			return false
		end
	end

	local var_10_1 = g.core.common.ServerTime:getTime()

	return var_10_1 >= self._startTime and var_10_1 <= self._endTime
end

function CultivateData:isInActivityShowTime()
	if self:getActivityCfg().type == CultivateConst.ACTIVITY_TYPE.WITCH then
		if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WITCH_ACTIVITY) then
			return false
		end
	elseif not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CULTIVATE_ACTIVITY) then
		return false
	end

	if self._lvMin and self._lvMax then
		local var_11_0 = g.core.model.User:getLevel()

		if var_11_0 < self._lvMin or var_11_0 > self._lvMax then
			return false
		end
	end

	local var_11_1 = g.core.common.ServerTime:getTime()

	return var_11_1 >= self._startTime and var_11_1 <= self._expireTime
end

function CultivateData:getHomeIconTimeDesc()
	if g.core.common.ServerTime:getTime() <= self._endTime then
		return self._endTime
	else
		return self._expireTime
	end
end

function CultivateData:checkPreciousActIsOpen()
	return self:isInNormalOpenTime(), self._endTime
end

function CultivateData:getActivityCfg()
	return var_0_3.get(self._cfgId)
end

function CultivateData:updateActivityData(arg_15_1)
	self._isGetSvrData = true

	if self:getActivityCfg().cultivate_activity_passcard ~= 0 then
		self._passCardData:updatePassCardData(arg_15_1.passcards, true)
	end

	self._taskData:updateTaskData(arg_15_1.tasks)
end

function CultivateData:getLocationId()
	return g.core.config.cultivate_activity_display_info.get(self._cfgId).icon_location
end

function CultivateData:getLocationIcon()
	return g.core.config.cultivate_activity_display_info.get(self._cfgId).icon
end

function CultivateData:getRedPointId()
	return g.core.config.cultivate_activity_display_info.get(self._cfgId).red_point_id
end

function CultivateData:hasGift()
	return g.core.config.cultivate_activity_display_info.get(self._cfgId).have_gift == 1
end

function CultivateData:isWitchActivity()
	return self:getActivityCfg().type == CultivateConst.ACTIVITY_TYPE.WITCH
end

function CultivateData:isPassCardOpen()
	return self._passCardData:isPassCardOpen()
end

function CultivateData:getActId()
	return self._cfgId
end

return CultivateData
