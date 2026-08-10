local var_0_0 = class("QWorldStoryHistoryCell", import("game.extend.ReduxView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.parent_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.voiceController = arg_3_0.controller_:GetController("voice")
	arg_3_0.talkId = 0
end

function var_0_0.Show(arg_4_0)
	arg_4_0.gameObject_:SetActive(true)
end

function var_0_0.Hide(arg_5_0)
	arg_5_0.gameObject_:SetActive(false)
end

function var_0_0.Render(arg_6_0, arg_6_1)
	arg_6_0.talkId = arg_6_1

	local var_6_0 = SandplayStoryTalkCfg[arg_6_1]

	arg_6_0.titleText_.text = GetI18NText(var_6_0.speaker_name)
	arg_6_0.contentText_.text = GetI18NText(var_6_0.dialogue_text)

	SetActive(arg_6_0.voiceObj_, var_6_0.cue_sheet ~= "")
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.voiceBtn_, nil, function()
		arg_7_0.parent_:PlayTalkVoice(arg_7_0)
	end)
end

function var_0_0.ChangeVoiceState(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.voiceController:SetSelectedState("play")
	else
		arg_9_0.voiceController:SetSelectedState("stop")
	end
end

function var_0_0.Dispose(arg_10_0)
	GameObject.Destroy(arg_10_0.gameObject_)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
