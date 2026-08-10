local var_0_0 = class("MatrixComboSkillItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_2_0, arg_2_1)
	local var_2_0 = ComboSkillCfg[arg_2_1]
	local var_2_1 = HeroSkillCfg[var_2_0.skill_id]

	arg_2_0.textLv_.text = string.format("")
	arg_2_0.textTitle_.text = GetI18NText(var_2_1.name)
	arg_2_0.textSkillType_.text = ""
	arg_2_0.textDesc_.text = GetCfgDescription(var_2_1.desc[1], 1)
	arg_2_0.m_icon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.ComboSkill.path .. var_2_0.skill_id)

	for iter_2_0, iter_2_1 in ipairs(var_2_0.cooperate_role_ids) do
		SetActive(arg_2_0[string.format("goHeroItem%s_", iter_2_0)], true)

		arg_2_0[string.format("imageHeroIcon%s_", iter_2_0)].sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. iter_2_1)
	end

	for iter_2_2 = #var_2_0.cooperate_role_ids + 1, 3 do
		SetActive(arg_2_0[string.format("goHeroItem%s_", iter_2_2)], false)
	end
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
