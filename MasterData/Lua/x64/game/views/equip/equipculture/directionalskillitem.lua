local DirectionalSkillItem = class("DirectionalSkillItem", ReduxView)

function DirectionalSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DirectionalSkillItem:InitUI()
	self:BindCfgUI()

	self.recommendController_ = self.transCon_:GetController("recommend")
	self.selectController_ = self.transCon_:GetController("select")

	self:AddBtnListener(nil, nil, "OnClick")
	self:RegistEventListener(DIRECTIONAL_ENCHANT_SLOT_CHANGE, handler(self, self.OnSlotChange))
end

function DirectionalSkillItem:RefreshData(arg_3_1, arg_3_2)
	self.info_ = arg_3_1
	self.heroId_ = arg_3_2

	self:RefreshUI()
end

function DirectionalSkillItem:RefreshUI()
	if self.info_ then
		local var_4_0 = EquipSkillCfg[self.info_.id]

		self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. EquipSkillCfg[self.info_.id].icon)
		self.nameText_.text = GetI18NText(var_4_0.name)
		self.levelText_.text = string.format("%s/%s", self.info_.num > var_4_0.lvmax and string.format("<color=#FF000B>%s</color>", self.info_.num) or self.info_.num, var_4_0.lvmax)

		local var_4_1 = var_4_0.upgrade / var_4_0.percent * ((self.info_.num > var_4_0.lvmax or nil) and (var_4_0.lvmax or self.info_.num))
		local var_4_2 = GetCfgDescriptionWithValue(var_4_0.desc[1], tostring(var_4_0.upgrade / var_4_0.percent * ((self.info_.num > var_4_0.lvmax or nil) and (var_4_0.lvmax or self.info_.num))))

		if var_4_0.desc_spec_value ~= nil and var_4_0.desc_spec_value ~= "" then
			var_4_2 = string.gsub(var_4_2, tostring(var_4_1), var_4_0.desc_spec_value[self.info_.num])
		end

		self.descText_.text = GetI18NText(var_4_2)

		self.recommendController_:SetSelectedState(self.info_.recommendLevel)
	end
end

function DirectionalSkillItem:ShowSelect(arg_5_1)
	self.selectController_:SetSelectedState(arg_5_1 and "select" or "unselect")
end

function DirectionalSkillItem:OnClick()
	if self.info_ and self.clickFunc then
		self:clickFunc(self.info_.id)
	end
end

function DirectionalSkillItem:OnSlotChange()
	self.animator_:Play("Fx_Common_alpha_cx 1", -1, 0)
end

function DirectionalSkillItem:RegisterClickFunc(arg_8_1)
	self.clickFunc = arg_8_1
end

function DirectionalSkillItem:GetItemInfo()
	return self.info_
end

function DirectionalSkillItem:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function DirectionalSkillItem:Dispose()
	self.clickFunc = nil

	self:RemoveAllListeners()
	DirectionalSkillItem.super.Dispose(self)
end

return DirectionalSkillItem
