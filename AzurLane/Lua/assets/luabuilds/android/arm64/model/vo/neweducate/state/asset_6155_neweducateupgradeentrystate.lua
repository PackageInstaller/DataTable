class = var_0_10000

local var_0_0 = "NewEducateUpgradeEntryState"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewEducateStateBase"))

function var_0_1.Ctor(arg_1_0)
	arg_1_0.finishFlag = false

	return
end

function var_0_1.IsPriorityType(arg_2_0)
	return true
end

function var_0_1.GetSystemNo(arg_3_0)
	NewEducatePriorityFSM = var_1_10001

	return var_1_10001.SYSTEM.UPGRADE_ENTRY
end

function var_0_1.MarkFinish(arg_4_0)
	arg_4_0.finishFlag = true

	return
end

function var_0_1.IsFinish(arg_5_0)
	return arg_5_0.finishFlag
end

function var_0_1.Reset(arg_6_0)
	arg_6_0.finishFlag = false

	return
end

return var_0_1
