class = var_0_10000

local var_0_0 = "MetaCharacterBreakout"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.ship_meta_breakout
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.needLevel = arg_2_0:getConfig("level")
	arg_2_0.needRepairRate = arg_2_0:getConfig("repair")
	arg_2_0.needItems = {}
	table = var_2

	var_2.insert(arg_2_0.needItems, {
		itemId = arg_2_0:getConfig("item1"),
		count = arg_2_0:getConfig("item1_num")
	})

	arg_2_0.needGold = arg_2_0:getConfig("gold")
	arg_2_0.weaponIds = arg_2_0:getConfig("weapon_ids")
	arg_2_0.breakoutView = arg_2_0:getConfig("breakout_view")

	local var_2_0 = arg_2_0

	if arg_2_0.getConfig(var_2_0, "breakout_id") ~= 0 then
		MetaCharacterBreakout = var_2_0
		arg_2_0.nextBreakInfo = var_2_0.New({
			id = var_2
		})
	end

	return
end

function var_0_1.getConsume(arg_3_0)
	return arg_3_0.needGold, arg_3_0.needItems
end

function var_0_1.getLimited(arg_4_0)
	return arg_4_0.needLevel, arg_4_0.needRepairRate
end

function var_0_1.hasNextInfo(arg_5_0)
	return arg_5_0.nextBreakInfo ~= nil
end

function var_0_1.getNextInfo(arg_6_0)
	return arg_6_0.nextBreakInfo
end

function var_0_1.getWeaponIds(arg_7_0)
	return arg_7_0.weaponIds
end

return var_0_1
