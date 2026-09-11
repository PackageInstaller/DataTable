local HellaPinballSkillItem = class("HellaPinballSkillItem", BaseView)

function HellaPinballSkillItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaPinballSkillItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.levelController_ = self.controllerEx_:GetController("level")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.tipsController_ = self.controllerEx_:GetController("tips")
end

function HellaPinballSkillItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self.tipsController_:SetSelectedState("on")

		if self.clickCallBack_ then
			self.clickCallBack_(self.index_)
		end
	end)
end

function HellaPinballSkillItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.id_ = arg_5_2
	self.isEquiped_ = PinballData:IsSkillEquiped(self.id_)
	self.isLock_ = PinballData:IsSkillLocked(self.id_)
	self.isNew_ = PinballData:IsSkillNew(self.id_)

	self:RefreshUI()
end

function HellaPinballSkillItem:RefreshUI()
	if PinballSkillCfg[self.id_] then
		self.descText_.text = string.format(GetI18NText(PinballSkillCfg[self.id_].description), unpack(PinballSkillCfg[self.id_].effect))
		self.icon_.sprite = pureGetSpriteWithoutAtlas(PinballSkillCfg[self.id_].icon)
		self.nameText_.text = PinballSkillCfg[self.id_].name
		self.levelText_.text = string.format(GetTips("PINBALLGAME_GAME_SKILL_LEVEL"), table.indexof(PinballSkillCfg.get_id_list_by_skill_group[PinballSkillCfg[self.id_].skill_group], self.id_))

		self.levelController_:SetSelectedState("lv" .. table.indexof(PinballSkillCfg.get_id_list_by_skill_group[PinballSkillCfg[self.id_].skill_group], self.id_))
		self.lockController_:SetSelectedState(self.isLock_ and "on" or "off")

		self.lockText_.text = string.format(GetTips("HELLA_PINBALL_SKILL_LOCK_LEVEL"), PinballData:GetSkillUnlockLevel(self.id_))
	end
end

function HellaPinballSkillItem:SetSelectedState(arg_7_1)
	self.tipsController_:SetSelectedState(arg_7_1)
end

function HellaPinballSkillItem:SetClickCallBack(arg_8_1)
	self.clickCallBack_ = arg_8_1
end

return HellaPinballSkillItem
