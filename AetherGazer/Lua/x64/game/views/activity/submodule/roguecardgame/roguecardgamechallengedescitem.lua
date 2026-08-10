local var_0_0 = class("RogueCardGameCardBuffStyleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.lockCon_ = arg_2_0.controller_:GetController("lock")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.deck = arg_4_1
	arg_4_0.diff = arg_4_2

	if RogueCardGameTools.IsUnlockDiff(arg_4_0.deck, arg_4_0.diff) then
		arg_4_0.lockCon_:SetSelectedIndex(1)
	else
		arg_4_0.lockCon_:SetSelectedIndex(0)
	end

	RichTextTools.SetMixedTextWithImage(arg_4_0.desc_, GetI18NText(RogueCardDifficultyCfg[arg_4_2].desc))

	arg_4_0.desc_.text = GetI18NText(RogueCardDifficultyCfg[arg_4_2].desc)
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
