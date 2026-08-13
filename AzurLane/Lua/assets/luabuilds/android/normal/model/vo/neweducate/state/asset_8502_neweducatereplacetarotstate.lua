class = var_0_10000

local var_0_0 = "NewEducateReplaceTarotState"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewEducateStateBase"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.queueIds = arg_1_1
	arg_1_0.holdId = 0

	return
end

function var_0_1.GetSystemNo(arg_2_0)
	NewEducatePriorityFSM = var_1_10001

	return var_1_10001.SYSTEM.REPLACE_TAROT
end

function var_0_1.IsPriorityType(arg_3_0)
	return true
end

function var_0_1.ClearIds(arg_4_0)
	arg_4_0.queueIds = {}
	arg_4_0.holdId = 0

	return
end

function var_0_1.IsFinish(arg_5_0)
	return #arg_5_0.queueIds == 0
end

function var_0_1.GetFirstId(arg_6_0)
	return arg_6_0.queueIds[1]
end

function var_0_1.PushId(arg_7_0, arg_7_1)
	table = var_1_10002

	var_1_10002.insert(arg_7_0.queueIds, arg_7_1)

	return
end

function var_0_1.PopId(arg_8_0)
	table = var_1_10001

	var_1_10001.remove(arg_8_0.queueIds, 1)

	return
end

function var_0_1.SetHoldId(arg_9_0, arg_9_1)
	arg_9_0.holdId = arg_9_1

	return
end

function var_0_1.GetHoldId(arg_10_0)
	return arg_10_0.holdId
end

function var_0_1.Reset(arg_11_0)
	arg_11_0.queueIds = {}
	arg_11_0.holdId = 0

	return
end

return var_0_1
