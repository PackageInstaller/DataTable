local EquipRaceConfirmView = class("EquipRaceConfirmView", ReduxView)

function EquipRaceConfirmView:UIName()
	return "Widget/System/Hero_equip/Develop/HeroEquipGroupReset"
end

function EquipRaceConfirmView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipRaceConfirmView:Init()
	self:InitUI()
	self:AddUIListener()

	self.leftController_ = self.leftCon_:GetController("state")
	self.leftHeroController_ = self.leftCon_:GetController("equippedHero")
	self.rightController_ = self.rightCon_:GetController("state")
	self.rightHeroController_ = self.rightCon_:GetController("equippedHero")
end

function EquipRaceConfirmView:InitUI()
	self:BindCfgUI()
end

function EquipRaceConfirmView:AddUIListener()
	self:AddBtnListener(self.btnLeftChoose_, nil, function()
		self:OnRaceConfirmClick(false)
	end)
	self:AddBtnListener(self.btnRightChoose_, nil, function()
		self:OnRaceConfirmClick(true)
		ShowTips("EQUIP_RACE_RESET")
	end)
end

function EquipRaceConfirmView:OnEnter()
	self.equipId = self.params_.equipId
	self.heroId = self.params_.heroId

	local var_8_0 = EquipData:GetEquipData(self.equipId)
	local var_8_1 = HeroCfg[self.heroId]

	if not var_8_0 then
		return
	end

	self.equipIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/icon_s/" .. ItemCfg[var_8_0.prefab_id].icon)

	local var_8_2 = var_8_0.race
	local var_8_3 = var_8_0.race ~= 0 and RaceEffectCfg[var_8_2]

	if var_8_0.race ~= 0 and RaceEffectCfg[var_8_2] then
		self.leftController_:SetSelectedIndex(1)

		self.leftGroupText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(var_8_3.name))
		self.leftGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", var_8_3.icon2)
		self.leftIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Group_l/" .. var_8_3.icon2)

		local var_8_4 = var_8_1 and var_8_2 == var_8_1.race

		self.leftHeroController_:SetSelectedState(var_8_1 and var_8_2 == var_8_1.race and "on" or "off")

		if var_8_4 then
			self.leftHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(self.heroId)
		end
	else
		self.leftController_:SetSelectedIndex(0)
		self.leftHeroController_:SetSelectedState("off")
	end

	local var_8_5 = var_8_0.race_preview
	local var_8_6 = var_8_0.race_preview ~= 0 and RaceEffectCfg[var_8_5]

	if var_8_0.race_preview ~= 0 and RaceEffectCfg[var_8_5] then
		self.rightController_:SetSelectedIndex(1)

		self.rightGroupText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(var_8_6.name))
		self.rightGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", var_8_6.icon2)
		self.rightIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Group_l/" .. var_8_6.icon2)

		local var_8_7 = var_8_1 and var_8_5 == var_8_1.race

		self.rightHeroController_:SetSelectedState(var_8_1 and var_8_5 == var_8_1.race and "on" or "off")

		if var_8_7 then
			self.rightHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(self.heroId)
		end
	else
		self.rightController_:SetSelectedIndex(0)
		self.rightHeroController_:SetSelectedState("off")
	end
end

function EquipRaceConfirmView:OnRaceConfirmClick(arg_9_1)
	EquipAction.QueryEquipRaceConfirm(self.equipId, arg_9_1)
end

function EquipRaceConfirmView:OnEquipRaceConfirm()
	self:Back()
end

return EquipRaceConfirmView
