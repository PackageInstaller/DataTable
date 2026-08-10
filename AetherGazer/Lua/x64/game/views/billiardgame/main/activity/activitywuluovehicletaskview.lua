local var_0_0 = import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")
local var_0_1 = class("ActivityWuluoVehicleTaskView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Com/Activity_WuLuo_RewardTrustUI"
end

function var_0_1.SetActivityID(arg_2_0)
	arg_2_0.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN
end

return var_0_1
