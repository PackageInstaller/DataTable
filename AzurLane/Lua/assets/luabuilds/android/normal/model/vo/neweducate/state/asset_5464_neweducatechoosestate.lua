class = var_0_10000

local var_0_0 = "NewEducateChooseState"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewEducateStateBase"))

var_0_1.TYPE = {
	ENTRY = 2,
	TAROT = 1
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdataData(arg_1_1)

	arg_1_0.finishFlag = false

	return
end

function var_0_1.IsPriorityType(arg_2_0)
	return true
end

function var_0_1.GetSystemNo(arg_3_0)
	NewEducatePriorityFSM = var_1_10001

	return var_1_10001.SYSTEM.CHOOSE
end

function var_0_1.UpdataData(arg_4_0, arg_4_1)
	arg_4_0.choices = {}
	ipairs = var_2

	local var_4_0

	if not arg_4_1.selects then
		var_4_0 = {}
	end

	for iter_4_0, iter_4_1 in var_2(var_4_0) do
		table = var_1_10007

		var_1_10007.insert(arg_4_0.choices, iter_4_1.id)
	end

	local var_4_1

	if not arg_4_1.reroll_count then
		var_4_1 = {}
	end

	arg_4_0.refreshCnts = var_4_1
	arg_4_0.isFromShop = arg_4_1.is_from_shop == 1

	return
end

function var_0_1.GetChoices(arg_5_0)
	return arg_5_0.choices
end

function var_0_1.GetUsedCnts(arg_6_0)
	return arg_6_0.refreshCnts
end

function var_0_1.IsFromShop(arg_7_0)
	return arg_7_0.isFromShop
end

function var_0_1.MarkFinish(arg_8_0)
	arg_8_0.finishFlag = true

	return
end

function var_0_1.IsFinish(arg_9_0)
	return arg_9_0.finishFlag
end

function var_0_1.Reset(arg_10_0)
	arg_10_0.choices = {}
	arg_10_0.refreshCnts = {}
	arg_10_0.finishFlag = false

	return
end

return var_0_1
