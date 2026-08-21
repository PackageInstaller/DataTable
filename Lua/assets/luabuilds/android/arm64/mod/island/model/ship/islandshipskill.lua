local var_0_0 = class("IslandShipSkill", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.level = arg_1_1.level or 1
	arg_1_0.isUsedToday = defaultValue(arg_1_1.isUseToday, false)
	arg_1_0.maxLevel = 1

	arg_1_0:InitMaxLevel()

	arg_1_0.lock = true

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_chara_skill
end

function var_0_0.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_0.GetIcon(arg_4_0)
	return arg_4_0:getConfig("icon")
end

function var_0_0.Unlock(arg_5_0)
	arg_5_0.lock = false

	if arg_5_0.level <= 0 then
		arg_5_0.level = 1
	end

	return
end

function var_0_0.IsUnlock(arg_6_0)
	return not arg_6_0.lock
end

function var_0_0.GetLevel(arg_7_0)
	return arg_7_0.level
end

function var_0_0.IsMaxLevel(arg_8_0)
	return arg_8_0.level >= arg_8_0.maxLevel
end

function var_0_0.InitMaxLevel(arg_9_0)
	arg_9_0.maxLevel = #arg_9_0:getConfig("skill_effect")

	return
end

function var_0_0.Upgrade(arg_10_0)
	if arg_10_0:IsMaxLevel() then
		return
	end

	arg_10_0.level = arg_10_0.level + 1

	return
end

function var_0_0.IsGreetingType(arg_11_0)
	return underscore.any(arg_11_0:GetEffectIds(), function(arg_12_0)
		return IslandBuffType.IsGreetingType(pg.island_buff_template[arg_12_0].buff_type)
	end)
end

local function var_0_1(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2.buff_type == IslandBuffType.SHIP_POWER_RECOVER_BY_GREETING then
		return not arg_13_0 and var_13_0()
	elseif arg_13_2.buff_type == IslandBuffType.SHIP_AWARD_BY_GREETING then
		return not arg_13_0
	else
		return true
	end

	return
end

function var_0_0.CanUse4Ship(arg_15_0, arg_15_1, arg_15_2)
	return underscore.any(arg_15_0:GetEffectIds(), function(arg_16_0)
		return table.contains(arg_15_2, pg.island_buff_template[arg_16_0].buff_type) and var_0_1(arg_15_0.isUsedToday, arg_15_1, pg.island_buff_template[arg_16_0])
	end)
end

function var_0_0.Apply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 == IslandBuffType.SHIP_POWER_RECOVER_BY_GREETING then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0:GetEffectIds()) do
			if pg.island_buff_template[iter_17_1].buff_type == arg_17_2 then
				arg_17_1:UpdateEnergy(arg_17_1:GetEnergy() + pg.island_buff_template[iter_17_1].type_use[2])
				arg_17_0:UpdateUsedToday(true)
			end
		end
	elseif arg_17_2 == IslandBuffType.SHIP_AWARD_BY_GREETING then
		arg_17_0:UpdateUsedToday(true)
	end

	return
end

function var_0_0.UpdateUsedToday(arg_18_0, arg_18_1)
	arg_18_0.isUsedToday = arg_18_1

	return
end

function var_0_0.GetLastEffectIds(arg_19_0)
	return arg_19_0:getConfig("skill_effect")[arg_19_0.level - 1] or {}
end

function var_0_0.GetEffectIds(arg_20_0)
	return arg_20_0:getConfig("skill_effect")[arg_20_0.level] or {}
end

function var_0_0.GetUnlockShipEffectIds(arg_21_0)
	if arg_21_0.lock then
		return {}
	end

	return underscore.select(arg_21_0:GetEffectIds(), function(arg_22_0)
		return not IslandBuffType.IsGlobalType(pg.island_buff_template[arg_22_0].buff_type)
	end)
end

function var_0_0.GetEffectDesc(arg_23_0)
	if arg_23_0.lock then
		return ""
	end

	local var_23_0 = Clone(arg_23_0:getConfig("desc"))

	for iter_23_0, iter_23_1 in ipairs(arg_23_0:getConfig("desc_add")) do
		var_23_0 = string.gsub(var_23_0, "$" .. iter_23_0, iter_23_1[arg_23_0.level][1])
	end

	return var_23_0
end

function var_0_0.IsEffectiveInPlace(arg_24_0, arg_24_1)
	return underscore.any(arg_24_0:GetEffectIds(), function(arg_25_0)
		if pg.island_buff_template[arg_25_0].buff_type == IslandBuffType.SHIP_POWER_RECOVER then
			return true
		end

		return IslandBuffType.IsLimitPlaceType(pg.island_buff_template[arg_25_0].buff_type) and table.contains(pg.island_buff_template[arg_25_0].type_use[1], arg_24_1)
	end)
end

function var_0_0.IsEffectiveInRest(arg_26_0, arg_26_1)
	return underscore.any(arg_26_0:GetEffectIds(), function(arg_27_0)
		return IslandBuffType.IsLimitRestaurantType(pg.island_buff_template[arg_27_0].buff_type) and table.contains(pg.island_buff_template[arg_27_0].type_use[1], arg_26_1)
	end)
end

function var_0_0.IsAllEffectiveType(arg_28_0)
	return underscore.any(arg_28_0:GetEffectIds(), function(arg_29_0)
		return pg.island_buff_template[arg_29_0].buff_type == IslandBuffType.SHIP_ATTR
	end)
end

function var_0_0.IsPlaceDefaultEffectiveType(arg_30_0)
	return underscore.any(arg_30_0:GetEffectIds(), function(arg_31_0)
		return pg.island_buff_template[arg_31_0].buff_type == IslandBuffType.SHIP_POWER_RECOVER
	end)
end

function var_0_0.GetUpgradeMaterial(arg_32_0)
	local var_32_0 = arg_32_0:getConfig("material")[arg_32_0.level] or {}

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		table.insert({}, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_32_1[1],
			count = iter_32_1[2]
		})
	end

	return {}
end

return var_0_0
