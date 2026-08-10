local var_0_0 = class("SectionSelectHeroBuffItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	local var_3_0 = SequentialBattleBuffCfg[arg_3_1].affix_id
	local var_3_1 = AffixTypeCfg[var_3_0]
	local var_3_2 = PublicBuffCfg[var_3_1.affix_buff_id].icon

	arg_3_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MaedukAffix/" .. var_3_2)

	arg_3_0:Show(true)
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

return var_0_0
