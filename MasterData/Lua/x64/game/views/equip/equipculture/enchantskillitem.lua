local EnchantSkillItem = class("EnchantSkillItem", ReduxView)

function EnchantSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function EnchantSkillItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.transCon_:GetController("select")
	self.lockController_ = self.transCon_:GetController("lock")
	self.nullController_ = self.transCon_:GetController("null")
	self.popController_ = self.transCon_:GetController("pop")
	self.downLvController_ = self.transCon_:GetController("level1")
	self.leftLvController_ = self.transCon_:GetController("level2")

	self:AddBtnListener(nil, nil, "OnClick")
end

function EnchantSkillItem:RefreshData(arg_3_1)
	self.info_ = arg_3_1

	self:RefreshUI()
end

function EnchantSkillItem:RefreshUI()
	if self.info_ then
		local var_4_0 = EquipSkillCfg[self.info_.id]

		self.nullController_:SetSelectedState("skill")

		if self.info_.preview then
			self.lockController_:SetSelectedState("unlock")
			self.popController_:SetSelectedState("pop")
			self.downLvController_:SetSelectedState("off")
			self.leftLvController_:SetSelectedState("showMax")

			self.lvMax_.text = var_4_0.lvmax
		elseif self.info_.total then
			self.lockController_:SetSelectedState("unlock")
			self.popController_:SetSelectedState("pop")
			self.downLvController_:SetSelectedState("off")
			self.leftLvController_:SetSelectedState("showNum")

			self.lvMax_ = var_4_0.lvmax
		elseif self.info_.unlockLevel and self.info_.equipLevel < self.info_.unlockLevel then
			self.lockController_:SetSelectedState("lock")

			self.lockDesc_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), self.info_.unlockLevel)
		else
			self.lockController_:SetSelectedState("unlock")
		end

		self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_4_0.icon)
		self.name_.text = GetI18NText(var_4_0.name)

		local var_4_1 = self.info_.num > var_4_0.lvmax and string.format("<color=#FF000B>%s</color>", self.info_.num) or self.info_.num

		self.lv1_.text = string.format("%s/%s", var_4_1, var_4_0.lvmax)

		if self.lv2_ then
			self.lv2_.text = string.format("%s/%s", var_4_1, var_4_0.lvmax)
		end

		local var_4_2 = var_4_0.upgrade / var_4_0.percent * ((self.info_.num > var_4_0.lvmax or nil) and (var_4_0.lvmax or self.info_.num))
		local var_4_3 = GetCfgDescriptionWithValue(var_4_0.desc[1], tostring(var_4_0.upgrade / var_4_0.percent * ((self.info_.num > var_4_0.lvmax or nil) and (var_4_0.lvmax or self.info_.num))))

		if var_4_0.desc_spec_value ~= nil and var_4_0.desc_spec_value ~= "" then
			var_4_3 = string.gsub(var_4_3, tostring(var_4_2), var_4_0.desc_spec_value[self.info_.num])
		end

		self.desc_.text = GetI18NText(var_4_3)
	else
		self.nullController_:SetSelectedState("null")
	end
end

function EnchantSkillItem:ShowSelect(arg_5_1)
	self.selectController_:SetSelectedState(arg_5_1 and "select" or "unselect")
end

function EnchantSkillItem:OnClick()
	if self.info_ and self.clickFunc then
		self:clickFunc(self.info_)
	end
end

function EnchantSkillItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function EnchantSkillItem:GetItemInfo()
	return self.info_
end

function EnchantSkillItem:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function EnchantSkillItem:Dispose()
	self.clickFunc = nil

	self:RemoveAllListeners()
	EnchantSkillItem.super.Dispose(self)
end

return EnchantSkillItem
