class = var_0_10000

local var_0_0 = var_0_10000("NewEducateStateMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	NewEducateFSM = var_1_10003
	arg_1_0.roundFSM = var_1_10003.New(arg_1_1, arg_1_2)
	NewEducatePriorityFSM = var_3
	arg_1_0.priorityFSM = var_3.New(arg_1_1, arg_1_2)

	return
end

function var_0_0.SetState(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.roundFSM

	var_3.SetState(var_2_0, arg_2_1, arg_2_2)

	return
end

function var_0_0.GetState(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.roundFSM

	return var_2.GetState(var_3_0, arg_3_1)
end

function var_0_0.GetCurState(arg_4_0)
	local var_4_0 = arg_4_0.roundFSM

	return var_1.GetCurState(var_4_0)
end

function var_0_0.SetCurNode(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.roundFSM

	var_2.SetCurNode(var_5_0, arg_5_1)

	return
end

function var_0_0.GetCurNode(arg_6_0)
	local var_6_0 = arg_6_0.roundFSM

	return var_1.GetCurNode(var_6_0)
end

function var_0_0.SetSystemNo(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.roundFSM

	var_2.SetSystemNo(var_7_0, arg_7_1)

	return
end

function var_0_0.GetSystemNo(arg_8_0)
	local var_8_0 = arg_8_0.roundFSM

	return var_1.GetSystemNo(var_8_0)
end

function var_0_0.CheckStystem(arg_9_0)
	local var_9_0 = arg_9_0.roundFSM

	return var_1.CheckStystem(var_9_0)
end

function var_0_0.IsImmediateBenefit(arg_10_0)
	local var_10_0 = arg_10_0.roundFSM

	return var_1.IsImmediateBenefit(var_10_0)
end

function var_0_0.GetPriorityState(arg_11_0)
	local var_11_0 = arg_11_0.priorityFSM

	return var_1.GetCurState(var_11_0)
end

function var_0_0.CheckPriorityStystem(arg_12_0)
	local var_12_0 = arg_12_0.priorityFSM

	return var_1.CheckStystem(var_12_0)
end

function var_0_0.AddReplaceTarotState(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.priorityFSM

	var_2.AddReplaceTarot(var_13_0, arg_13_1)

	return
end

function var_0_0.AddChooseState(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.priorityFSM

	var_2.PushChooseState(var_14_0, arg_14_1)

	return
end

function var_0_0.AddChooseUpEntryState(arg_15_0)
	local var_15_0 = arg_15_0.priorityFSM

	var_1.PushUpEntryState(var_15_0)

	return
end

function var_0_0.Reset(arg_16_0)
	local var_16_0 = arg_16_0.roundFSM

	var_1.Reset(var_16_0)

	local var_16_1 = arg_16_0.priorityFSM

	var_1.Reset(var_16_1)

	return
end

return var_0_0
