class = var_0_10000

local var_0_0 = "NewEducateBuff"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPE = {
	TALENT = 1,
	TAROT = 3,
	ENTRY = 4,
	STATUS = 2
}
var_0_1.RARITY = {
	BLUE = 1,
	GOLD = 3,
	PURPLE = 2,
	COLOURS = 4
}

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.child2_benefit_list
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.round = arg_2_1.round
	arg_2_0.isPending = arg_2_1.is_pending == 1

	arg_2_0:InitEndRound()

	arg_2_0.effectNums = {}

	return
end

function var_0_1.InitEndRound(arg_3_0)
	arg_3_0.endRound = arg_3_0:getConfig("during_time") == -1 and var_1 or arg_3_0.round + var_1

	return
end

function var_0_1.IsPending(arg_4_0)
	return arg_4_0.isPending
end

function var_0_1.GetEndRound(arg_5_0)
	return arg_5_0.endRound
end

function var_0_1.OnNextRound(arg_6_0, arg_6_1)
	if not arg_6_0.isPending then
		return
	end

	arg_6_0.isPending = false
	arg_6_0.round = arg_6_1

	arg_6_0:InitEndRound()

	return
end

function var_0_1.GetBenefitIdsByEffectType(arg_7_0, arg_7_1)
	local var_7_0 = {}

	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_0:getConfig("show_content")) do
		underscore = var_7_1

		local var_7_1 = var_7_1.any

		pg = var_1_10010

		if var_7_1(var_1_10010.child2_benefit[iter_7_1].effect, function(arg_8_0)
			assert = var_2_10001
			type = var_2_10003

			var_2_10001(var_2_10003(arg_8_0) == "table", "请检查effect配置的括号,benefit id:" .. iter_7_1)

			return arg_8_0[1] == arg_7_1
		end) then
			table = var_7_1

			var_7_1.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function var_0_1.UpdateDisplayNum(arg_9_0, arg_9_1)
	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_1) do
		arg_9_0.effectNums[iter_9_1.key] = iter_9_1.value
	end

	return
end

function var_0_1.GetDisplayNum(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_0.effectNums[arg_10_1] then
		var_10_0 = 0
	end

	return var_10_0
end

function var_0_1.IsVisible(arg_11_0)
	pg = var_1_10001

	return var_1_10001.child2_benefit_list[arg_11_0].ignore_on_collection ~= 1 and var_1.is_show ~= 0
end

return var_0_1
