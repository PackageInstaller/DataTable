class = var_0_10000

local var_0_0 = var_0_10000("IslandSelectShipCard")

var_0_0.SHOW_TYPE = {
	PLACE = 1,
	RESTAURANT = 2
}

local var_0_1 = {}

Color = var_0_10002
var_0_1[1] = var_0_10002.NewHex("3DFF00")
Color = var_2
var_0_1[2] = var_2.NewHex("808080")
var_0_0.SKILL_COLOR = var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform

	local var_1_0 = arg_1_0.tf

	arg_1_0.selectedTF = var_2.Find(var_1_0, "selected")

	local var_1_1 = arg_1_0.tf

	arg_1_0.iconTF = var_2.Find(var_1_1, "icon")

	local var_1_2 = arg_1_0.tf

	arg_1_0.triedMaskTF = var_2.Find(var_1_2, "mask/tried")
	setText = var_2

	local var_1_3 = arg_1_0.triedMaskTF
	local var_1_4 = var_3.Find(var_1_3, "Text")

	i18n = var_1_3

	var_2(var_1_4, var_1_3("island_ship_no_energy"))

	local var_1_5 = arg_1_0.tf

	arg_1_0.workingMaskTF = var_2.Find(var_1_5, "mask/working")

	local var_1_6 = arg_1_0.workingMaskTF
	local var_1_7 = var_2.Find(var_1_6, "Text")

	arg_1_0.workingTextCom = var_2.GetComponent(var_1_7, "Text")

	local var_1_8 = arg_1_0.tf

	arg_1_0.followMaskTF = var_2.Find(var_1_8, "mask/follow")

	local var_1_9 = arg_1_0.tf

	arg_1_0.iconsTF = var_2.Find(var_1_9, "icons")

	local var_1_10 = arg_1_0.iconsTF

	arg_1_0.skillTF = var_2.Find(var_1_10, "skill/tpl")

	local var_1_11 = arg_1_0.iconsTF

	arg_1_0.gradeTF = var_2.Find(var_1_11, "grade")

	local var_1_12 = arg_1_0.tf

	arg_1_0.energySliderTF = var_2.Find(var_1_12, "energy_bar")

	local var_1_13 = arg_1_0.tf

	arg_1_0.energyTF = var_2.Find(var_1_13, "energy_bar/Text")

	local var_1_14 = arg_1_0.tf

	arg_1_0.nameTF = var_2.Find(var_1_14, "name")

	local var_1_15 = arg_1_0.tf

	arg_1_0.levelTF = var_2.Find(var_1_15, "level")

	local var_1_16 = {}
	local var_1_17 = arg_1_0.gradeTF

	var_1_16[1] = var_3.Find(var_1_17, "SSS")

	local var_1_18 = arg_1_0.gradeTF

	var_1_16[2] = var_3.Find(var_1_18, "SS")

	local var_1_19 = arg_1_0.gradeTF

	var_1_16[3] = var_3.Find(var_1_19, "S")

	local var_1_20 = arg_1_0.gradeTF

	var_1_16[4] = var_3.Find(var_1_20, "A")

	local var_1_21 = arg_1_0.gradeTF

	var_1_16[5] = var_3.Find(var_1_21, "B")

	local var_1_22 = arg_1_0.gradeTF

	var_1_16[6] = var_3.Find(var_1_22, "C")

	local var_1_23 = arg_1_0.gradeTF

	var_1_16[7] = var_3.Find(var_1_23, "D")

	local var_1_24 = arg_1_0.gradeTF

	var_1_16[8] = var_3.Find(var_1_24, "E")
	arg_1_0.attrTfList = var_1_16

	local var_1_25 = arg_1_0.iconsTF

	arg_1_0.skillInuse = var_2.Find(var_1_25, "skill/skill_bright")

	local var_1_26 = arg_1_0.iconsTF

	arg_1_0.skillUnuse = var_2.Find(var_1_26, "skill/skill_dark")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	arg_2_0.type = arg_2_1
	getProxy = var_1_10007
	IslandProxy = var_1_10008

	local var_2_0 = var_1_10007(var_1_10008)
	local var_2_1 = var_7.GetIsland(var_2_0)
	local var_2_2 = var_7.GetCharacterAgency(var_2_1)

	arg_2_0.ship = var_7.GetShipById(var_2_2, arg_2_2)
	arg_2_0.id = arg_2_2
	arg_2_0.attrType = arg_2_3
	arg_2_0.buildingId = arg_2_4

	arg_2_0:UpdateSelected(arg_2_5)

	IslandShip = var_7

	local var_2_3 = var_7.StaticGetPrefab(arg_2_0.id)

	GetImageSpriteFromAtlasAsync = var_8

	var_8("ShipYardIcon/" .. var_2_3, "", arg_2_0.iconTF)

	local var_2_4 = arg_2_0.ship
	local var_2_5 = var_8.GetAttr

	IslandShipAttr = var_10

	local var_2_6 = var_2_5(var_2_4, var_10.ATTRS[arg_2_0.attrType])

	IslandProductTimeHelper = var_2_4

	if var_2_4.GetAttributeAddPercentByAttribute(arg_2_2, arg_2_0.attrType) ~= 0 then
		math = var_10
		var_2_6 = var_10.floor(var_2_6 * (1 + 0.01 * var_9)) or var_2_6
	end

	local var_2_7 = arg_2_0.ship
	local var_2_8 = var_10.GetAttrGradeByValue(var_2_7, var_2_6)

	ipairs = var_2_7

	for iter_2_0, iter_2_1 in var_2_7(arg_2_0.attrTfList) do
		if iter_2_1 ~= "" then
			local var_2_9 = var_2_8 == iter_2_0

			setActive = var_1_10017

			var_1_10017(iter_2_1, var_2_9)
		end
	end

	local var_2_10 = arg_2_0.ship
	local var_2_11 = var_11.GetName(var_2_10)

	setText = var_2_10

	local var_2_12 = arg_2_0.nameTF

	shortenString = iter_2_0

	local var_2_13 = arg_2_0.ship

	var_2_10(var_2_12, iter_2_0(var_15.GetName(var_2_13), 5))

	local var_2_14 = arg_2_0.ship
	local var_2_15 = var_12.GetCurrentEnergy(var_2_14)
	local var_2_16 = arg_2_0.ship
	local var_2_17 = var_13.GetMaxEnergy(var_2_16)

	setSlider = var_2_16

	var_2_16(arg_2_0.energySliderTF, 0, 1, var_2_15 / var_2_17)

	setText = var_2_16

	var_2_16(arg_2_0.energyTF, var_2_15 .. "/" .. var_2_17)

	local var_2_18 = arg_2_0

	arg_2_0.UpdateFollowMask(var_2_18)

	if arg_2_6 then
		local var_2_19 = false

		pairs = var_2_18

		for iter_2_2, iter_2_3 in var_2_18(arg_2_6) do
			if arg_2_0.id == iter_2_3 then
				var_2_19 = true
			end
		end

		if var_2_19 then
			setActive = var_15

			var_15(arg_2_0.workingMaskTF, true)
		end
	end

	arg_2_0:UpdateSkillEffective(arg_2_0.type, arg_2_0.buildingId)

	return
end

function var_0_0.UpdateFollowMask(arg_3_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.GetIsland(var_3_0)
	local var_3_2 = var_1.GetFollowerAgency(var_3_1)
	local var_3_3 = var_1.Following(var_3_2, arg_3_0.ship.id)

	setActive = var_3_2

	var_3_2(arg_3_0.followMaskTF, var_3_3)

	setActive = var_3_2

	local var_3_4 = arg_3_0.workingMaskTF
	local var_3_6

	if not var_3_3 then
		local var_3_5 = arg_3_0.ship

		var_3_6 = not var_4.IsDelegable(var_3_5)
	else
		var_3_6 = false
	end

	if false then
		var_3_6 = true
	end

	var_3_2(var_3_4, var_3_6)

	return
end

function var_0_0.UpdateSelected(arg_4_0, arg_4_1)
	arg_4_0.selectedIds = arg_4_1
	setActive = var_1_10002

	local var_4_0 = arg_4_0.selectedTF

	table = var_1_10004

	var_1_10002(var_4_0, var_1_10004.contains(arg_4_0.selectedIds, arg_4_0.id))

	return
end

function var_0_0.UpdateSkillEffective(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_0.GetSkillEffective(arg_5_0.ship, arg_5_1, arg_5_2)

	setActive = var_4

	var_4(arg_5_0.skillInuse, var_5_0)

	setActive = var_4

	var_4(arg_5_0.skillUnuse, not var_5_0)

	return
end

function var_0_0.GetSkillEffective(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_2 then
		return false
	end

	local var_6_0 = arg_6_0:GetSkill()

	if var_3.IsAllEffectiveType(var_6_0) then
		return true
	end

	if arg_6_1 == var_0_0.SHOW_TYPE.PLACE and var_3:IsPlaceDefaultEffectiveType() then
		return true
	end

	if arg_6_1 == var_0_0.SHOW_TYPE.PLACE then
		return var_3:IsEffectiveInPlace(arg_6_2)
	elseif arg_6_1 == var_0_0.SHOW_TYPE.RESTAURANT then
		return var_3:IsEffectiveInRest(arg_6_2)
	end

	return false
end

function var_0_0.Dispose(arg_7_0)
	return
end

return var_0_0
