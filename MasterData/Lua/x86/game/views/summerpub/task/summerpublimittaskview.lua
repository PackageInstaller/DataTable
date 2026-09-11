local SummerPubLimitTaskView = class("SummerPubLimitTaskView", (import("game.views.task.limitTime.LimitTimeTaskBaseView")))

function SummerPubLimitTaskView:OnEnter()
	self.super.OnEnter(self)

	for iter_1_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:bindUIandKey(self.tabList_[iter_1_0].transform_, RedPointConst.SUMMER_PUB_LIMIT_TASK_TAG .. self.subActivityIDList_[iter_1_0])
	end
end

function SummerPubLimitTaskView:OnExit()
	self.super.OnExit(self)

	for iter_2_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:unbindUIandKey(self.tabList_[iter_2_0].transform_, RedPointConst.SUMMER_PUB_LIMIT_TASK_TAG .. self.subActivityIDList_[iter_2_0])
	end
end

function SummerPubLimitTaskView:OnTop()
	self.super.OnTop(self)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

return SummerPubLimitTaskView
