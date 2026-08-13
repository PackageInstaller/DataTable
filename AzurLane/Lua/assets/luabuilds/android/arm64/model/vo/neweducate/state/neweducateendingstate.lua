class = var_0_10000

local var_0_0 = "NewEducateEndingState"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewEducateStateBase"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.ends then
		var_1_0 = {}
	end

	arg_1_0.endings = var_1_0

	local var_1_1

	if not arg_1_1.select then
		var_1_1 = 0
	end

	arg_1_0.selEnding = var_1_1

	return
end

function var_0_1.SetEndings(arg_2_0, arg_2_1)
	arg_2_0.endings = arg_2_1

	return
end

function var_0_1.GetEndings(arg_3_0)
	return arg_3_0.endings
end

function var_0_1.SelEnding(arg_4_0, arg_4_1)
	arg_4_0.selEnding = arg_4_1

	return
end

function var_0_1.IsFinish(arg_5_0)
	return arg_5_0.selEnding ~= 0
end

function var_0_1.Reset(arg_6_0)
	arg_6_0.endings = {}
	arg_6_0.selEnding = 0

	return
end

return var_0_1
