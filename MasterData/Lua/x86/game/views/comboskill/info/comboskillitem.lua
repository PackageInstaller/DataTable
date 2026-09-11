local ComboSkillItem = class("ComboSkillItem", ReduxView)

function ComboSkillItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.jumpController = ControllerUtil.GetController(self.transform_, "jump")

	self:AddBtnListener(nil, self.m_jumpBtn, function()
		JumpTools.OpenPageByJump("/heroTrammels", {
			page = 1,
			heroId = self.heroId,
			comboId = self.comboId
		})
	end)
end

function ComboSkillItem:RefreshUI(arg_3_1, arg_3_2)
	self.heroId = arg_3_2
	self.comboId = arg_3_1

	local var_3_0 = ComboSkillData:GetCurComboSkillLevel(arg_3_1)

	self.textLv_.text = GetTips("LEVEL") .. string.format("%s", var_3_0)
	self.textTitle_.text = GetI18NText(HeroSkillCfg[ComboSkillCfg[arg_3_1].skill_id].name)
	self.textSkillType_.text = GetI18NText(SkillElementCfg[HeroSkillCfg[ComboSkillCfg[arg_3_1].skill_id].element_type].name)
	self.textDesc_.text = GetI18NText(GetCfgDescription(HeroSkillCfg[ComboSkillCfg[arg_3_1].skill_id].desc[1], var_3_0, 2, ComboSkillCfg[arg_3_1].maxLevel))
	self.imageIcon_.sprite = getSpriteViaConfig("ComboSkill", ComboSkillCfg[arg_3_1].skill_id)

	for iter_3_0, iter_3_1 in ipairs(ComboSkillCfg[arg_3_1].cooperate_role_ids) do
		SetActive(self[string.format("goHeroItem%s_", iter_3_0)], true)

		self[string.format("imageHeroIcon%s_", iter_3_0)].sprite = getSpriteViaConfig("HeroLittleIcon", iter_3_1)
	end

	for iter_3_2 = #ComboSkillCfg[arg_3_1].cooperate_role_ids + 1, 3 do
		SetActive(self[string.format("goHeroItem%s_", iter_3_2)], false)
	end

	if ArchiveData:GetTrustLevel(self.heroId) == 0 then
		self.jumpController:SetSelectedIndex(0)
	else
		self.jumpController:SetSelectedIndex(1)
	end
end

function ComboSkillItem:Dispose()
	ComboSkillItem.super.Dispose(self)
end

return ComboSkillItem
