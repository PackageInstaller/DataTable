class = var_0_10000

local var_0_0 = "IslandShipSkill"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.level then
		var_1_0 = 1
	end

	arg_1_0.level = var_1_0
	defaultValue = var_1_0
	arg_1_0.isUsedToday = var_1_0(arg_1_1.isUseToday, false)
	arg_1_0.maxLevel = 1

	arg_1_0:InitMaxLevel()

	arg_1_0.lock = true

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_chara_skill
end

function var_0_1.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_1.GetIcon(arg_4_0)
	return arg_4_0:getConfig("icon")
end

function var_0_1.Unlock(arg_5_0)
	arg_5_0.lock = false

	if arg_5_0.level <= 0 then
		arg_5_0.level = 1
	end

	return
end

function var_0_1.IsUnlock(arg_6_0)
	return not arg_6_0.lock
end

function var_0_1.GetLevel(arg_7_0)
	return arg_7_0.level
end

function var_0_1.IsMaxLevel(arg_8_0)
	return arg_8_0.level >= arg_8_0.maxLevel
end

function var_0_1.InitMaxLevel(arg_9_0)
	arg_9_0.maxLevel = #arg_9_0:getConfig("skill_effect")

	return
end

function var_0_1.Upgrade(arg_10_0)
	if arg_10_0:IsMaxLevel() then
		return
	end

	arg_10_0.level = arg_10_0.level + 1

	return
end

function var_0_1.IsGreetingType(arg_11_0)
	underscore = var_1_10001

	return var_1_10001.any(arg_11_0:GetEffectIds(), function(arg_12_0)
		pg = var_2_10001

		local var_12_0 = var_2_10001.island_buff_template[arg_12_0]

		IslandBuffType = var_2_10002

		return var_2_10002.IsGreetingType(var_12_0.buff_type)
	end)
end

local function var_0_2(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2.buff_type

	IslandBuffType = var_1_10004

	local var_13_2

	if var_13_0 == var_1_10004.SHIP_POWER_RECOVER_BY_GREETING then
		local function var_13_1()
			local var_14_0 = arg_13_1
			local var_14_1 = var_0.GetCurrentEnergy(var_14_0)
			local var_14_2 = arg_13_2.type_use[1]
			local var_14_3 = arg_13_2.type_use[2]

			return var_14_1 <= var_14_2
		end

		var_13_2 = not arg_13_0 and var_13_1()

		return var_13_2
	else
		local var_13_3 = arg_13_2.buff_type

		IslandBuffType = var_13_2

		if var_13_3 == var_13_2.SHIP_AWARD_BY_GREETING then
			return not arg_13_0
		else
			return true
		end
	end

	return
end

function var_0_1.CanUse4Ship(arg_15_0, arg_15_1, arg_15_2)
	underscore = var_1_10003

	return var_1_10003.any(arg_15_0:GetEffectIds(), function(arg_16_0)
		pg = var_2_10001

		local var_16_0 = var_2_10001.island_buff_template[arg_16_0]

		table = var_2_10002

		local var_16_1

		if var_2_10002.contains(arg_15_2, var_16_0.buff_type) then
			var_16_1 = var_0_2(arg_15_0.isUsedToday, arg_15_1, var_16_0)
		end

		return var_16_1
	end)
end

function var_0_1.Apply(arg_17_0, arg_17_1, arg_17_2)
	IslandBuffType = var_1_10003

	if arg_17_2 == var_1_10003.SHIP_POWER_RECOVER_BY_GREETING then
		ipairs = var_3

		for iter_17_0, iter_17_1 in var_3(arg_17_0:GetEffectIds()) do
			pg = var_1_10008

			if var_1_10008.island_buff_template[iter_17_1].buff_type == arg_17_2 then
				local var_17_0 = var_1_10008.type_use[1]
				local var_17_1 = var_1_10008.type_use[2]
				local var_17_2 = arg_17_1:GetEnergy()

				arg_17_1:UpdateEnergy(var_17_2 + var_17_1)
				arg_17_0:UpdateUsedToday(true)
			end
		end
	else
		IslandBuffType = var_3

		if arg_17_2 == var_3.SHIP_AWARD_BY_GREETING then
			arg_17_0:UpdateUsedToday(true)
		end
	end

	return
end

function var_0_1.UpdateUsedToday(arg_18_0, arg_18_1)
	arg_18_0.isUsedToday = arg_18_1

	return
end

function var_0_1.GetLastEffectIds(arg_19_0)
	local var_19_0

	if not arg_19_0:getConfig("skill_effect")[arg_19_0.level - 1] then
		var_19_0 = {}
	end

	return var_19_0
end

function var_0_1.GetEffectIds(arg_20_0)
	local var_20_0

	if not arg_20_0:getConfig("skill_effect")[arg_20_0.level] then
		var_20_0 = {}
	end

	return var_20_0
end

function var_0_1.GetUnlockShipEffectIds(arg_21_0)
	if arg_21_0.lock then
		return {}
	end

	underscore = var_1

	return var_1.select(arg_21_0:GetEffectIds(), function(arg_22_0)
		IslandBuffType = var_2_10001

		local var_22_0 = var_2_10001.IsGlobalType

		pg = var_2_10003

		return not var_22_0(var_2_10003.island_buff_template[arg_22_0].buff_type)
	end)
end

function var_0_1.GetEffectDesc(arg_23_0)
	if arg_23_0.lock then
		return ""
	end

	Clone = var_1

	local var_23_0 = var_1(arg_23_0:getConfig("desc"))

	ipairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0:getConfig("desc_add")) do
		string = var_7
		var_23_0 = var_7.gsub(var_23_0, "$" .. iter_23_0, iter_23_1[arg_23_0.level][1])
	end

	return var_23_0
end

function var_0_1.IsEffectiveInPlace(arg_24_0, arg_24_1)
	underscore = var_1_10002

	return var_1_10002.any(arg_24_0:GetEffectIds(), function(arg_25_0)
		pg = var_2_10001

		local var_25_0 = var_2_10001.island_buff_template[arg_25_0].buff_type

		IslandBuffType = var_2_10003

		if var_25_0 == var_2_10003.SHIP_POWER_RECOVER then
			return true
		end

		IslandBuffType = var_25_0

		local var_25_1

		if var_25_0.IsLimitPlaceType(var_1.buff_type) then
			table = var_25_1
			var_25_1 = var_25_1.contains(var_1.type_use[1], arg_24_1)
		end

		return var_25_1
	end)
end

function var_0_1.IsEffectiveInRest(arg_26_0, arg_26_1)
	underscore = var_1_10002

	return var_1_10002.any(arg_26_0:GetEffectIds(), function(arg_27_0)
		pg = var_2_10001

		local var_27_0 = var_2_10001.island_buff_template[arg_27_0]

		IslandBuffType = var_2_10002

		local var_27_1

		if var_2_10002.IsLimitRestaurantType(var_27_0.buff_type) then
			table = var_27_1
			var_27_1 = var_27_1.contains(var_27_0.type_use[1], arg_26_1)
		end

		return var_27_1
	end)
end

function var_0_1.IsAllEffectiveType(arg_28_0)
	underscore = var_1_10001

	return var_1_10001.any(arg_28_0:GetEffectIds(), function(arg_29_0)
		pg = var_2_10001

		local var_29_0 = var_2_10001.island_buff_template[arg_29_0].buff_type

		IslandBuffType = var_2_10003

		return var_29_0 == var_2_10003.SHIP_ATTR
	end)
end

function var_0_1.IsPlaceDefaultEffectiveType(arg_30_0)
	underscore = var_1_10001

	return var_1_10001.any(arg_30_0:GetEffectIds(), function(arg_31_0)
		pg = var_2_10001

		local var_31_0 = var_2_10001.island_buff_template[arg_31_0].buff_type

		IslandBuffType = var_2_10003

		return var_31_0 == var_2_10003.SHIP_POWER_RECOVER
	end)
end

function var_0_1.GetUpgradeMaterial(arg_32_0)
	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.getConfig(var_32_0, "material")
	local var_32_2 = {}

	ipairs = var_32_0

	local var_32_3

	if not var_32_1[arg_32_0.level] then
		var_32_3 = {}
	end

	for iter_32_0, iter_32_1 in var_32_0(var_32_3) do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_32_4 = var_32_2
		local var_32_5 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10012
		var_32_5.type = var_1_10012
		var_32_5.id = iter_32_1[1]
		var_32_5.count = iter_32_1[2]

		var_1_10008(var_32_4, var_32_5)
	end

	return var_32_2
end

return var_0_1
