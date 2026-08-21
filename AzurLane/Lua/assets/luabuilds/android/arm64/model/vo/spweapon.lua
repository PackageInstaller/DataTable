local var_0_0 = class("SpWeapon", import(".BaseVO"))

var_0_0.type = DROP_TYPE_SPWEAPON
var_0_0.CONFIRM_OP_DISCARD = 0
var_0_0.CONFIRM_OP_EXCHANGE = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.configId = arg_1_1.id

	return
end

function var_0_0.CreateByNet(arg_2_0)
	if arg_2_0.template_id == 0 then
		return
	end

	return var_0_0.New({
		uid = arg_2_0.id,
		id = arg_2_0.template_id,
		attr1 = arg_2_0.attr_1,
		attr2 = arg_2_0.attr_2,
		attrTemp1 = arg_2_0.attr_temp_1,
		attrTemp2 = arg_2_0.attr_temp_2,
		pt = arg_2_0.pt
	})
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.spweapon_data_statistics
end

function var_0_0.GetUID(arg_4_0)
	return arg_4_0.uid
end

function var_0_0.IsReal(arg_5_0)
	return tobool(arg_5_0:GetUID())
end

function var_0_0.GetConfigID(arg_6_0)
	return arg_6_0.configId
end

function var_0_0.GetOriginID(arg_7_0)
	return arg_7_0:getConfig("base") or arg_7_0:GetConfigID()
end

function var_0_0.IsImportant(arg_8_0)
	return arg_8_0:getConfig("important") == 2
end

function var_0_0.IsUnique(arg_9_0)
	return arg_9_0:getConfig("unique") ~= 0
end

function var_0_0.GetUniqueGroup(arg_10_0)
	return arg_10_0:getConfig("unique")
end

function var_0_0.GetType(arg_11_0)
	return arg_11_0:getConfig("type")
end

function var_0_0.GetName(arg_12_0)
	return arg_12_0:getConfig("name")
end

function var_0_0.GetLevel(arg_13_0)
	return arg_13_0:getConfig("level")
end

function var_0_0.GetTechTier(arg_14_0)
	return arg_14_0:getConfig("tech")
end

function var_0_0.GetIconPath(arg_15_0)
	return "SpWeapon/" .. arg_15_0:getConfig("icon")
end

function var_0_0.GetRarity(arg_16_0)
	return arg_16_0:getConfig("rarity")
end

function var_0_0.GetPt(arg_17_0)
	if arg_17_0:IsReal() then
		return arg_17_0.pt or 0
	end
end

function var_0_0.SetPt(arg_18_0, arg_18_1)
	assert(arg_18_1)

	arg_18_0.pt = arg_18_1 or 0

	return
end

function var_0_0.GetEffect(arg_19_0)
	return arg_19_0:getConfig("effect_id")
end

function var_0_0.GetDisplayEffect(arg_20_0)
	return arg_20_0:getConfig("effect_id_display")
end

function var_0_0.GetUpgradableSkillIds(arg_21_0)
	return arg_21_0:getConfig("skill_upgrade")
end

function var_0_0.GetUpgradableHiddenSkillIds(arg_22_0)
	return arg_22_0:getConfig("hide_buff_upgrade")
end

function var_0_0.GetNextUpgradeID(arg_23_0)
	return arg_23_0:getConfig("next")
end

function var_0_0.GetPrevUpgradeID(arg_24_0)
	return arg_24_0:getConfig("prev")
end

function var_0_0.MigrateTo(arg_25_0, arg_25_1)
	local var_25_0 = Clone(arg_25_0)

	var_25_0.id = arg_25_1
	var_25_0.configId = arg_25_1
	var_25_0.pt = 0

	return var_25_0
end

function var_0_0.GetLabel(arg_26_0)
	return arg_26_0:getConfig("label")
end

function var_0_0.SetShipId(arg_27_0, arg_27_1)
	arg_27_0.shipId = arg_27_1

	return
end

function var_0_0.GetShipId(arg_28_0)
	return arg_28_0.shipId
end

function var_0_0.GetSkill(arg_29_0)
	local var_29_0 = arg_29_0:GetEffect()

	return var_29_0 > 0 and getSkillConfig(var_29_0) or nil
end

function var_0_0.GetSkillInfo(arg_30_0)
	local var_30_0 = {
		lv = 1,
		skillId = arg_30_0:GetDisplayEffect()
	}

	var_30_0.unlock = var_30_0.skillId == arg_30_0:GetEffect()

	local var_30_1 = arg_30_0:GetShipId()

	if not var_30_1 or var_30_1 == 0 then
		var_30_0.descTrigger = true
	end

	return var_30_0
end

function var_0_0.GetUpgradableSkillInfo(arg_31_0)
	local var_31_0 = arg_31_0:GetShipId()
	local var_31_1 = {}
	local var_31_2
	local var_31_3

	if var_31_0 then
		var_31_2 = getProxy(BayProxy):getShipById(var_31_0)
		var_31_3 = arg_31_0:GetActiveUpgradableSkillList(var_31_2)
	end

	for iter_31_0, iter_31_1 in ipairs(arg_31_0:GetUpgradableSkillIds()) do
		local var_31_4 = iter_31_1[2]
		local var_31_5 = 1
		local var_31_6 = false

		if var_31_2 then
			for iter_31_2, iter_31_3 in ipairs(var_31_3) do
				if iter_31_3.mapSkillID == iter_31_1[2] and iter_31_3.originalSkillID == iter_31_1[1] then
					var_31_5 = var_31_2.skills[iter_31_3.originalSkillID] and var_31_2.skills[iter_31_3.originalSkillID].level or 1
					var_31_6 = true

					break
				end
			end
		else
			var_31_6 = var_31_6 or iter_31_1[1] ~= 0
		end

		table.insert(var_31_1, {
			skillId = var_31_4,
			lv = var_31_5,
			unlock = var_31_6,
			descTrigger = not var_31_2 or nil
		})
	end

	return var_31_1
end

function var_0_0.GetActiveUpgradableSkillList(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_1:getSkillList()) do
		local var_32_0, var_32_1 = arg_32_0:RemapSkillId(iter_32_1)

		if var_32_1 then
			table.insert({}, {
				mapSkillID = var_32_0,
				originalSkillID = iter_32_1
			})
		end
	end

	for iter_32_2, iter_32_3 in ipairs(pg.ship_data_template[arg_32_1.configId].hide_buff_list) do
		local var_32_2, var_32_3 = arg_32_0:RemapSkillId(iter_32_3)

		if var_32_3 then
			table.insert({}, {
				mapSkillID = var_32_2,
				originalSkillID = iter_32_3
			})
		end
	end

	return {}
end

function var_0_0.RemapSkillId(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0:GetUpgradableSkillIds()) do
		if iter_33_1[1] == arg_33_1 then
			return iter_33_1[2], true
		end
	end

	return arg_33_1, false
end

function var_0_0.RemapHiddenSkillId(arg_34_0, arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0:GetUpgradableHiddenSkillIds()) do
		if iter_34_1[1] == arg_34_1 then
			return iter_34_1[2], true
		end
	end

	return arg_34_1, false
end

function var_0_0.GetSkillGroup(arg_35_0)
	return {
		arg_35_0:GetSkillInfo(),
		(arg_35_0:GetUpgradableSkillInfo())
	}
end

function var_0_0.GetConfigAttributes(arg_36_0)
	return {
		arg_36_0:getConfig("value_1"),
		arg_36_0:getConfig("value_2")
	}
end

function var_0_0.GetAttributesRange(arg_37_0)
	return {
		arg_37_0:getConfig("value_1_random"),
		arg_37_0:getConfig("value_2_random")
	}
end

function var_0_0.GetAttributes(arg_38_0)
	local var_38_0 = arg_38_0:GetConfigAttributes()

	if arg_38_0:IsReal() then
		var_38_0[1] = var_38_0[1] + arg_38_0.attr1
		var_38_0[2] = var_38_0[2] + arg_38_0.attr2
	end

	return var_38_0
end

function var_0_0.GetBaseAttributes(arg_39_0)
	({})[1] = arg_39_0.attr1 or 0
	;({})[2] = arg_39_0.attr2 or 0

	return {}
end

function var_0_0.SetBaseAttributes(arg_40_0, arg_40_1)
	arg_40_0.attr1 = arg_40_1[1]
	arg_40_0.attr2 = arg_40_1[2]

	return
end

function var_0_0.GetAttributeOptions(arg_41_0)
	({})[1] = arg_41_0.attrTemp1 or 0
	;({})[2] = arg_41_0.attrTemp2 or 0

	return {}
end

function var_0_0.SetAttributeOptions(arg_42_0, arg_42_1)
	arg_42_0.attrTemp1 = arg_42_1[1]
	arg_42_0.attrTemp2 = arg_42_1[2]

	return
end

function var_0_0.GetPropertiesInfo(arg_43_0)
	local var_43_0 = arg_43_0:GetAttributes()

	table.insert(({
		attrs = {}
	}).attrs, {
		type = arg_43_0:getConfig("attribute_1"),
		value = var_43_0[1]
	})
	table.insert(({
		attrs = {}
	}).attrs, {
		type = arg_43_0:getConfig("attribute_2"),
		value = var_43_0[2]
	})

	;({
		attrs = {}
	}).weapon = {
		sub = {}
	}
	;({
		attrs = {}
	}).equipInfo = {
		sub = {}
	}

	local var_43_1 = arg_43_0:GetWearableShipTypes()

	;({
		attrs = {}
	}).part = {
		var_43_1,
		var_43_1
	}

	return {
		attrs = {}
	}
end

function var_0_0.GetWearableShipTypes(arg_44_0)
	local var_44_0 = arg_44_0:getConfig("usability")

	if var_44_0 and #var_44_0 > 0 then
		return var_44_0
	end

	return pg.spweapon_type[arg_44_0:GetType()].ship_type
end

function var_0_0.IsCraftable(arg_45_0)
	return not arg_45_0:IsUnCraftable() and arg_45_0:GetUpgradeConfig().create_use_gold > 0
end

function var_0_0.GetUpgradeConfig(arg_46_0)
	return pg.spweapon_upgrade[arg_46_0:getConfig("upgrade_id")]
end

function var_0_0.IsUnCraftable(arg_47_0)
	return arg_47_0:getConfig("uncraftable") == 1
end

function var_0_0.CalculateHistoryPt(arg_48_0, arg_48_1)
	return (_.reduce(arg_48_1, _.reduce(arg_48_0, 0, function(arg_49_0, arg_49_1)
		return arg_49_0 + Item.getConfigData(arg_49_1.id).usage_arg[1] * arg_49_1.count
	end), function(arg_50_0, arg_50_1)
		return arg_50_0 + (0 + arg_50_1:GetUpgradeConfig().upgrade_supply_pt)
	end))
end

function var_0_0.IsMatchKey(arg_51_0, arg_51_1)
	return EquipmentTools.IsMatchKey({
		arg_51_0:getConfig("name")
	}, arg_51_1)
end

return var_0_0
