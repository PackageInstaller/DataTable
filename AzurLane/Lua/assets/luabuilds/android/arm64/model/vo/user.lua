local var_0_0 = class("User", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
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

function var_0_0.isLogin(arg_2_0)
	local var_2_0 = arg_2_0.uid and arg_2_0.server and arg_2_0.token

	return tobool(var_2_0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0.id = nil
	arg_3_0.uid = nil
	arg_3_0.token = nil
	arg_3_0.server = nil

	return
end

return var_0_0
