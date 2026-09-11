local TaskWeekContentView = class("TaskWeekContentView", TaskDailyContentView)

function TaskWeekContentView:RefreshTimeText()
	local var_1_0 = TimeMgr.GetInstance():GetNextWeekTime(1, GameSetting.refresh_time1.value[1][1], 0, 0)
	local var_1_1 = var_1_0 - TimeMgr.GetInstance():GetServerTime()

	self.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), self:GetTimeText(var_1_0 - TimeMgr.GetInstance():GetServerTime()))

	if self.dailyTimer_ then
		self.dailyTimer_:Stop()
	end

	self.dailyTimer_ = Timer.New(function()
		var_1_1 = var_1_0 - TimeMgr.GetInstance():GetServerTime()

		if var_1_1 < 0 then
			var_1_1 = TimeMgr.GetInstance():GetNextWeekTime(1, GameSetting.refresh_time1.value[1][1], 0, 0) - TimeMgr.GetInstance():GetServerTime()
		end

		self.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), self:GetTimeText(var_1_1))
	end, 1, -1)

	self.dailyTimer_:Start()
end

return TaskWeekContentView
