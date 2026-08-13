class = var_0_10000

local var_0_0 = "ReturnSpineRequestPackage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".RequestPackage"))

function var_0_1.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	if arg_1_0.callback then
		arg_1_0.callback(arg_1_0.spineChar)
	end

	local var_1_0 = arg_1_0.spineChar

	var_1.Dispose(var_1_0)

	return arg_1_0
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.path = "Spine"
	arg_2_0.name = arg_2_1
	arg_2_0.spineChar = arg_2_2
	arg_2_0.callback = arg_2_3

	return
end

return var_0_1
