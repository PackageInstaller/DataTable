local var_0_0 = class("IslandAchievement", import("model.vo.BaseVO"))

var_0_0.STATUS = {
	GET = "get",
	NORMAL = "noraml",
	GOT = "got"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_achievement
end

function var_0_0.SetStatus(arg_3_0, arg_3_1)
	arg_3_0.status = arg_3_1

	return
end

function var_0_0.GetStatus(arg_4_0)
	return arg_4_0.status
end

function var_0_0.GetStage(arg_5_0)
	return arg_5_0:getConfig("stage")
end

function var_0_0.IsHideType(arg_6_0)
	return arg_6_0:getConfig("show_type") == 2
end

function var_0_0.GetType(arg_7_0)
	return arg_7_0:getConfig("target_type")
end

function var_0_0.GetParam(arg_8_0)
	return arg_8_0:getConfig("target_value1")
end

function var_0_0.GetNum(arg_9_0)
	return arg_9_0:getConfig("target_num")
end

function var_0_0.GetAwards(arg_10_0)
	local var_10_0 = arg_10_0:getConfig("award_display")

	if var_10_0 == "" then
		return {}
	end

	return underscore.map(var_10_0, function(arg_11_0)
		return Drop.Create(arg_11_0)
	end)
end

function var_0_0.GetIcon(arg_12_0)
	local var_12_0 = pg.island_achievement[arg_12_0].group

	return pg.island_achievement_group[underscore.detect(pg.island_achievement_group.all, function(arg_13_0)
		return table.contains(var_0[arg_13_0].achievement_list, var_12_0)
	end)].icon
end

return var_0_0
