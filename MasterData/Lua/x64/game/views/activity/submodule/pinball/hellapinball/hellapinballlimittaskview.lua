local HellaPinballLimitTaskView = class("HellaPinballLimitTaskView", (import("game.views.task.limitTime.LimitTimeTaskBaseView")))

function HellaPinballLimitTaskView:BindRedPoint()
	for iter_1_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:bindUIandKey(self.tabList_[iter_1_0].transform_, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.subActivityIDList_[iter_1_0])))
	end
end

function HellaPinballLimitTaskView:UnBindRedPoint()
	for iter_2_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:unbindUIandKey(self.tabList_[iter_2_0].transform_, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.subActivityIDList_[iter_2_0])))
	end
end

return HellaPinballLimitTaskView
