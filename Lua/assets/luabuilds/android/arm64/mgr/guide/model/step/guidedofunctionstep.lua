local var_0_0 = class("GuideDoFunctionStep", import(".GuideStep"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.func = arg_1_1.doFunc

	return
end

function var_0_0.GetType(arg_2_0)
	return GuideStep.TYPE_DOFUNC
end

function var_0_0.GetFunction(arg_3_0)
	return arg_3_0.func
end

function var_0_0.ExistTrigger(arg_4_0)
	return true
end

return var_0_0
