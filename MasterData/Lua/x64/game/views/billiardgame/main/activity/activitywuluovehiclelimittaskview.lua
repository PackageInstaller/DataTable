local ActivityWuluoVehicleLimitTaskView = class("ActivityWuluoVehicleLimitTaskView", (import("game.views.task.limitTime.LimitTimeTaskBaseView")))

function ActivityWuluoVehicleLimitTaskView:BindRedPoint()
	for iter_1_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:bindUIandKey(self.tabList_[iter_1_0].transform_, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_TAG .. self.subActivityIDList_[iter_1_0])
	end
end

function ActivityWuluoVehicleLimitTaskView:UnBindRedPoint()
	for iter_2_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:unbindUIandKey(self.tabList_[iter_2_0].transform_, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_TAG .. self.subActivityIDList_[iter_2_0])
	end
end

return ActivityWuluoVehicleLimitTaskView
