class = var_0_10000

local var_0_0 = "MainBaseBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseEventLogic"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0._tf = arg_1_1

	return
end

function var_0_1.GetTarget(arg_2_0)
	return arg_2_0._tf
end

function var_0_1.IsFixed(arg_3_0)
	return false
end

function var_0_1.OnClick(arg_4_0)
	return
end

function var_0_1.Flush(arg_5_0, arg_5_1)
	return
end

function var_0_1.Dispose(arg_6_0)
	arg_6_0:disposeEvent()

	return
end

return var_0_1
