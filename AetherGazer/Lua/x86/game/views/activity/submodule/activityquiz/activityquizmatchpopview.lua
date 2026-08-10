local var_0_0 = class("ActivityQuizMatchPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityQuizTools.GetMatchPopUIName(arg_1_0.params_.activityId)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		ActivityQuizAction.CancelMarch()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityId

	arg_7_0:RefreshTime()
end

function var_0_0.RefreshTime(arg_8_0)
	arg_8_0:StopTimer()

	local var_8_0 = 0

	arg_8_0.cnt_.text = var_8_0 .. "s"
	arg_8_0.timer_ = Timer.New(function()
		var_8_0 = var_8_0 + 1
		arg_8_0.cnt_.text = var_8_0 .. "s"
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

function var_0_0.OnQuizStartGame(arg_11_0)
	arg_11_0:Back()
end

function var_0_0.OnActivityQuizCancelMatch(arg_12_0)
	arg_12_0:Back()
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:StopTimer()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
