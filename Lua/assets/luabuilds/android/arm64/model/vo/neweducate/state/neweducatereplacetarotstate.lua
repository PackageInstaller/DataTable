local var_0_0 = class("NewEducateReplaceTarotState", import(".NewEducateStateBase"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.queueIds = arg_1_1
	arg_1_0.holdId = 0

	return
end

function var_0_0.GetSystemNo(arg_2_0)
	return NewEducatePriorityFSM.SYSTEM.REPLACE_TAROT
end

function var_0_0.IsPriorityType(arg_3_0)
	return true
end

function var_0_0.ClearIds(arg_4_0)
	arg_4_0.queueIds = {}
	arg_4_0.holdId = 0

	return
end

function var_0_0.IsFinish(arg_5_0)
	return #arg_5_0.queueIds == 0
end

function var_0_0.GetFirstId(arg_6_0)
	return arg_6_0.queueIds[1]
end

function var_0_0.PushId(arg_7_0, arg_7_1)
	table.insert(arg_7_0.queueIds, arg_7_1)

	return
end

function var_0_0.PopId(arg_8_0)
	table.remove(arg_8_0.queueIds, 1)

	return
end

function var_0_0.SetHoldId(arg_9_0, arg_9_1)
	arg_9_0.holdId = arg_9_1

	return
end

function var_0_0.GetHoldId(arg_10_0)
	return arg_10_0.holdId
end

function var_0_0.Reset(arg_11_0)
	arg_11_0.queueIds = {}
	arg_11_0.holdId = 0

	return
end

return var_0_0
