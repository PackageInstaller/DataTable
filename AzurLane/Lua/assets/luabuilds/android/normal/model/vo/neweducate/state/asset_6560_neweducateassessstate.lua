class = var_0_10000

local var_0_0 = "NewEducateAssessState"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewEducateStateBase"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.finishFlag = arg_1_1.is_finished == 1

	return
end

function var_0_1.MarkFinish(arg_2_0)
	arg_2_0.finishFlag = true

	return
end

function var_0_1.IsFinish(arg_3_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.GetCurChar(var_3_0)

	if var_1.GetAssessRankIdx(var_3_1) == 0 then
		return true
	end

	return arg_3_0.finishFlag
end

function var_0_1.Reset(arg_4_0)
	arg_4_0.finishFlag = false

	return
end

return var_0_1
