local var_0_0 = class("ActivityQuizEnterView_3_10", ActivityQuizEnterView)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.stateCon_ = arg_1_0.controllers_:GetController("state")
end

function var_0_0.AddUIListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.startBtn_, nil, function()
		if arg_2_0:IsActivitying() then
			if arg_2_0:IsOpenTime() then
				arg_2_0:MuteEnterRedPoint()
				ActivityQuizAction.StartMarch()
			else
				ShowTips("ACTIVITY_QUIZ_NOT_OPEN_YET")
			end
		end
	end)
	arg_2_0:AddBtnListener(arg_2_0.taskBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ActivityQuizTools.GetTaskActivityID(arg_2_0.activityID_), "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI")
	end)
end

function var_0_0.RegisterEvents(arg_5_0)
	return
end

function var_0_0.RefreshActivityData(arg_6_0)
	arg_6_0.titleText_.text = ActivityTools.GetActivityTitleName(arg_6_0.activityID_)
	arg_6_0.stopTime_ = ActivityData:GetActivityData(arg_6_0.activityID_).stopTime

	local var_6_0 = GameSetting.activity_quiz_open_time.value

	arg_6_0.openTbl_, arg_6_0.closeTbl_ = var_6_0[1], var_6_0[2]
	arg_6_0.dayOpen_.text = string.format("%02d:%02d-%02d:%02d", arg_6_0.openTbl_[1], arg_6_0.openTbl_[2], arg_6_0.closeTbl_[1], arg_6_0.closeTbl_[2])
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshActivityData()
	arg_7_0:StartTimer()
	arg_7_0:RefreshTimeText()
end

function var_0_0.StopTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

function var_0_0.StartTimer(arg_9_0)
	arg_9_0:StopTimer()

	local var_9_0 = arg_9_0.activityID_

	if ActivityTools.GetActivityStatus(var_9_0) ~= ActivityConst.ACTIVITY_STATE.OVER then
		arg_9_0.timer_ = Timer.New(function()
			arg_9_0:RefreshTimeText()
		end, 1, -1)

		arg_9_0.timer_:Start()

		return true
	else
		return false
	end
end

function var_0_0.RefreshTask(arg_11_0)
	return
end

function var_0_0.RefreshTimeText(arg_12_0)
	local var_12_0 = arg_12_0.activityID_
	local var_12_1, var_12_2 = ActivityTools.GetActivityStatusWithTips(var_12_0)

	if var_12_1 ~= ActivityConst.ACTIVITY_STATE.OVER then
		local var_12_3 = var_12_1 == ActivityConst.ACTIVITY_STATE.ACTIVING and arg_12_0:IsOpenTime()

		arg_12_0.stateCon_:SetSelectedState(var_12_3 and "unlock" or "close")

		arg_12_0.timeText_.text = var_12_2 or manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_12_0.stopTime_)
	else
		arg_12_0.stateCon_:SetSelectedState("close")

		arg_12_0.timeText_.text = var_12_2

		arg_12_0:StopTimer()
	end
end

function var_0_0.IsActivitying(arg_13_0)
	local var_13_0 = arg_13_0.activityID_

	return ActivityTools.GetActivityIsOpenWithTip(var_13_0, false)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:RegisterEvents()

	arg_14_0.activityID_ = arg_14_0.params_.activityID

	arg_14_0:RefreshUI()
	arg_14_0:BindRedPoints()
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:UnbindRedPoints()
	arg_15_0:RemoveAllEventListener()
	arg_15_0:StopTimer()
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(ActivityQuizTools.GetHelpKey(arg_16_0.activityID_))
end

function var_0_0.Dispose(arg_17_0)
	ReduxView.Dispose(arg_17_0)
end

function var_0_0.BindRedPoints(arg_18_0)
	local var_18_0 = arg_18_0.activityID_
	local var_18_1 = ActivityQuizTools.GetTaskActivityID(var_18_0)

	manager.redPoint:bindUIandKey(arg_18_0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. var_18_1)
	manager.redPoint:bindUIandKey(arg_18_0.startBtn_.transform, RedPointConst.ACTIVITY_QUIZ_CHALLENGE_AVAILABLE .. "_" .. var_18_1)
end

function var_0_0.UnbindRedPoints(arg_19_0)
	manager.redPoint:unbindUIandKey(arg_19_0.taskBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_19_0.startBtn_.transform)
end

return var_0_0
