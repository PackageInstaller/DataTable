local var_0_0 = class("HodurRankAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	local var_3_0 = AffixTypeCfg[arg_3_1]

	arg_3_0.icon.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_Hodur/Debufficon/" .. arg_3_1)
	arg_3_0.nameText.text = var_3_0.name
end

return var_0_0
