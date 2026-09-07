local IslandSelectShipCard = class("IslandSelectShipCard")

IslandSelectShipCard.SHOW_TYPE = {
	PLACE = 1,
	RESTAURANT = 2
}
IslandSelectShipCard.SKILL_COLOR = {
	Color.NewHex("3DFF00"),
	Color.NewHex("808080")
}

function IslandSelectShipCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tf = arg_1_1.transform
	self.selectedTF = self.tf:Find("selected")
	self.iconTF = self.tf:Find("icon")
	self.triedMaskTF = self.tf:Find("mask/tried")

	setText(self.triedMaskTF:Find("Text"), i18n("island_ship_no_energy"))

	self.workingMaskTF = self.tf:Find("mask/working")
	self.workingTextCom = self.workingMaskTF:Find("Text"):GetComponent("Text")
	self.followMaskTF = self.tf:Find("mask/follow")
	self.iconsTF = self.tf:Find("icons")
	self.skillTF = self.iconsTF:Find("skill/tpl")
	self.gradeTF = self.iconsTF:Find("grade")
	self.energySliderTF = self.tf:Find("energy_bar")
	self.energyTF = self.tf:Find("energy_bar/Text")
	self.nameTF = self.tf:Find("name")
	self.levelTF = self.tf:Find("level")
	self.attrTfList = {
		self.gradeTF:Find("SSS"),
		self.gradeTF:Find("SS"),
		self.gradeTF:Find("S"),
		self.gradeTF:Find("A"),
		self.gradeTF:Find("B"),
		self.gradeTF:Find("C"),
		self.gradeTF:Find("D"),
		self.gradeTF:Find("E")
	}
	self.skillInuse = self.iconsTF:Find("skill/skill_bright")
	self.skillUnuse = self.iconsTF:Find("skill/skill_dark")

	return
end

function IslandSelectShipCard:Update(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	self.type = arg_2_1
	self.ship = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_2_2)
	self.id = arg_2_2
	self.attrType = arg_2_3
	self.buildingId = arg_2_4

	self:UpdateSelected(arg_2_5)
	GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(self.id), "", self.iconTF)

	local var_2_0 = self.ship:GetAttr(IslandShipAttr.ATTRS[self.attrType])
	local var_2_1 = IslandProductTimeHelper.GetAttributeAddPercentByAttribute(arg_2_2, self.attrType)

	var_2_0 = var_2_1 ~= 0 and math.floor(var_2_0 * (1 + 0.01 * var_2_1)) or var_2_0

	local var_2_2 = self.ship:GetAttrGradeByValue(var_2_0)

	for iter_2_0, iter_2_1 in ipairs(self.attrTfList) do
		if iter_2_1 ~= "" then
			setActive(iter_2_1, var_2_2 == iter_2_0)
		end
	end

	local var_2_3 = self.ship:GetName()

	setText(self.nameTF, shortenString(self.ship:GetName(), 5))

	local var_2_4 = self.ship:GetCurrentEnergy()
	local var_2_5 = self.ship:GetMaxEnergy()

	setSlider(self.energySliderTF, 0, 1, var_2_4 / var_2_5)
	setText(self.energyTF, var_2_4 .. "/" .. var_2_5)
	self:UpdateFollowMask()

	if arg_2_6 then
		local var_2_6 = false

		for iter_2_2, iter_2_3 in pairs(arg_2_6) do
			if self.id == iter_2_3 then
				var_2_6 = true
			end
		end

		if var_2_6 then
			setActive(self.workingMaskTF, true)
		end
	end

	self:UpdateSkillEffective(self.type, self.buildingId)

	return
end

function IslandSelectShipCard:UpdateFollowMask()
	local var_3_0 = getProxy(IslandProxy):GetIsland():GetFollowerAgency():Following(self.ship.id)

	setActive(self.followMaskTF, var_3_0)
	setActive(self.workingMaskTF, not var_3_0 and not self.ship:IsDelegable())

	return
end

function IslandSelectShipCard:UpdateSelected(arg_4_1)
	self.selectedIds = arg_4_1

	setActive(self.selectedTF, table.contains(self.selectedIds, self.id))

	return
end

function IslandSelectShipCard:UpdateSkillEffective(arg_5_1, arg_5_2)
	local var_5_0 = IslandSelectShipCard.GetSkillEffective(self.ship, arg_5_1, arg_5_2)

	setActive(self.skillInuse, var_5_0)
	setActive(self.skillUnuse, not var_5_0)

	return
end

function IslandSelectShipCard:GetSkillEffective(arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_2 then
		return false
	end

	local var_6_0 = self:GetSkill()

	if var_6_0:IsAllEffectiveType() then
		return true
	end

	if arg_6_1 == IslandSelectShipCard.SHOW_TYPE.PLACE and var_6_0:IsPlaceDefaultEffectiveType() then
		return true
	end

	if arg_6_1 == IslandSelectShipCard.SHOW_TYPE.PLACE then
		return var_6_0:IsEffectiveInPlace(arg_6_2)
	elseif arg_6_1 == IslandSelectShipCard.SHOW_TYPE.RESTAURANT then
		return var_6_0:IsEffectiveInRest(arg_6_2)
	end

	return false
end

function IslandSelectShipCard:Dispose()
	return
end

return IslandSelectShipCard
