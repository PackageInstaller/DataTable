local var_0_0 = class("EducatePlan", import("model.vo.BaseVO"))

var_0_0.RARITY2BG = {
	"plan_icon_grey",
	"plan_icon_purple",
	"plan_icon_yellow"
}
var_0_0.TYPE_SCHOOL = 1
var_0_0.TYPE_INTEREST = 2
var_0_0.TYPE_COMMUNITY = 3
var_0_0.TYPE_FREETIME = 4
var_0_0.TYPE_FREETIME_2 = 5

function var_0_0.bindConfigTable(arg_1_0)
	return pg.child_plan
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_0.id

	return
end

function var_0_0.GetIconBgName(arg_3_0)
	return var_0_0.RARITY2BG[arg_3_0:getConfig("rare")]
end

function var_0_0.IsInStage(arg_4_0, arg_4_1)
	return #arg_4_0:getConfig("stage") == 0 or table.contains(arg_4_0:getConfig("stage"), arg_4_1)
end

function var_0_0.GetType(arg_5_0)
	if arg_5_0:getConfig("type") == var_0_0.TYPE_FREETIME_2 then
		return var_0_0.TYPE_FREETIME
	end

	return arg_5_0:getConfig("type")
end

function var_0_0.IsInTime(arg_6_0, arg_6_1, arg_6_2)
	return underscore.any(arg_6_0:getConfig("time"), function(arg_7_0)
		return arg_7_0[1] == arg_6_1 and arg_7_0[2] == arg_6_2
	end)
end

function var_0_0.IsShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	return arg_8_0:IsInStage(arg_8_1) and arg_8_0:IsInTime(arg_8_2, arg_8_3)
end

function var_0_0.IsMatchAttr(arg_9_0, arg_9_1)
	return underscore.all(arg_9_0:getConfig("ability"), function(arg_10_0)
		return arg_9_1:GetAttrById(arg_10_0[2]) >= arg_10_0[3]
	end)
end

function var_0_0.ExistNextPlanCanFill(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getConfig("pre_next")
	local var_11_1, var_11_2

	if var_11_0 == 0 then
		do return false end

		var_11_1 = getProxy(EducateProxy):GetPlanProxy()
		var_11_2 = EducatePlan.New(var_11_0)
	end

	return pg.child_plan[var_11_0].pre[2] <= var_11_1:GetHistoryCntById(arg_11_0.id) and var_11_2:IsMatchAttr(arg_11_1)
end

function var_0_0.IsMatchPre(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getConfig("pre")

	if #var_12_0 == 0 then
		return true
	end

	return arg_12_1 >= var_12_0[2]
end

function var_0_0.GetCost(arg_13_0)
	local var_13_0 = arg_13_0:getConfig("cost_resource1")
	local var_13_1 = arg_13_0:getConfig("cost_resource2")
	local var_13_2 = arg_13_0:getConfig("cost_resource3")
end

function var_0_0.GetResult(arg_14_0)
	return arg_14_0:getConfig("result_display")
end

function var_0_0.CheckResult(arg_15_0, arg_15_1, arg_15_2)
	return underscore.any(arg_15_0:GetResult(), function(arg_16_0)
		return arg_16_0[1] == arg_15_1 and arg_16_0[2] == arg_15_2 and arg_16_0[3] > 0
	end)
end

function var_0_0.CheckResultBySubType(arg_17_0, arg_17_1, arg_17_2)
	return underscore.any(arg_17_0:GetResult(), function(arg_18_0)
		return arg_18_0[1] == arg_17_1 and EducateHelper.IsMatchSubType(arg_17_2, arg_18_0[2]) and arg_18_0[3] > 0
	end)
end

function var_0_0.GetAttrResultValue(arg_19_0, arg_19_1)
	local var_19_0 = underscore.select(arg_19_0:GetResult(), function(arg_20_0)
		return arg_20_0[1] == EducateConst.DROP_TYPE_ATTR and arg_20_0[2] == arg_19_1 and arg_20_0[3] > 0
	end)

	if var_19_0 then
		return var_19_0[3] or 0
	end
end

function var_0_0.GetDropInfo(arg_21_0)
	local var_21_0 = {}

	underscore.each(arg_21_0:GetResult(), function(arg_22_0)
		table.insert(var_21_0, Drop.New({
			type = arg_22_0[1],
			id = arg_22_0[2],
			number = arg_22_0[3]
		}))

		return
	end)

	return {}
end

function var_0_0.GetPerformance(arg_23_0)
	return arg_23_0:getConfig("performance")
end

return var_0_0
