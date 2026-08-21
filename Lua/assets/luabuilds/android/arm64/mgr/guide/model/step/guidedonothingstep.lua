local var_0_0 = class("GuideDoNothingStep", import(".GuideStep"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.eventFlag = arg_1_1.doNothing

	return
end

function var_0_0.GetType(arg_2_0)
	return GuideStep.TYPE_DONOTHING
end

function var_0_0.ExistTrigger(arg_3_0)
	return arg_3_0.eventFlag
end

return var_0_0
