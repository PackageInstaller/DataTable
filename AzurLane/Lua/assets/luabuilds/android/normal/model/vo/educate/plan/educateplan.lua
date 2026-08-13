class = var_0_10000

local var_0_0 = "EducatePlan"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.RARITY2BG = {
	"plan_icon_grey",
	"plan_icon_purple",
	"plan_icon_yellow"
}
var_0_1.TYPE_SCHOOL = 1
var_0_1.TYPE_INTEREST = 2
var_0_1.TYPE_COMMUNITY = 3
var_0_1.TYPE_FREETIME = 4
var_0_1.TYPE_FREETIME_2 = 5

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.child_plan
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_0.id

	return
end

function var_0_1.GetIconBgName(arg_3_0)
	return var_0_1.RARITY2BG[arg_3_0:getConfig("rare")]
end

function var_0_1.IsInStage(arg_4_0, arg_4_1)
	local var_4_0

	if #arg_4_0:getConfig("stage") ~= 0 then
		table = var_2
		var_4_0 = var_2.contains(arg_4_0:getConfig("stage"), arg_4_1)

		if false then
			var_4_0 = false
		end
	else
		var_4_0 = true
	end

	return var_4_0
end

function var_0_1.GetType(arg_5_0)
	if arg_5_0:getConfig("type") == var_0_1.TYPE_FREETIME_2 then
		return var_0_1.TYPE_FREETIME
	end

	return arg_5_0:getConfig("type")
end

function var_0_1.IsInTime(arg_6_0, arg_6_1, arg_6_2)
	underscore = var_1_10003

	return var_1_10003.any(arg_6_0:getConfig("time"), function(arg_7_0)
		return arg_7_0[1] == arg_6_1 and arg_7_0[2] == arg_6_2
	end)
end

function var_0_1.IsShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0

	if arg_8_0:IsInStage(arg_8_1) then
		var_8_0 = arg_8_0:IsInTime(arg_8_2, arg_8_3)
	end

	return var_8_0
end

function var_0_1.IsMatchAttr(arg_9_0, arg_9_1)
	underscore = var_1_10002

	return var_1_10002.all(arg_9_0:getConfig("ability"), function(arg_10_0)
		local var_10_0 = arg_9_1

		return var_1.GetAttrById(var_10_0, arg_10_0[2]) >= arg_10_0[3]
	end)
end

function var_0_1.ExistNextPlanCanFill(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0

	if arg_11_0.getConfig(var_11_0, "pre_next") == 0 then
		return false
	end

	pg = var_11_0

	local var_11_1 = var_11_0.child_plan[var_2].pre[2]

	getProxy = var_4
	EducateProxy = var_1_10005

	local var_11_2 = var_4(var_1_10005)
	local var_11_3 = var_4.GetPlanProxy(var_11_2)
	local var_11_4 = var_4.GetHistoryCntById(var_11_3, arg_11_0.id)

	EducatePlan = var_11_3

	local var_11_5 = var_11_3.New(var_2)

	return var_11_1 <= var_11_4 and var_11_5:IsMatchAttr(arg_11_1)
end

function var_0_1.IsMatchPre(arg_12_0, arg_12_1)
	if #arg_12_0:getConfig("pre") == 0 then
		return true
	end

	return arg_12_1 >= var_2[2]
end

function var_0_1.GetCost(arg_13_0)
	local var_13_0 = arg_13_0:getConfig("cost_resource1")
	local var_13_1 = arg_13_0:getConfig("cost_resource2")
	local var_13_2 = arg_13_0:getConfig("cost_resource3")
end

function var_0_1.GetResult(arg_14_0)
	return arg_14_0:getConfig("result_display")
end

function var_0_1.CheckResult(arg_15_0, arg_15_1, arg_15_2)
	underscore = var_1_10003

	return var_1_10003.any(arg_15_0:GetResult(), function(arg_16_0)
		return arg_16_0[1] == arg_15_1 and arg_16_0[2] == arg_15_2 and arg_16_0[3] > 0
	end)
end

function var_0_1.CheckResultBySubType(arg_17_0, arg_17_1, arg_17_2)
	underscore = var_1_10003

	return var_1_10003.any(arg_17_0:GetResult(), function(arg_18_0)
		if arg_18_0[1] == arg_17_1 then
			EducateHelper = var_1

			local var_18_0

			if var_1.IsMatchSubType(arg_17_2, arg_18_0[2]) then
				if not (arg_18_0[3] > 0) then
					var_18_0 = false
				else
					var_18_0 = true
				end
			end

			return var_18_0
		end
	end)
end

function var_0_1.GetAttrResultValue(arg_19_0, arg_19_1)
	underscore = var_1_10002

	local var_19_0

	if not var_1_10002.select(arg_19_0:GetResult(), function(arg_20_0)
		local var_20_0 = arg_20_0[1]

		EducateConst = var_2_10002

		return var_20_0 == var_2_10002.DROP_TYPE_ATTR and arg_20_0[2] == arg_19_1 and arg_20_0[3] > 0
	end) or not var_2[3] then
		var_19_0 = 0
	end

	return var_19_0
end

function var_0_1.GetDropInfo(arg_21_0)
	local var_21_0 = {}

	underscore = var_1_10002

	var_1_10002.each(arg_21_0:GetResult(), function(arg_22_0)
		table = var_2_10001

		local var_22_0 = var_2_10001.insert
		local var_22_1 = var_21_0

		Drop = var_2_10003

		var_22_0(var_22_1, var_2_10003.New({
			type = arg_22_0[1],
			id = arg_22_0[2],
			number = arg_22_0[3]
		}))

		return
	end)

	return var_21_0
end

function var_0_1.GetPerformance(arg_23_0)
	return arg_23_0:getConfig("performance")
end

return var_0_1
