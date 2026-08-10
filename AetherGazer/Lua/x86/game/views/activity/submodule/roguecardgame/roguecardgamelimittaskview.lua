local var_0_0 = import("game.views.task.limitTime.LimitTimeTaskBaseView")
local var_0_1 = class("RogueCardGameLimitTaskView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)
end

function var_0_1.BindRedPoint(arg_2_0)
	for iter_2_0 = 1, #arg_2_0.subActivityIDList_ do
		local var_2_0 = arg_2_0.subActivityIDList_[iter_2_0]
		local var_2_1 = RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK_TAG .. var_2_0

		manager.redPoint:bindUIandKey(arg_2_0.tabList_[iter_2_0].transform_, var_2_1)
	end
end

function var_0_1.UnBindRedPoint(arg_3_0)
	for iter_3_0 = 1, #arg_3_0.subActivityIDList_ do
		local var_3_0 = arg_3_0.subActivityIDList_[iter_3_0]
		local var_3_1 = RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK_TAG .. var_3_0

		manager.redPoint:unbindUIandKey(arg_3_0.tabList_[iter_3_0].transform_, var_3_1)
	end
end

function var_0_1.OnTop(arg_4_0)
	arg_4_0:UpdateTimeTxt()
	arg_4_0:StopUpdateTimer()

	arg_4_0.updateTimer = Timer.New(function()
		arg_4_0:UpdateTimeTxt()
	end, 1, -1)

	arg_4_0.updateTimer:Start()
	var_0_1.super.OnTop(arg_4_0)
end

function var_0_1.StopUpdateTimer(arg_6_0)
	if arg_6_0.updateTimer then
		arg_6_0.updateTimer:Stop()

		arg_6_0.updateTimer = nil
	end
end

function var_0_1.UpdateTimeTxt(arg_7_0)
	local var_7_0 = os.time()
	local var_7_1 = os.difftime(var_7_0, os.time(os.date("!*t", var_7_0)))
	local var_7_2 = os.date("!*t", var_7_0 + var_7_1)

	arg_7_0.dayText_.text = string.format("%s/%s", var_7_2.month, var_7_2.day)
	arg_7_0.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function var_0_1.OnExit(arg_8_0)
	arg_8_0:StopUpdateTimer()
	var_0_1.super.OnExit(arg_8_0)
end

return var_0_1
