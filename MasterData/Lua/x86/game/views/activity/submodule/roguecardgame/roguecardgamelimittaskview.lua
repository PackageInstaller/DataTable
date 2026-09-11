local RogueCardGameLimitTaskView = class("RogueCardGameLimitTaskView", (import("game.views.task.limitTime.LimitTimeTaskBaseView")))

function RogueCardGameLimitTaskView:Init()
	RogueCardGameLimitTaskView.super.Init(self)
end

function RogueCardGameLimitTaskView:BindRedPoint()
	for iter_2_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:bindUIandKey(self.tabList_[iter_2_0].transform_, RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK_TAG .. self.subActivityIDList_[iter_2_0])
	end
end

function RogueCardGameLimitTaskView:UnBindRedPoint()
	for iter_3_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:unbindUIandKey(self.tabList_[iter_3_0].transform_, RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK_TAG .. self.subActivityIDList_[iter_3_0])
	end
end

function RogueCardGameLimitTaskView:OnTop()
	self:UpdateTimeTxt()
	self:StopUpdateTimer()

	self.updateTimer = Timer.New(function()
		self:UpdateTimeTxt()
	end, 1, -1)

	self.updateTimer:Start()
	RogueCardGameLimitTaskView.super.OnTop(self)
end

function RogueCardGameLimitTaskView:StopUpdateTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end
end

function RogueCardGameLimitTaskView:UpdateTimeTxt()
	local var_7_0 = os.time()
	local var_7_1 = os.date("!*t", var_7_0 + os.difftime(var_7_0, os.time(os.date("!*t", var_7_0))))

	self.dayText_.text = string.format("%s/%s", var_7_1.month, var_7_1.day)
	self.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function RogueCardGameLimitTaskView:OnExit()
	self:StopUpdateTimer()
	RogueCardGameLimitTaskView.super.OnExit(self)
end

return RogueCardGameLimitTaskView
