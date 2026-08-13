class = var_0_10000

local var_0_0 = "IslandFutureTask"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.task_id
	arg_1_0.configId = arg_1_0.id

	arg_1_0:InitTimeCfg()

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_task
end

function var_0_1.InitTimeCfg(arg_3_0)
	local var_3_0 = arg_3_0

	if arg_3_0.getConfig(var_3_0, "unlock_time") == "always" then
		arg_3_0.unlockTime = 0
		arg_3_0.endTime = 0
	else
		pg = var_3_0

		local var_3_1 = var_3_0.TimeMgr.GetInstance()

		arg_3_0.unlockTime = var_2.parseTimeFromConfig(var_3_1, var_1[1])
		arg_3_0.endTime = var_2:parseTimeFromConfig(var_1[2])
	end

	return
end

function var_0_1.GetUnlockTime(arg_4_0)
	return arg_4_0.unlockTime
end

function var_0_1.IsMatchUnlockTime(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_5_0) > arg_5_0.unlockTime
end

function var_0_1.InTime(arg_6_0)
	if arg_6_0.unlockTime == 0 and arg_6_0.endTime == 0 then
		return true
	end

	pg = var_1

	local var_6_0 = var_1.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_6_0) > arg_6_0.unlockTime and var_1 < arg_6_0.endTime
end

function var_0_1.IsAcceptImmediately(arg_7_0)
	return arg_7_0:getConfig("trigger_type") == 2 and arg_7_0:getConfig("trigger_data") == 0
end

function var_0_1.CheckAcceptOnApproach(arg_8_0, arg_8_1)
	return arg_8_0:getConfig("trigger_data") == arg_8_1 and arg_8_0:getConfig("trigger_type") == 2
end

function var_0_1.IsMatchUnlockConditions(arg_9_0)
	local var_9_0 = arg_9_0

	if arg_9_0.getConfig(var_9_0, "unlock_condition") == "" or #var_1 == 0 then
		return true
	end

	underscore = var_9_0

	return var_9_0.all(var_1, function(arg_10_0)
		IslandTaskConditionType = var_2_10001

		return var_2_10001.IsMatch(arg_10_0)
	end)
end

function var_0_1.IsUnlock(arg_11_0)
	local var_11_0

	if arg_11_0:IsMatchUnlockTime() then
		var_11_0 = arg_11_0:IsMatchUnlockConditions()
	end

	return var_11_0
end

function var_0_1.IsUnlockWaitTime(arg_12_0)
	if arg_12_0.unlockTime == 0 then
		return false
	end

	if arg_12_0:getConfig("unlock_condition") == "" or #var_1 == 0 then
		return false
	end

	local var_12_0

	if arg_12_0:IsMatchUnlockConditions() then
		var_12_0 = not arg_12_0:IsMatchUnlockTime()
	end

	return var_12_0
end

return var_0_1
