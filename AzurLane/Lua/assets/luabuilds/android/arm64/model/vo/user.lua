class = var_0_10000

local var_0_0 = "User"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1.type
	arg_1_0.arg1 = arg_1_1.arg1
	arg_1_0.arg2 = arg_1_1.arg2
	arg_1_0.arg3 = arg_1_1.arg3
	arg_1_0.arg4 = arg_1_1.arg4
	arg_1_0.id = arg_1_1.uid
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.token = arg_1_1.token
	arg_1_0.server = arg_1_1.server

	return
end

function var_0_1.isLogin(arg_2_0)
	tobool = var_1_10001

	local var_2_0

	if arg_2_0.uid and arg_2_0.server then
		var_2_0 = arg_2_0.token
	end

	return var_1_10001(var_2_0)
end

function var_0_1.clear(arg_3_0)
	arg_3_0.id = nil
	arg_3_0.uid = nil
	arg_3_0.token = nil
	arg_3_0.server = nil

	return
end

return var_0_1
