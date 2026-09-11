local NewComboSkillItem = class("NewComboSkillItem", ReduxView)

function NewComboSkillItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUi()
end

function NewComboSkillItem:InitUi()
	self:BindCfgUI()

	self.jumpController = self.controllerexcollection_:GetController("jump")

	self:AddBtnListener(nil, self.m_jumpBtn, function()
		JumpTools.OpenPageByJump("/heroTrammels", {
			page = 1,
			heroId = self.heroId,
			comboId = self.comboId
		})
	end)
	TerminologyTools.AddTerminologyHandler(self, self.textDesc_, nil, nil)
end

function NewComboSkillItem:RefreshUI(arg_4_1, arg_4_2)
	self.heroId = arg_4_2
	self.comboId = arg_4_1

	local var_4_0 = ComboSkillData:GetCurComboSkillLevel(arg_4_1)

	self.textLv_.text = GetTips("LEVEL") .. string.format("%s", var_4_0)
	self.textTitle_.text = GetI18NText(HeroSkillCfg[ComboSkillCfg[arg_4_1].skill_id].name)
	self.textDesc_.text = GetI18NText(GetCfgDescription(HeroSkillCfg[ComboSkillCfg[arg_4_1].skill_id].desc[1], var_4_0, 2, ComboSkillCfg[arg_4_1].maxLevel))
	self.imageIcon_.sprite = getSpriteViaConfig("ComboSkill", ComboSkillCfg[arg_4_1].skill_id)

	local var_4_1 = deepClone(ComboSkillCfg[arg_4_1].cooperate_role_ids)

	CommonTools.UniversalSortEx(var_4_1, {
		map = function(arg_5_0)
			return arg_5_0
		end
	})

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		SetActive(self[string.format("roleitem%sGo_", iter_4_0)], true)

		self[string.format("iconImg%s_", iter_4_0)].sprite = getSpriteViaConfig("HeroItemshead", iter_4_1)
	end

	for iter_4_2 = #ComboSkillCfg[arg_4_1].cooperate_role_ids + 1, 3 do
		SetActive(self[string.format("roleitem%sGo_", iter_4_2)], false)
	end

	if ArchiveData:GetTrustLevel(self.heroId) == 0 then
		self.jumpController:SetSelectedIndex(0)
	else
		self.jumpController:SetSelectedIndex(1)
	end
end

function NewComboSkillItem:Dispose()
	NewComboSkillItem.super.Dispose(self)
end

return NewComboSkillItem
