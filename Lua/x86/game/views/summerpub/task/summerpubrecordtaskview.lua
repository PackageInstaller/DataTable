local var_0_0 = import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")
local var_0_1 = class("SummerPubRecordTaskView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/Com/Activity_SummerPub_RewardTrustUI"
end

function var_0_1.SetActivityID(arg_2_0)
	arg_2_0.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_NYA_SUMMER_PUB
end

function var_0_1.GetLevelInfo(arg_3_0)
	local var_3_0, var_3_1 = SummerPubTool:GetTaskInfo()

	return var_3_0, var_3_1
end

return var_0_1
