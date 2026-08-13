class = var_0_10000

local var_0_0 = "IslandAchievement"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.STATUS = {
	GET = "get",
	NORMAL = "noraml",
	GOT = "got"
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_achievement
end

function var_0_1.SetStatus(arg_3_0, arg_3_1)
	arg_3_0.status = arg_3_1

	return
end

function var_0_1.GetStatus(arg_4_0)
	return arg_4_0.status
end

function var_0_1.GetStage(arg_5_0)
	return arg_5_0:getConfig("stage")
end

function var_0_1.IsHideType(arg_6_0)
	return arg_6_0:getConfig("show_type") == 2
end

function var_0_1.GetType(arg_7_0)
	return arg_7_0:getConfig("target_type")
end

function var_0_1.GetParam(arg_8_0)
	return arg_8_0:getConfig("target_value1")
end

function var_0_1.GetNum(arg_9_0)
	return arg_9_0:getConfig("target_num")
end

function var_0_1.GetAwards(arg_10_0)
	local var_10_0 = arg_10_0

	if arg_10_0.getConfig(var_10_0, "award_display") == "" then
		return {}
	end

	underscore = var_10_0

	return var_10_0.map(var_1, function(arg_11_0)
		Drop = var_2_10001

		return var_2_10001.Create(arg_11_0)
	end)
end

function var_0_1.GetIcon(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.island_achievement[arg_12_0].group

	pg = var_1_10002

	local var_12_1 = var_1_10002.island_achievement_group

	underscore = var_1_10003

	return var_12_1[var_1_10003.detect(var_12_1.all, function(arg_13_0)
		table = var_2_10001

		return var_2_10001.contains(var_12_1[arg_13_0].achievement_list, var_12_0)
	end)].icon
end

return var_0_1
