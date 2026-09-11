local MatrixComboSkillItem = class("MatrixComboSkillItem", ReduxView)

function MatrixComboSkillItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function MatrixComboSkillItem:RefreshUI(arg_2_1)
	self.textLv_.text = string.format("")
	self.textTitle_.text = GetI18NText(HeroSkillCfg[ComboSkillCfg[arg_2_1].skill_id].name)
	self.textSkillType_.text = ""
	self.textDesc_.text = GetCfgDescription(HeroSkillCfg[ComboSkillCfg[arg_2_1].skill_id].desc[1], 1)
	self.m_icon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.ComboSkill.path .. ComboSkillCfg[arg_2_1].skill_id)

	for iter_2_0, iter_2_1 in ipairs(ComboSkillCfg[arg_2_1].cooperate_role_ids) do
		SetActive(self[string.format("goHeroItem%s_", iter_2_0)], true)

		self[string.format("imageHeroIcon%s_", iter_2_0)].sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. iter_2_1)
	end

	for iter_2_2 = #ComboSkillCfg[arg_2_1].cooperate_role_ids + 1, 3 do
		SetActive(self[string.format("goHeroItem%s_", iter_2_2)], false)
	end
end

function MatrixComboSkillItem:Dispose()
	MatrixComboSkillItem.super.Dispose(self)
end

return MatrixComboSkillItem
