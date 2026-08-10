local var_0_0 = class("ActivityRaceAffixResultItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.affixID_ = arg_4_1

	if arg_4_0.affixID_ then
		local var_4_0 = AffixTypeCfg[arg_4_0.affixID_]
		local var_4_1 = PublicBuffCfg[var_4_0.affix_buff_id].icon

		if var_4_1 == "" then
			-- block empty
		end

		arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. var_4_1)
		arg_4_0.name_.text = GetI18NText(var_4_0.name)
	end
end

return var_0_0
