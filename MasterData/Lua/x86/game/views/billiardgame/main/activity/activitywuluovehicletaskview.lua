local ActivityWuluoVehicleTaskView = class("ActivityWuluoVehicleTaskView", (import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")))

function ActivityWuluoVehicleTaskView:UIName()
	return "Widget/System/Activity_WuLuo/Com/Activity_WuLuo_RewardTrustUI"
end

function ActivityWuluoVehicleTaskView:SetActivityID()
	self.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN
end

return ActivityWuluoVehicleTaskView
