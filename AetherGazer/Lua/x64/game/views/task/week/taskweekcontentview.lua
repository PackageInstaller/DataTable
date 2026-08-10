local var_0_0 = class("TaskWeekContentView", TaskDailyContentView)

function var_0_0.RefreshTimeText(arg_1_0)
	local var_1_0 = GameSetting.refresh_time1.value[1][1]
	local var_1_1 = TimeMgr.GetInstance():GetNextWeekTime(1, var_1_0, 0, 0)
	local var_1_2 = var_1_1 - TimeMgr.GetInstance():GetServerTime()

	arg_1_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), arg_1_0:GetTimeText(var_1_2))

	if arg_1_0.dailyTimer_ then
		arg_1_0.dailyTimer_:Stop()
	end

	arg_1_0.dailyTimer_ = Timer.New(function()
		var_1_2 = var_1_1 - TimeMgr.GetInstance():GetServerTime()

		if var_1_2 < 0 then
			local var_2_0 = GameSetting.refresh_time1.value[1][1]

			var_1_2 = TimeMgr.GetInstance():GetNextWeekTime(1, var_2_0, 0, 0) - TimeMgr.GetInstance():GetServerTime()
		end

		arg_1_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), arg_1_0:GetTimeText(var_1_2))
	end, 1, -1)

	arg_1_0.dailyTimer_:Start()
end

return var_0_0
