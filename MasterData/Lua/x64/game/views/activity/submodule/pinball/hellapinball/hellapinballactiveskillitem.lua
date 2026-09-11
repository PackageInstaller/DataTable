local HellaPinballSkillItem = class("HellaPinballSkillItem", BaseView)

function HellaPinballSkillItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaPinballSkillItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.iconController_ = self.controllerEx_:GetController("icon")
	self.btnController_ = self.controllerEx_:GetController("btn")
end

function HellaPinballSkillItem:AddUIListener()
	self:AddBtnListener(self.equipBtn_, nil, function()
		PinballAction.EquipSkill(self.id_)
		saveData("PinballGame", "newSkillClicked" .. self.id_, true)
		PinballAction.UpdateStageRedPoint()
	end)
	self:AddBtnListener(self.removeBtn_, nil, function()
		PinballAction.UnEquipSkill(self.id_)
	end)
end

function HellaPinballSkillItem:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.id_ = arg_6_2

	self:UpdateData()
	self:RefreshUI()
end

function HellaPinballSkillItem:UpdateData()
	self.isEquiped_ = PinballData:IsSkillEquiped(self.id_)
	self.isLock_ = PinballData:IsSkillLocked(self.id_)
	self.isNew_ = PinballData:IsSkillNew(self.id_)
	self.equipNum_ = #PinballData:GetEquipedActiveSkill(self.id_)
end

function HellaPinballSkillItem:RefreshUI()
	if PinballSkillCfg[self.id_] then
		self.desc_.text = string.format(GetI18NText(PinballSkillCfg[self.id_].description), unpack(PinballSkillCfg[self.id_].effect))
		self.name_.text = GetI18NText(PinballSkillCfg[self.id_].name) or ""
		self.icon_.sprite = pureGetSpriteWithoutAtlas(PinballSkillCfg[self.id_].icon)
	end

	if self.isEquiped_ then
		self.iconController_:SetSelectedState("equiped")
		self.btnController_:SetSelectedState("remove")
	elseif self.isLock_ then
		self.iconController_:SetSelectedState("lock")
		self.btnController_:SetSelectedState("lock")

		self.lockText_.text = string.format(GetTips("HELLA_PINBALL_SKILL_LOCK_LEVEL"), PinballData:GetSkillUnlockLevel(self.id_))
	elseif self.isNew_ then
		self.iconController_:SetSelectedState("new")

		if self.equipNum_ >= 2 then
			self.btnController_:SetSelectedState("grey")
		else
			self.btnController_:SetSelectedState("equip")
		end
	else
		self.iconController_:SetSelectedState("normal")

		if self.equipNum_ >= 2 then
			self.btnController_:SetSelectedState("grey")
		else
			self.btnController_:SetSelectedState("equip")
		end
	end
end

return HellaPinballSkillItem
