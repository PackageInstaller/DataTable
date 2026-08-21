local var_0_0 = class("NewEducateBuff", import("model.vo.BaseVO"))

var_0_0.TYPE = {
	TALENT = 1,
	TAROT = 3,
	ENTRY = 4,
	STATUS = 2
}
var_0_0.RARITY = {
	BLUE = 1,
	GOLD = 3,
	PURPLE = 2,
	COLOURS = 4
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.child2_benefit_list
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.round = arg_2_1.round
	arg_2_0.isPending = arg_2_1.is_pending == 1

	arg_2_0:InitEndRound()

	arg_2_0.effectNums = {}

	return
end

function var_0_0.InitEndRound(arg_3_0)
	local var_3_0 = arg_3_0:getConfig("during_time")

	arg_3_0.endRound = var_3_0 == -1 and var_3_0 or arg_3_0.round + var_3_0

	return
end

function var_0_0.IsPending(arg_4_0)
	return arg_4_0.isPending
end

function var_0_0.GetEndRound(arg_5_0)
	return arg_5_0.endRound
end

function var_0_0.OnNextRound(arg_6_0, arg_6_1)
	if not arg_6_0.isPending then
		return
	end

	arg_6_0.isPending = false
	arg_6_0.round = arg_6_1

	arg_6_0:InitEndRound()

	return
end

function var_0_0.GetBenefitIdsByEffectType(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0:getConfig("show_content")) do
		if underscore.any(pg.child2_benefit[iter_7_1].effect, function(arg_8_0)
			assert(type(arg_8_0) == "table", "请检查effect配置的括号,benefit id:" .. iter_7_1)

			return arg_8_0[1] == arg_7_1
		end) then
			table.insert({}, iter_7_1)
		end
	end

	return {}
end

function var_0_0.UpdateDisplayNum(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		arg_9_0.effectNums[iter_9_1.key] = iter_9_1.value
	end

	return
end

function var_0_0.GetDisplayNum(arg_10_0, arg_10_1)
	return arg_10_0.effectNums[arg_10_1] or 0
end

function var_0_0.IsVisible(arg_11_0)
	local var_11_0 = pg.child2_benefit_list[arg_11_0]

	return pg.child2_benefit_list[arg_11_0].ignore_on_collection ~= 1 and var_11_0.is_show ~= 0
end

return var_0_0
