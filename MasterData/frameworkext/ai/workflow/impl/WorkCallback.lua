module("frameworkext.ai.workflow.impl.WorkCallback", package.seeall)

local var_0_0 = class("WorkCallback", WorkBase)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._handler = arg_1_1
	arg_1_0._handlerObj = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	var_0_0.super.onStart(arg_2_0)

	if arg_2_0._handler then
		arg_2_0._handler(arg_2_0._handlerObj)
	end

	arg_2_0:onDone(WorkResult.Succeed)
end

function var_0_0.onDestroy(arg_3_0)
	arg_3_0._handler = nil
	arg_3_0._handlerObj = nil

	var_0_0.super.onDestroy()
end

return var_0_0
