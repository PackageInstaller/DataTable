local var_0_0 = class("SummerPubToTaskDialogPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_DialoguePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.typeWritter = arg_4_0.talkText_.transform:GetComponent("UITypewriterEffect")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		if arg_5_0.typeWritter.percent >= 1 then
			arg_5_0:Back()

			if arg_5_0.callback_ then
				arg_5_0.callback_()
			end
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.callback_ = arg_7_0.params_.callback
	arg_7_0.cfg_ = arg_7_0.params_.cfg

	arg_7_0:UpdateText()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateText(arg_9_0)
	SetActive(arg_9_0.buttonTextGo_, false)

	arg_9_0.talkText_.text = arg_9_0.cfg_.inter_CG_text or "##"

	local var_9_0 = GameSetting.nya_summer_taste_typespeed.value[1] or 20
	local var_9_1 = utf8len(arg_9_0.talkText_.text) / var_9_0
	local var_9_2 = 0
	local var_9_3 = 0

	arg_9_0.timer = Timer.New(function()
		var_9_2 = var_9_2 + 0.01
		var_9_3 = Mathf.Lerp(0, 1, var_9_2 / var_9_1)

		if arg_9_0.typeWritter.percent < var_9_3 then
			arg_9_0.typeWritter.percent = var_9_3

			arg_9_0.typeWritter:SetDirty()
		end

		if var_9_2 >= var_9_1 then
			SetActive(arg_9_0.buttonTextGo_, true)

			if arg_9_0.timer then
				arg_9_0.timer:Stop()

				arg_9_0.timer = nil
			end
		end
	end, 0.01, -1)

	arg_9_0.timer:Start()
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:StopTimer()
	arg_12_0.super.OnExit(arg_12_0)

	arg_12_0.typeWritter.percent = 0

	if arg_12_0.timer then
		arg_12_0.timer:Stop()

		arg_12_0.timer = nil
	end

	SummerPubTool:OnLogout()
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
