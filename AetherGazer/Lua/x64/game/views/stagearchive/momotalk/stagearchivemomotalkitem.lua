local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("StageArchiveMomoTalkItem", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.continueController_ = arg_3_0.controllerEx_:GetController("continue")
end

function var_0_1.AddListeners(arg_4_0)
	return
end

function var_0_1.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.talkID_ = arg_5_1
	arg_5_0.index_ = arg_5_2
	arg_5_0.isContinue_ = arg_5_3 or false

	arg_5_0:Refresh()
end

function var_0_1.Refresh(arg_6_0)
	local var_6_0 = StageArchivesCollectMomoTalkCfg[arg_6_0.talkID_]

	arg_6_0.speakerIcon_.sprite = getSpriteViaConfig("StoryHeadIcon", var_6_0.speaker_icon)
	arg_6_0.speakerName_.text = var_6_0.speaker_name
	arg_6_0.talkContent_.text = var_6_0.speaker_desc

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.talkContent_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.rectBg_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.rectGo_)
	arg_6_0.continueController_:SetSelectedState(tostring(arg_6_0.isContinue_))
end

function var_0_1.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

return var_0_1
