local var_0_0 = class("NewEducateChooseState", import(".NewEducateStateBase"))

var_0_0.TYPE = {
	ENTRY = 2,
	TAROT = 1
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdataData(arg_1_1)

	arg_1_0.finishFlag = false

	return
end

function var_0_0.IsPriorityType(arg_2_0)
	return true
end

function var_0_0.GetSystemNo(arg_3_0)
	return NewEducatePriorityFSM.SYSTEM.CHOOSE
end

function var_0_0.UpdataData(arg_4_0, arg_4_1)
	arg_4_0.choices = {}

	local var_4_0 = arg_4_1.selects or {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		table.insert(arg_4_0.choices, iter_4_1.id)
	end

	arg_4_0.refreshCnts = arg_4_1.reroll_count or {}
	arg_4_0.isFromShop = arg_4_1.is_from_shop == 1

	return
end

function var_0_0.GetChoices(arg_5_0)
	return arg_5_0.choices
end

function var_0_0.GetUsedCnts(arg_6_0)
	return arg_6_0.refreshCnts
end

function var_0_0.IsFromShop(arg_7_0)
	return arg_7_0.isFromShop
end

function var_0_0.MarkFinish(arg_8_0)
	arg_8_0.finishFlag = true

	return
end

function var_0_0.IsFinish(arg_9_0)
	return arg_9_0.finishFlag
end

function var_0_0.Reset(arg_10_0)
	arg_10_0.choices = {}
	arg_10_0.refreshCnts = {}
	arg_10_0.finishFlag = false

	return
end

return var_0_0
