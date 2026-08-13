class = var_0_10000

local var_0_0 = "NewEducatePlan"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPE = {
	OTHER = 2,
	STUDY = 1
}

local var_0_2 = {}
local var_0_3 = var_0_1.TYPE.STUDY

i18n = var_3
var_0_2[var_0_3] = var_3("child2_plan_type1")

local var_0_4 = var_0_1.TYPE.OTHER

i18n = var_3
var_0_2[var_0_4] = var_3("child2_plan_type2")
var_0_1.TYPE2NAME = var_0_2

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.child2_plan
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_0.id
	arg_2_0.isExtraPlan = arg_2_2

	return
end

function var_0_1.IsShow(arg_3_0)
	return arg_3_0:getConfig("is_show") == 1
end

function var_0_1.GetCostShowInfos(arg_4_0)
	NewEducateHelper = var_1_10001

	return var_1_10001.Config2Drops(arg_4_0:getConfig("cost"))
end

function var_0_1.GetCostWithBenefit(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if arg_5_1[arg_5_0.id] then
		ipairs = var_1_10004

		for iter_5_0, iter_5_1 in var_1_10004(arg_5_0:GetCostShowInfos()) do
			Clone = var_1_10009
			var_1_10009 = var_1_10009(iter_5_1)

			if var_3[iter_5_1.type] and var_3[iter_5_1.type][iter_5_1.id] then
				NewEducateHelper = var_11
				var_1_10009.number = var_11.GetBenefitValue(iter_5_1.number, var_10)
			end

			table = var_10

			var_10.insert(var_5_0, var_1_10009)
		end

		return var_5_0
	else
		return arg_5_0:GetCostShowInfos()
	end

	return
end

function var_0_1.GetAwardShowInfos(arg_6_0)
	NewEducateHelper = var_1_10001

	return var_1_10001.Config2Drops(arg_6_0:getConfig("result_display"))
end

function var_0_1.GetNextId(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.child2_plan.get_id_list_by_group_id[arg_7_0:getConfig("group_id")]

	underscore = var_2

	return var_2.detect(var_7_0, function(arg_8_0)
		pg = var_2_10001

		local var_8_0 = var_2_10001.child2_plan[arg_8_0].level
		local var_8_1 = arg_7_0

		return var_8_0 == var_2.getConfig(var_8_1, "level") + 1
	end)
end

function var_0_1.GetUpgradeConditions(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.getConfig(var_9_0, "level_condition")
	local var_9_2 = arg_9_1:GetConditionIdsFromComplex(var_9_1)

	underscore = var_9_0

	local var_9_3

	if not var_9_0.select(var_9_2, function(arg_10_0)
		pg = var_2_10001

		local var_10_0 = var_2_10001.child2_condition[arg_10_0].type

		NewEducateConst = var_2_10003

		if var_10_0 == var_2_10003.CONDITION_TYPE.DROP then
			local var_10_1 = var_1.param[1]

			NewEducateConst = var_3

			local var_10_2

			if var_10_1 ~= var_3.DROP_TYPE.ATTR then
				var_10_2 = false
			else
				var_10_2 = true
			end

			return var_10_2
		end
	end) then
		var_9_3 = {}
	end

	return var_9_3
end

function var_0_1.IsExtraPlan(arg_11_0)
	return arg_11_0.isExtraPlan
end

function var_0_1.GetAwardBg(arg_12_0)
	return arg_12_0:getConfig("type") == var_0_1.TYPE.STUDY and "desc_bg_orange" or "desc_bg_purple"
end

return var_0_1
