local var_0_0 = class("NewEducateStateMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.roundFSM = NewEducateFSM.New(arg_1_1, arg_1_2)
	arg_1_0.priorityFSM = NewEducatePriorityFSM.New(arg_1_1, arg_1_2)

	return
end

function var_0_0.SetState(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.roundFSM:SetState(arg_2_1, arg_2_2)

	return
end

function var_0_0.GetState(arg_3_0, arg_3_1)
	return arg_3_0.roundFSM:GetState(arg_3_1)
end

function var_0_0.GetCurState(arg_4_0)
	return arg_4_0.roundFSM:GetCurState()
end

function var_0_0.SetCurNode(arg_5_0, arg_5_1)
	arg_5_0.roundFSM:SetCurNode(arg_5_1)

	return
end

function var_0_0.GetCurNode(arg_6_0)
	return arg_6_0.roundFSM:GetCurNode()
end

function var_0_0.SetSystemNo(arg_7_0, arg_7_1)
	arg_7_0.roundFSM:SetSystemNo(arg_7_1)

	return
end

function var_0_0.GetSystemNo(arg_8_0)
	return arg_8_0.roundFSM:GetSystemNo()
end

function var_0_0.CheckStystem(arg_9_0)
	return arg_9_0.roundFSM:CheckStystem()
end

function var_0_0.IsImmediateBenefit(arg_10_0)
	return arg_10_0.roundFSM:IsImmediateBenefit()
end

function var_0_0.GetPriorityState(arg_11_0)
	return arg_11_0.priorityFSM:GetCurState()
end

function var_0_0.CheckPriorityStystem(arg_12_0)
	return arg_12_0.priorityFSM:CheckStystem()
end

function var_0_0.AddReplaceTarotState(arg_13_0, arg_13_1)
	arg_13_0.priorityFSM:AddReplaceTarot(arg_13_1)

	return
end

function var_0_0.AddChooseState(arg_14_0, arg_14_1)
	arg_14_0.priorityFSM:PushChooseState(arg_14_1)

	return
end

function var_0_0.AddChooseUpEntryState(arg_15_0)
	arg_15_0.priorityFSM:PushUpEntryState()

	return
end

function var_0_0.Reset(arg_16_0)
	arg_16_0.roundFSM:Reset()
	arg_16_0.priorityFSM:Reset()

	return
end

return var_0_0
