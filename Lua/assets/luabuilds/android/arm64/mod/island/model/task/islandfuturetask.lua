local var_0_0 = class("IslandFutureTask", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.task_id
	arg_1_0.configId = arg_1_0.id

	arg_1_0:InitTimeCfg()

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_task
end

function var_0_0.InitTimeCfg(arg_3_0)
	local var_3_0 = arg_3_0:getConfig("unlock_time")

	if var_3_0 == "always" then
		arg_3_0.unlockTime = 0
		arg_3_0.endTime = 0
	else
		local var_3_1 = pg.TimeMgr.GetInstance()

		arg_3_0.unlockTime = var_3_1:parseTimeFromConfig(var_3_0[1])
		arg_3_0.endTime = var_3_1:parseTimeFromConfig(var_3_0[2])
	end

	return
end

function var_0_0.GetUnlockTime(arg_4_0)
	return arg_4_0.unlockTime
end

function var_0_0.IsMatchUnlockTime(arg_5_0)
	local var_5_0 = pg.TimeMgr.GetInstance()

	return var_5_0:GetServerTime() > arg_5_0.unlockTime
end

function var_0_0.InTime(arg_6_0)
	if arg_6_0.unlockTime == 0 and arg_6_0.endTime == 0 then
		return true
	end

	local var_6_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return var_6_0 > arg_6_0.unlockTime and var_6_0 < arg_6_0.endTime
end

function var_0_0.IsAcceptImmediately(arg_7_0)
	return arg_7_0:getConfig("trigger_type") == 2 and arg_7_0:getConfig("trigger_data") == 0
end

function var_0_0.CheckAcceptOnApproach(arg_8_0, arg_8_1)
	return arg_8_0:getConfig("trigger_data") == arg_8_1 and arg_8_0:getConfig("trigger_type") == 2
end

function var_0_0.IsMatchUnlockConditions(arg_9_0)
	local var_9_0 = arg_9_0:getConfig("unlock_condition")

	if var_9_0 == "" or #var_9_0 == 0 then
		return true
	end

	return underscore.all(var_9_0, function(arg_10_0)
		return IslandTaskConditionType.IsMatch(arg_10_0)
	end)
end

function var_0_0.IsUnlock(arg_11_0)
	return arg_11_0:IsMatchUnlockTime() and arg_11_0:IsMatchUnlockConditions()
end

function var_0_0.IsUnlockWaitTime(arg_12_0)
	if arg_12_0.unlockTime == 0 then
		return false
	end

	local var_12_0 = arg_12_0:getConfig("unlock_condition")

	if var_12_0 == "" or #var_12_0 == 0 then
		return false
	end

	return arg_12_0:IsMatchUnlockConditions() and not arg_12_0:IsMatchUnlockTime()
end

return var_0_0
