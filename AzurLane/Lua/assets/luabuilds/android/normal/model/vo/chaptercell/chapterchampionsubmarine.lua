class = var_0_10000

local var_0_0 = "ChapterChampionSubmarine"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ChapterChampionNormal"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_1)

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.expedition_data_template
end

function var_0_1.getPrefab(arg_3_0)
	return arg_3_0:getConfig("icon")
end

function var_0_1.getFleetType(arg_4_0)
	FleetType = var_1_10001

	return var_1_10001.Submarine
end

function var_0_1.getPoolType(arg_5_0)
	return "tpl_enemy"
end

function var_0_1.getScale(arg_6_0)
	return arg_6_0:getConfig("scale")
end

function var_0_1.inAlertRange(arg_7_0, arg_7_1, arg_7_2)
	_ = var_1_10003

	return var_1_10003.any(arg_7_0:getConfig("alert_range"), function(arg_8_0)
		return arg_8_0[1] + arg_7_0.row == arg_7_1 and arg_8_0[2] + arg_7_0.column == arg_7_2
	end)
end

return var_0_1
