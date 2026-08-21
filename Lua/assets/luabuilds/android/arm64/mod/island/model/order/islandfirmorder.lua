local var_0_0 = class("IslandFirmOrder", import(".IslandOrder"))

var_0_0.FIRM_ORDER_TYPE_COMMON = 1
var_0_0.FIRM_ORDER_TYPE_URGENCY = 2
var_0_0.FIRM_ORDER_TYPE_ACT = 3

function var_0_0.IsFirm(arg_1_0)
	return true
end

function var_0_0.CanReplace(arg_2_0)
	return false
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.island_order
end

function var_0_0.IsEmpty(arg_4_0)
	return arg_4_0.showFlag == IslandOrderSlot.SHOW_FLAG_TOMORROW
end

function var_0_0.GetAwardItemAndExp(arg_5_0)
	local var_5_0, var_5_1 = arg_5_0:GenAwards((arg_5_0:getConfig("award")))
	local var_5_2 = arg_5_0:GenPtAwards()

	if var_5_2 then
		table.insert(var_5_0, var_5_2)
	end

	return var_5_0, var_5_1
end

function var_0_0.GenPtAwards(arg_6_0)
	local var_6_0 = arg_6_0:getConfig("season_pt_num")

	if var_6_0 > 0 then
		return {
			id = 0,
			type = VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT,
			count = var_6_0 or 0
		}
	end

	return nil
end

function var_0_0.GetActivityId(arg_7_0)
	return arg_7_0:getConfig("activity_id")
end

function var_0_0.GetGroupId(arg_8_0)
	return arg_8_0:getConfig("group_id")
end

return var_0_0
