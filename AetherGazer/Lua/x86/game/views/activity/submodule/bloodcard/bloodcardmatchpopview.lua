local var_0_0 = class("BloodCardMatchPopView", ReduxView)

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
	arg_4_0.successHandler_ = handler(arg_4_0, function()
		arg_4_0:Back()
	end)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, function()
		BloodCardAction:SendCancelMultiGameMatching()
		arg_7_0.cancelHandler_()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.matchingTimer = 0
	arg_9_0.timeText_.text = arg_9_0.matchingTimer .. "s"

	arg_9_0:AddTimer()
	manager.notify:RegistListener(BLOOD_CARD_MATCHING_SUCCESS, arg_9_0.successHandler_)
	manager.notify:RegistListener(BLOOD_CARD_MATCHING_CANCEL, arg_9_0.cancelHandler_)
end

function var_0_0.AddTimer(arg_10_0)
	arg_10_0.timer_ = Timer.New(function()
		arg_10_0.matchingTimer = arg_10_0.matchingTimer + 1
		arg_10_0.timeText_.text = arg_10_0.matchingTimer .. "s"
	end, 1, -1, true)

	arg_10_0.timer_:Start()
end

function var_0_0.OnExit(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end

	manager.notify:RemoveListener(BLOOD_CARD_MATCHING_SUCCESS, arg_12_0.successHandler_)
	manager.notify:RemoveListener(BLOOD_CARD_MATCHING_CANCEL, arg_12_0.cancelHandler_)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
