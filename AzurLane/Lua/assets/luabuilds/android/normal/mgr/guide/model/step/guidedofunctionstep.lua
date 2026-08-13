class = var_0_10000

local var_0_0 = "GuideDoFunctionStep"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuideStep"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.func = arg_1_1.doFunc

	return
end

function var_0_1.GetType(arg_2_0)
	GuideStep = var_1_10001

	return var_1_10001.TYPE_DOFUNC
end

function var_0_1.GetFunction(arg_3_0)
	return arg_3_0.func
end

function var_0_1.ExistTrigger(arg_4_0)
	return true
end

return var_0_1
