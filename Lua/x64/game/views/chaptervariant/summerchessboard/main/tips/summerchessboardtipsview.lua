local var_0_0 = class("SummerChessBoardTipsView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.OnExit(arg_2_0)
	arg_2_0:StopTimer()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, function()
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		SetActive(arg_4_0.gameObject_, false)
		manager.notify:Invoke(SUMMER_CHESS_BOARD_TIPS_ANIMATOR_OVER)
	end)
end

function var_0_0.SetText(arg_6_0, arg_6_1)
	manager.windowBar:HideBar()

	arg_6_0.tipsText_.text = arg_6_1

	SetActive(arg_6_0.gameObject_, true)
	arg_6_0:StopTimer()

	arg_6_0.closeBtn_.interactable = false
	arg_6_0.timer_ = FrameTimer.New(function()
		if arg_6_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_6_0:StopTimer()

			arg_6_0.closeBtn_.interactable = true
		end
	end, 1, -1)

	arg_6_0.timer_:Start()
end

function var_0_0.StopTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

return var_0_0
