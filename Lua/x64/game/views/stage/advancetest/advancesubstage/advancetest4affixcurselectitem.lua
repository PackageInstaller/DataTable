local var_0_0 = class("AdvanceTest4AffixCurSelectItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.bufftypeController_ = arg_2_0.affixController_:GetController("category")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = ActivityAffixPoolCfg[arg_3_2].affix

	arg_3_0.icon.sprite = getAffixSprite(var_3_0)

	arg_3_0.bufftypeController_:SetSelectedIndex(arg_3_3)
end

return var_0_0
