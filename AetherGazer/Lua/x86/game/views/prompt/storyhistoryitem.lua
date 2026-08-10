local var_0_0 = class("StoryHistoryItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
	SetActive(arg_1_0.voiceBtn_.gameObject, false)
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.voiceController_ = arg_3_0.controller_:GetController("voice")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.voiceBtn_, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0)
		end
	end)
end

function var_0_0.SetTitle(arg_6_0, arg_6_1)
	arg_6_0.titleText_.text = arg_6_1
end

function var_0_0.SetContent(arg_7_0, arg_7_1)
	arg_7_0.contentText_.text = arg_7_1
end

function var_0_0.SetVoiceCallback(arg_8_0, arg_8_1)
	arg_8_0.callback_ = arg_8_1

	if arg_8_1 then
		SetActive(arg_8_0.voiceBtn_.gameObject, true)
	else
		SetActive(arg_8_0.voiceBtn_.gameObject, false)
	end
end

function var_0_0.PlayVoiceAni(arg_9_0)
	arg_9_0.voiceController_:SetSelectedState("play")
end

function var_0_0.StopVoiceAni(arg_10_0)
	arg_10_0.voiceController_:SetSelectedState("stop")
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
