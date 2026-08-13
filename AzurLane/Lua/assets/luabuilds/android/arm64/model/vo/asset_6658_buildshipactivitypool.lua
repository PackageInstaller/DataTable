class = var_0_10000

local var_0_0 = "BuildShipActivityPool"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BuildShipPool"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.activityId = arg_1_1.activityId

	return
end

function var_0_1.IsActivity(arg_2_0)
	return true
end

function var_0_1.GetActivity(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	return var_1.getActivityById(var_3_0, arg_3_0.activityId)
end

function var_0_1.IsEnd(arg_4_0)
	return not arg_4_0:GetActivity() or var_1:isEnd()
end

function var_0_1.GetStageId(arg_5_0)
	local var_5_0 = arg_5_0:GetActivity()
	local var_5_1

	if not var_1.getConfig(var_5_0, "config_client") then
		var_5_1 = {}
	end

	return var_5_1.stageid
end

function var_0_1.GetActivityId(arg_6_0)
	return arg_6_0.activityId
end

function var_0_1.IsNewServerBuild(arg_7_0)
	if arg_7_0:IsEnd() then
		return false
	end

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.GetActivity(var_7_0)
	local var_7_2 = var_1.getConfig(var_7_1, "type")

	ActivityConst = var_7_0

	return var_7_2 == var_7_0.ACTIVITY_TYPE_NEWSERVER_BUILD
end

return var_0_1
