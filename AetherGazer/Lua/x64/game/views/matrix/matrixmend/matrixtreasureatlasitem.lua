local var_0_0 = class("MatrixTreasureAtlasItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.rareController_ = ControllerUtil.GetController(arg_2_0.transform_, "rare")
end

function var_0_0.Refresh(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = MatrixItemCfg[arg_3_1]

	arg_3_0.m_name.text = GetI18NText(var_3_0.name)
	arg_3_0.m_des.text = GetI18NText(MatrixTools.GetMatrixItemDes(arg_3_1))
	arg_3_0.m_icon.sprite = MatrixTools.GetMatrixItemSprite(arg_3_1)

	arg_3_0.rareController_:SetSelectedIndex(var_3_0.rare)

	if arg_3_2 then
		local var_3_1 = var_3_0.params[1]
		local var_3_2 = MatrixEffectCfg[var_3_1]

		if MatrixConst.EFFECT_ACTION.AFFIX == var_3_2.action then
			local var_3_3 = var_3_2.params[1]
			local var_3_4 = AffixTypeCfg[var_3_3]
			local var_3_5

			if var_3_4.max_level ~= 1 then
				local var_3_6 = arg_3_2
				local var_3_7 = math.min(var_3_6, var_3_4.max_level)

				arg_3_0.m_name.text = GetI18NText(var_3_0.name) .. "Lv" .. var_3_7
			end
		end
	end
end

return var_0_0
