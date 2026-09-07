local IslandFutureTask = class("IslandFutureTask", import("model.vo.BaseVO"))

function IslandFutureTask:Ctor(arg_1_1)
	self.id = arg_1_1.task_id
	self.configId = self.id

	self:InitTimeCfg()

	return
end

function IslandFutureTask:bindConfigTable()
	return pg.island_task
end

function IslandFutureTask:InitTimeCfg()
	local var_3_0 = self:getConfig("unlock_time")

	if var_3_0 == "always" then
		self.unlockTime = 0
		self.endTime = 0
	else
		local var_3_1 = pg.TimeMgr.GetInstance()

		self.unlockTime = var_3_1:parseTimeFromConfig(var_3_0[1])
		self.endTime = var_3_1:parseTimeFromConfig(var_3_0[2])
	end

	return
end

function IslandFutureTask:GetUnlockTime()
	return self.unlockTime
end

function IslandFutureTask:IsMatchUnlockTime()
	return pg.TimeMgr.GetInstance():GetServerTime() > self.unlockTime
end

function IslandFutureTask:InTime()
	if self.unlockTime == 0 and self.endTime == 0 then
		return true
	end

	local var_6_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return var_6_0 > self.unlockTime and var_6_0 < self.endTime
end

function IslandFutureTask:IsAcceptImmediately()
	return self:getConfig("trigger_type") == 2 and self:getConfig("trigger_data") == 0
end

function IslandFutureTask:CheckAcceptOnApproach(arg_8_1)
	return self:getConfig("trigger_data") == arg_8_1 and self:getConfig("trigger_type") == 2
end

function IslandFutureTask:IsMatchUnlockConditions()
	local var_9_0 = self:getConfig("unlock_condition")

	if var_9_0 == "" or #var_9_0 == 0 then
		return true
	end

	return underscore.all(var_9_0, function(arg_10_0)
		return IslandTaskConditionType.IsMatch(arg_10_0)
	end)
end

function IslandFutureTask:IsUnlock()
	return self:IsMatchUnlockTime() and self:IsMatchUnlockConditions()
end

function IslandFutureTask:IsUnlockWaitTime()
	if self.unlockTime == 0 then
		return false
	end

	local var_12_0 = self:getConfig("unlock_condition")

	if var_12_0 == "" or #var_12_0 == 0 then
		return false
	end

	return self:IsMatchUnlockConditions() and not self:IsMatchUnlockTime()
end

return IslandFutureTask
