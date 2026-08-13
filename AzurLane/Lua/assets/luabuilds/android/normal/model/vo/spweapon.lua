class = var_0_10000

local var_0_0 = "SpWeapon"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

DROP_TYPE_SPWEAPON = var_0_0
var_0_1.type = var_0_0
var_0_1.CONFIRM_OP_DISCARD = 0
var_0_1.CONFIRM_OP_EXCHANGE = 1

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.configId = arg_1_1.id

	return
end

function var_0_1.CreateByNet(arg_2_0)
	if arg_2_0.template_id == 0 then
		return
	end

	local var_2_0 = {
		uid = arg_2_0.id,
		id = arg_2_0.template_id,
		attr1 = arg_2_0.attr_1,
		attr2 = arg_2_0.attr_2,
		attrTemp1 = arg_2_0.attr_temp_1,
		attrTemp2 = arg_2_0.attr_temp_2,
		pt = arg_2_0.pt
	}

	return var_0_1.New(var_2_0)
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.spweapon_data_statistics
end

function var_0_1.GetUID(arg_4_0)
	return arg_4_0.uid
end

function var_0_1.IsReal(arg_5_0)
	tobool = var_1_10001

	return var_1_10001(arg_5_0:GetUID())
end

function var_0_1.GetConfigID(arg_6_0)
	return arg_6_0.configId
end

function var_0_1.GetOriginID(arg_7_0)
	local var_7_0

	if not arg_7_0:getConfig("base") then
		var_7_0 = arg_7_0:GetConfigID()
	end

	return var_7_0
end

function var_0_1.IsImportant(arg_8_0)
	return arg_8_0:getConfig("important") == 2
end

function var_0_1.IsUnique(arg_9_0)
	return arg_9_0:getConfig("unique") ~= 0
end

function var_0_1.GetUniqueGroup(arg_10_0)
	return arg_10_0:getConfig("unique")
end

function var_0_1.GetType(arg_11_0)
	return arg_11_0:getConfig("type")
end

function var_0_1.GetName(arg_12_0)
	return arg_12_0:getConfig("name")
end

function var_0_1.GetLevel(arg_13_0)
	return arg_13_0:getConfig("level")
end

function var_0_1.GetTechTier(arg_14_0)
	return arg_14_0:getConfig("tech")
end

function var_0_1.GetIconPath(arg_15_0)
	return "SpWeapon/" .. arg_15_0:getConfig("icon")
end

function var_0_1.GetRarity(arg_16_0)
	return arg_16_0:getConfig("rarity")
end

function var_0_1.GetPt(arg_17_0)
	local var_17_0

	if not arg_17_0:IsReal() or not arg_17_0.pt then
		var_17_0 = 0
	end

	return var_17_0
end

function var_0_1.SetPt(arg_18_0, arg_18_1)
	assert = var_1_10002

	var_1_10002(arg_18_1)

	arg_18_0.pt = arg_18_1 or 0

	return
end

function var_0_1.GetEffect(arg_19_0)
	return arg_19_0:getConfig("effect_id")
end

function var_0_1.GetDisplayEffect(arg_20_0)
	return arg_20_0:getConfig("effect_id_display")
end

function var_0_1.GetUpgradableSkillIds(arg_21_0)
	return arg_21_0:getConfig("skill_upgrade")
end

function var_0_1.GetUpgradableHiddenSkillIds(arg_22_0)
	return arg_22_0:getConfig("hide_buff_upgrade")
end

function var_0_1.GetNextUpgradeID(arg_23_0)
	return arg_23_0:getConfig("next")
end

function var_0_1.GetPrevUpgradeID(arg_24_0)
	return arg_24_0:getConfig("prev")
end

function var_0_1.MigrateTo(arg_25_0, arg_25_1)
	Clone = var_1_10002

	local var_25_0 = var_1_10002(arg_25_0)

	var_25_0.id = arg_25_1
	var_25_0.configId = arg_25_1
	var_25_0.pt = 0

	return var_25_0
end

function var_0_1.GetLabel(arg_26_0)
	return arg_26_0:getConfig("label")
end

function var_0_1.SetShipId(arg_27_0, arg_27_1)
	arg_27_0.shipId = arg_27_1

	return
end

function var_0_1.GetShipId(arg_28_0)
	return arg_28_0.shipId
end

function var_0_1.GetSkill(arg_29_0)
	local var_29_0 = arg_29_0:GetEffect()

	if 0 < var_29_0 then
		getSkillConfig = var_2

		local var_29_1

		if not var_2(var_29_0) then
			var_29_1 = nil
		end

		return var_29_1
	end
end

function var_0_1.GetSkillInfo(arg_30_0)
	var_1.unlock = ({
		lv = 1,
		skillId = arg_30_0:GetDisplayEffect()
	}).skillId == arg_30_0:GetEffect()

	return var_1
end

function var_0_1.GetUpgradableSkillInfo(arg_31_0)
	local var_31_0 = arg_31_0:GetShipId()
	local var_31_1 = {}
	local var_31_2
	local var_31_3

	if var_31_0 then
		getProxy = var_1_10005
		BayProxy = var_1_10006

		local var_31_4 = var_1_10005(var_1_10006)

		var_31_2 = var_1_10005.getShipById(var_31_4, var_31_0)
		var_31_3 = arg_31_0:GetActiveUpgradableSkillList(var_31_2)
	end

	ipairs = var_1_10005

	for iter_31_0, iter_31_1 in var_1_10005(arg_31_0:GetUpgradableSkillIds()) do
		local var_31_5 = iter_31_1[2]
		local var_31_6 = 1
		local var_31_7 = false

		if var_31_2 then
			ipairs = var_1_10013

			for iter_31_2, iter_31_3 in var_1_10013(var_31_3) do
				if iter_31_3.mapSkillID == iter_31_1[2] and iter_31_3.originalSkillID == iter_31_1[1] then
					var_31_6 = var_31_2.skills[iter_31_3.originalSkillID] and var_18.level or 1
					var_31_7 = true

					break
				end
			end
		else
			var_31_7 = var_31_7 or iter_31_1[1] ~= 0
		end

		table = var_1_10013

		var_1_10013.insert(var_31_1, {
			skillId = var_31_5,
			lv = var_31_6,
			unlock = var_31_7
		})
	end

	return var_31_1
end

function var_0_1.GetActiveUpgradableSkillList(arg_32_0, arg_32_1)
	local var_32_0 = {}

	ipairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(arg_32_1:getSkillList()) do
		local var_32_1, var_32_2 = arg_32_0:RemapSkillId(iter_32_1)

		if var_32_2 then
			table = var_10

			var_10.insert(var_32_0, {
				mapSkillID = var_32_1,
				originalSkillID = iter_32_1
			})
		end
	end

	pg = var_3

	local var_32_3 = var_3.ship_data_template[arg_32_1.configId].hide_buff_list

	ipairs = var_4

	for iter_32_2, iter_32_3 in var_4(var_32_3) do
		local var_32_4, var_32_5 = arg_32_0:RemapSkillId(iter_32_3)

		if var_32_5 then
			table = var_11

			var_11.insert(var_32_0, {
				mapSkillID = var_32_4,
				originalSkillID = iter_32_3
			})
		end
	end

	return var_32_0
end

function var_0_1.RemapSkillId(arg_33_0, arg_33_1)
	ipairs = var_1_10002

	for iter_33_0, iter_33_1 in var_1_10002(arg_33_0:GetUpgradableSkillIds()) do
		if iter_33_1[1] == arg_33_1 then
			return iter_33_1[2], true
		end
	end

	return arg_33_1, false
end

function var_0_1.RemapHiddenSkillId(arg_34_0, arg_34_1)
	ipairs = var_1_10002

	for iter_34_0, iter_34_1 in var_1_10002(arg_34_0:GetUpgradableHiddenSkillIds()) do
		if iter_34_1[1] == arg_34_1 then
			return iter_34_1[2], true
		end
	end

	return arg_34_1, false
end

function var_0_1.GetSkillGroup(arg_35_0)
	return {
		arg_35_0:GetSkillInfo(),
		(arg_35_0:GetUpgradableSkillInfo())
	}
end

function var_0_1.GetConfigAttributes(arg_36_0)
	return {
		arg_36_0:getConfig("value_1"),
		arg_36_0:getConfig("value_2")
	}
end

function var_0_1.GetAttributesRange(arg_37_0)
	return {
		arg_37_0:getConfig("value_1_random"),
		arg_37_0:getConfig("value_2_random")
	}
end

function var_0_1.GetAttributes(arg_38_0)
	local var_38_0 = arg_38_0:GetConfigAttributes()

	if arg_38_0:IsReal() then
		var_38_0[1] = var_38_0[1] + arg_38_0.attr1
		var_38_0[2] = var_38_0[2] + arg_38_0.attr2
	end

	return var_38_0
end

function var_0_1.GetBaseAttributes(arg_39_0)
	local var_39_0 = {}
	local var_39_1

	if not arg_39_0.attr1 then
		var_39_1 = 0
	end

	var_39_0[1] = var_39_1

	local var_39_2

	if not arg_39_0.attr2 then
		var_39_2 = 0
	end

	var_39_0[2] = var_39_2

	return var_39_0
end

function var_0_1.SetBaseAttributes(arg_40_0, arg_40_1)
	arg_40_0.attr1 = arg_40_1[1]
	arg_40_0.attr2 = arg_40_1[2]

	return
end

function var_0_1.GetAttributeOptions(arg_41_0)
	local var_41_0 = {}
	local var_41_1

	if not arg_41_0.attrTemp1 then
		var_41_1 = 0
	end

	var_41_0[1] = var_41_1

	local var_41_2

	if not arg_41_0.attrTemp2 then
		var_41_2 = 0
	end

	var_41_0[2] = var_41_2

	return var_41_0
end

function var_0_1.SetAttributeOptions(arg_42_0, arg_42_1)
	arg_42_0.attrTemp1 = arg_42_1[1]
	arg_42_0.attrTemp2 = arg_42_1[2]

	return
end

function var_0_1.GetPropertiesInfo(arg_43_0)
	local var_43_0 = {
		attrs = {}
	}
	local var_43_1 = arg_43_0
	local var_43_2 = arg_43_0.GetAttributes(var_43_1)

	table = var_43_1

	var_43_1.insert(var_43_0.attrs, {
		type = arg_43_0:getConfig("attribute_1"),
		value = var_43_2[1]
	})

	table = var_3

	var_3.insert(var_43_0.attrs, {
		type = arg_43_0:getConfig("attribute_2"),
		value = var_43_2[2]
	})

	var_43_0.weapon = {
		sub = {}
	}
	var_43_0.equipInfo = {
		sub = {}
	}

	local var_43_3 = arg_43_0:GetWearableShipTypes()

	var_43_0.part = {
		var_43_3,
		var_43_3
	}

	return var_43_0
end

function var_0_1.GetWearableShipTypes(arg_44_0)
	local var_44_0 = arg_44_0

	if arg_44_0.getConfig(var_44_0, "usability") and #var_1 > 0 then
		return var_1
	end

	pg = var_44_0

	return var_44_0.spweapon_type[arg_44_0:GetType()].ship_type
end

function var_0_1.IsCraftable(arg_45_0)
	return not arg_45_0:IsUnCraftable() and arg_45_0:GetUpgradeConfig().create_use_gold > 0
end

function var_0_1.GetUpgradeConfig(arg_46_0)
	local var_46_0 = arg_46_0
	local var_46_1 = arg_46_0.getConfig(var_46_0, "upgrade_id")

	pg = var_46_0

	return var_46_0.spweapon_upgrade[var_46_1]
end

function var_0_1.IsUnCraftable(arg_47_0)
	return arg_47_0:getConfig("uncraftable") == 1
end

function var_0_1.CalculateHistoryPt(arg_48_0, arg_48_1)
	_ = var_1_10002

	local var_48_0 = var_1_10002.reduce(arg_48_0, 0, function(arg_49_0, arg_49_1)
		Item = var_2_10002

		return arg_49_0 + var_2_10002.getConfigData(arg_49_1.id).usage_arg[1] * arg_49_1.count
	end)

	_ = var_3

	return (var_3.reduce(arg_48_1, var_48_0, function(arg_50_0, arg_50_1)
		return arg_50_0 + (0 + arg_50_1:GetUpgradeConfig().upgrade_supply_pt)
	end))
end

function var_0_1.IsMatchKey(arg_51_0, arg_51_1)
	local var_51_0 = {
		arg_51_0:getConfig("name")
	}

	EquipmentTools = var_3

	return var_3.IsMatchKey(var_51_0, arg_51_1)
end

return var_0_1
