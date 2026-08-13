class = var_0_10000

local var_0_0 = "IslandFirmOrder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandOrder"))

var_0_1.FIRM_ORDER_TYPE_COMMON = 1
var_0_1.FIRM_ORDER_TYPE_URGENCY = 2
var_0_1.FIRM_ORDER_TYPE_ACT = 3

function var_0_1.IsFirm(arg_1_0)
	return true
end

function var_0_1.CanReplace(arg_2_0)
	return false
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.island_order
end

function var_0_1.IsEmpty(arg_4_0)
	local var_4_0 = arg_4_0.showFlag

	IslandOrderSlot = var_1_10002

	return var_4_0 == var_1_10002.SHOW_FLAG_TOMORROW
end

function var_0_1.GetAwardItemAndExp(arg_5_0)
	local var_5_0 = arg_5_0:getConfig("award")
	local var_5_1, var_5_2 = arg_5_0:GenAwards(var_5_0)
	local var_5_3 = arg_5_0

	if arg_5_0.GenPtAwards(var_5_3) then
		table = var_5_3

		var_5_3.insert(var_5_1, var_4)
	end

	return var_5_1, var_5_2
end

function var_0_1.GenPtAwards(arg_6_0)
	if arg_6_0:getConfig("season_pt_num") > 0 then
		local var_6_0 = {
			id = 0
		}

		VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_3
		var_6_0.type = var_3
		var_6_0.count = var_1 or 0

		return var_6_0
	end

	return nil
end

function var_0_1.GetActivityId(arg_7_0)
	return arg_7_0:getConfig("activity_id")
end

function var_0_1.GetGroupId(arg_8_0)
	return arg_8_0:getConfig("group_id")
end

return var_0_1
