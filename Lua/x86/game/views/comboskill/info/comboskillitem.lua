local var_0_0 = class("ComboSkillItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.jumpController = ControllerUtil.GetController(arg_1_0.transform_, "jump")

	arg_1_0:AddBtnListener(nil, arg_1_0.m_jumpBtn, function()
		JumpTools.OpenPageByJump("/heroTrammels", {
			page = 1,
			heroId = arg_1_0.heroId,
			comboId = arg_1_0.comboId
		})
	end)
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.heroId = arg_3_2
	arg_3_0.comboId = arg_3_1

	local var_3_0 = ComboSkillCfg[arg_3_1]
	local var_3_1 = HeroSkillCfg[var_3_0.skill_id]
	local var_3_2 = ComboSkillData:GetCurComboSkillLevel(arg_3_1)

	arg_3_0.textLv_.text = GetTips("LEVEL") .. string.format("%s", var_3_2)
	arg_3_0.textTitle_.text = GetI18NText(var_3_1.name)
	arg_3_0.textSkillType_.text = GetI18NText(SkillElementCfg[var_3_1.element_type].name)
	arg_3_0.textDesc_.text = GetI18NText(GetCfgDescription(var_3_1.desc[1], var_3_2, 2, var_3_0.maxLevel))
	arg_3_0.imageIcon_.sprite = getSpriteViaConfig("ComboSkill", var_3_0.skill_id)

	for iter_3_0, iter_3_1 in ipairs(var_3_0.cooperate_role_ids) do
		SetActive(arg_3_0[string.format("goHeroItem%s_", iter_3_0)], true)

		arg_3_0[string.format("imageHeroIcon%s_", iter_3_0)].sprite = getSpriteViaConfig("HeroLittleIcon", iter_3_1)
	end

	for iter_3_2 = #var_3_0.cooperate_role_ids + 1, 3 do
		SetActive(arg_3_0[string.format("goHeroItem%s_", iter_3_2)], false)
	end

	if ArchiveData:GetTrustLevel(arg_3_0.heroId) == 0 then
		arg_3_0.jumpController:SetSelectedIndex(0)
	else
		arg_3_0.jumpController:SetSelectedIndex(1)
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
