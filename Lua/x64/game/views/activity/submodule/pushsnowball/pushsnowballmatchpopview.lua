local var_0_0 = class("PushSnowBallMatchPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballMatchmakingUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.cancelHandler_ = handler(arg_4_0, function()
		arg_4_0:Back()
	end)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.cancelBtn_, nil, function()
		PushSnowBallAction:SendCancelMatching()
		arg_6_0.cancelHandler_()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.matchingTimer = 0
	arg_8_0.timeText_.text = arg_8_0.matchingTimer .. "s"

	arg_8_0:AddTimer()
	manager.notify:RegistListener(PUSH_SNOWBALL_CANCLE_MATCHING, arg_8_0.cancelHandler_)
	manager.notify:RegistListener(PUSH_SNOWBALL_SUCCESS_MATCHING, arg_8_0.cancelHandler_)
end

function var_0_0.AddTimer(arg_9_0)
	arg_9_0.timer_ = Timer.New(function()
		arg_9_0.matchingTimer = arg_9_0.matchingTimer + 1
		arg_9_0.timeText_.text = arg_9_0.matchingTimer .. "s"
	end, 1, -1, true)

	arg_9_0.timer_:Start()
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end

	manager.notify:RemoveListener(PUSH_SNOWBALL_CANCLE_MATCHING, arg_11_0.cancelHandler_)
	manager.notify:RemoveListener(PUSH_SNOWBALL_SUCCESS_MATCHING, arg_11_0.cancelHandler_)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
