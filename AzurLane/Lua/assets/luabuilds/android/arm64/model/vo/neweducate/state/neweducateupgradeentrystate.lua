local var_0_0 = class("NewEducateUpgradeEntryState", import(".NewEducateStateBase"))

function var_0_0.Ctor(arg_1_0)
	arg_1_0.finishFlag = false

	return
end

function var_0_0.IsPriorityType(arg_2_0)
	return true
end

function var_0_0.GetSystemNo(arg_3_0)
	return NewEducatePriorityFSM.SYSTEM.UPGRADE_ENTRY
end

function var_0_0.MarkFinish(arg_4_0)
	arg_4_0.finishFlag = true

	return
end

function var_0_0.IsFinish(arg_5_0)
	return arg_5_0.finishFlag
end

function var_0_0.Reset(arg_6_0)
	arg_6_0.finishFlag = false

	return
end

return var_0_0
