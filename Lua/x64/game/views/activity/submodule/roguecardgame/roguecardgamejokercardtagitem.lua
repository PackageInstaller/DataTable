local var_0_0 = class("RogueCardGameJokerCardTagItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshData(arg_4_0, arg_4_1)
	arg_4_0.name_.text = GetTips("ROGUE_CARD_TAG_" .. arg_4_1)
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	Object.Destroy(arg_6_0.gameObject_)

	arg_6_0.gameObject_ = nil
	arg_6_0.transform_ = nil
end

return var_0_0
