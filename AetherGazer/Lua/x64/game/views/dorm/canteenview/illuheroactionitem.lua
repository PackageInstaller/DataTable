local var_0_0 = class("IlluHeroActionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.playController_ = arg_2_0.mainControllerEx_:GetController("play")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.id_ = arg_3_2
	arg_3_0.text_.text = string.format(GetTips("BACKHOME_HERO_ILLU_INTERACT"), arg_3_1)
	arg_3_0.onClick_ = arg_3_3
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0.onClick_(arg_4_0.id_)
	end)
end

function var_0_0.SetPlay(arg_6_0, arg_6_1)
	arg_6_0.playController_:SetSelectedState(arg_6_1 and "on" or "off")

	if arg_6_1 then
		arg_6_0:OnPreviewStart()
	else
		arg_6_0:OnPreviewEnd()
	end
end

function var_0_0.StopTimer(arg_7_0)
	arg_7_0.curDuration = 0

	if arg_7_0.timer_ then
		arg_7_0.timer_:Stop()

		arg_7_0.timer_ = nil
	end
end

function var_0_0.OnPreviewStart(arg_8_0)
	arg_8_0:StopTimer()

	local var_8_0 = DormInteractSequence[arg_8_0.id_].name
	local var_8_1 = DormCharacterInteractBehaviour.GetSequence(nil, nil, var_8_0)

	arg_8_0.progress_.fillAmount = 0
	arg_8_0.curDuration = var_8_1.duration
	arg_8_0.timer_ = FrameTimer.New(function()
		arg_8_0.curDuration = arg_8_0.curDuration - Time.deltaTime
		arg_8_0.progress_.fillAmount = 1 - arg_8_0.curDuration / var_8_1.duration

		if arg_8_0.curDuration <= 0 then
			arg_8_0:SetPlay(false)
		end
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.OnPreviewEnd(arg_10_0)
	arg_10_0:StopTimer()

	arg_10_0.curDuration = 0
	arg_10_0.progress_.fillAmount = 0
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:StopTimer()

	arg_11_0.curDuration = 0

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
