class = var_0_10000

local var_0_0 = "GuideDoNothingStep"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuideStep"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.eventFlag = arg_1_1.doNothing

	return
end

function var_0_1.GetType(arg_2_0)
	GuideStep = var_1_10001

	return var_1_10001.TYPE_DONOTHING
end

function var_0_1.ExistTrigger(arg_3_0)
	return arg_3_0.eventFlag
end

return var_0_1
