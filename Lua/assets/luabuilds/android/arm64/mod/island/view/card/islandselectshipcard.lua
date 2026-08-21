local var_0_0 = class("IslandSelectShipCard")

var_0_0.SHOW_TYPE = {
	PLACE = 1,
	RESTAURANT = 2
}
var_0_0.SKILL_COLOR = {
	Color.NewHex("3DFF00"),
	Color.NewHex("808080")
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	arg_1_0.selectedTF = arg_1_0.tf:Find("selected")
	arg_1_0.iconTF = arg_1_0.tf:Find("icon")
	arg_1_0.triedMaskTF = arg_1_0.tf:Find("mask/tried")

	setText(arg_1_0.triedMaskTF:Find("Text"), i18n("island_ship_no_energy"))

	arg_1_0.workingMaskTF = arg_1_0.tf:Find("mask/working")
	arg_1_0.workingTextCom = arg_1_0.workingMaskTF:Find("Text"):GetComponent("Text")
	arg_1_0.followMaskTF = arg_1_0.tf:Find("mask/follow")
	arg_1_0.iconsTF = arg_1_0.tf:Find("icons")
	arg_1_0.skillTF = arg_1_0.iconsTF:Find("skill/tpl")
	arg_1_0.gradeTF = arg_1_0.iconsTF:Find("grade")
	arg_1_0.energySliderTF = arg_1_0.tf:Find("energy_bar")
	arg_1_0.energyTF = arg_1_0.tf:Find("energy_bar/Text")
	arg_1_0.nameTF = arg_1_0.tf:Find("name")
	arg_1_0.levelTF = arg_1_0.tf:Find("level")
	arg_1_0.attrTfList = {
		arg_1_0.gradeTF:Find("SSS"),
		arg_1_0.gradeTF:Find("SS"),
		arg_1_0.gradeTF:Find("S"),
		arg_1_0.gradeTF:Find("A"),
		arg_1_0.gradeTF:Find("B"),
		arg_1_0.gradeTF:Find("C"),
		arg_1_0.gradeTF:Find("D"),
		arg_1_0.gradeTF:Find("E")
	}
	arg_1_0.skillInuse = arg_1_0.iconsTF:Find("skill/skill_bright")
	arg_1_0.skillUnuse = arg_1_0.iconsTF:Find("skill/skill_dark")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	arg_2_0.type = arg_2_1
	arg_2_0.ship = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_2_2)
	arg_2_0.id = arg_2_2
	arg_2_0.attrType = arg_2_3
	arg_2_0.buildingId = arg_2_4

	arg_2_0:UpdateSelected(arg_2_5)
	GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(arg_2_0.id), "", arg_2_0.iconTF)

	local var_2_0 = arg_2_0.ship:GetAttr(IslandShipAttr.ATTRS[arg_2_0.attrType])
	local var_2_1 = IslandProductTimeHelper.GetAttributeAddPercentByAttribute(arg_2_2, arg_2_0.attrType)

	var_2_0 = var_2_1 ~= 0 and math.floor(var_2_0 * (1 + 0.01 * var_2_1)) or var_2_0

	local var_2_2 = arg_2_0.ship:GetAttrGradeByValue(var_2_0)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.attrTfList) do
		if iter_2_1 ~= "" then
			setActive(iter_2_1, var_2_2 == iter_2_0)
		end
	end

	local var_2_3 = arg_2_0.ship:GetName()

	setText(arg_2_0.nameTF, shortenString(arg_2_0.ship:GetName(), 5))

	local var_2_4 = arg_2_0.ship:GetCurrentEnergy()
	local var_2_5 = arg_2_0.ship:GetMaxEnergy()

	setSlider(arg_2_0.energySliderTF, 0, 1, var_2_4 / var_2_5)
	setText(arg_2_0.energyTF, var_2_4 .. "/" .. var_2_5)
	arg_2_0:UpdateFollowMask()

	if arg_2_6 then
		local var_2_6 = false

		for iter_2_2, iter_2_3 in pairs(arg_2_6) do
			if arg_2_0.id == iter_2_3 then
				var_2_6 = true
			end
		end

		if var_2_6 then
			setActive(arg_2_0.workingMaskTF, true)
		end
	end

	arg_2_0:UpdateSkillEffective(arg_2_0.type, arg_2_0.buildingId)

	return
end

function var_0_0.UpdateFollowMask(arg_3_0)
	local var_3_0 = getProxy(IslandProxy):GetIsland():GetFollowerAgency():Following(arg_3_0.ship.id)

	setActive(arg_3_0.followMaskTF, var_3_0)
	setActive(arg_3_0.workingMaskTF, not var_3_0 and not arg_3_0.ship:IsDelegable())

	return
end

function var_0_0.UpdateSelected(arg_4_0, arg_4_1)
	arg_4_0.selectedIds = arg_4_1

	setActive(arg_4_0.selectedTF, table.contains(arg_4_0.selectedIds, arg_4_0.id))

	return
end

function var_0_0.UpdateSkillEffective(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_0.GetSkillEffective(arg_5_0.ship, arg_5_1, arg_5_2)

	setActive(arg_5_0.skillInuse, var_5_0)
	setActive(arg_5_0.skillUnuse, not var_5_0)

	return
end

function var_0_0.GetSkillEffective(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_2 then
		return false
	end

	local var_6_0 = arg_6_0:GetSkill()

	if var_6_0:IsAllEffectiveType() then
		return true
	end

	if arg_6_1 == var_0_0.SHOW_TYPE.PLACE and var_6_0:IsPlaceDefaultEffectiveType() then
		return true
	end

	if arg_6_1 == var_0_0.SHOW_TYPE.PLACE then
		return var_6_0:IsEffectiveInPlace(arg_6_2)
	elseif arg_6_1 == var_0_0.SHOW_TYPE.RESTAURANT then
		return var_6_0:IsEffectiveInRest(arg_6_2)
	end

	return false
end

function var_0_0.Dispose(arg_7_0)
	return
end

return var_0_0
