local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("AutoChessTalkItem", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.isPlayedAnim_ = false
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_1.AddListeners(arg_4_0)
	return
end

function var_0_1.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.talkID_ = arg_5_1
	arg_5_0.index_ = arg_5_2

	arg_5_0:Refresh()
end

function var_0_1.Refresh(arg_6_0)
	local var_6_0 = AutoChessTalkCfg[arg_6_0.talkID_]

	arg_6_0.nameText_.text = var_6_0.speaker_name
	arg_6_0.dialogText_.text = var_6_0.speaker_desc
end

function var_0_1.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_1.PlayAnim(arg_8_0, arg_8_1)
	if not arg_8_0.isPlayedAnim_ then
		arg_8_0.anim_:Play(arg_8_1 and "UI_Dialogueleft_cx" or "UI_Dialogueright_cx", -1, 0)
		arg_8_0.anim_:Update(0)

		arg_8_0.isPlayedAnim_ = true
	end
end

function var_0_1.ResetAnimState(arg_9_0)
	arg_9_0.isPlayedAnim_ = false

	arg_9_0.anim_:Play("New State", 0, 0)
end

return var_0_1
