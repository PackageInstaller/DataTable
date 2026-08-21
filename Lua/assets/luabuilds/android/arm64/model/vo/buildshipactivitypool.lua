local var_0_0 = class("BuildShipActivityPool", import(".BuildShipPool"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.activityId = arg_1_1.activityId

	return
end

function var_0_0.IsActivity(arg_2_0)
	return true
end

function var_0_0.GetActivity(arg_3_0)
	return getProxy(ActivityProxy):getActivityById(arg_3_0.activityId)
end

function var_0_0.IsEnd(arg_4_0)
	local var_4_0 = arg_4_0:GetActivity()

	return not var_4_0 or var_4_0:isEnd()
end

function var_0_0.GetStageId(arg_5_0)
	local var_5_0 = arg_5_0:GetActivity():getConfig("config_client") or {}

	return var_5_0.stageid
end

function var_0_0.GetActivityId(arg_6_0)
	return arg_6_0.activityId
end

function var_0_0.IsNewServerBuild(arg_7_0)
	if arg_7_0:IsEnd() then
		return false
	end

	local var_7_0 = arg_7_0:GetActivity()

	return var_7_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD
end

return var_0_0
