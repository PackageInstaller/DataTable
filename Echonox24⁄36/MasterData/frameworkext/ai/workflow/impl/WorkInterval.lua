module("frameworkext.ai.workflow.impl.WorkInterval", package.seeall)

local var_0_0 = class("WorkInterval", WorkBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._interval = arg_1_1
end

function var_0_0.onEnter(arg_2_0, arg_2_1)
	settimer(arg_2_0._interval, arg_2_0._onTimer, arg_2_0, false)
end

function var_0_0.onExit(arg_3_0, arg_3_1)
	removetimer(arg_3_0._onTimer, arg_3_0)
end

function var_0_0._onTimer(arg_4_0)
	arg_4_0:onDone(WorkResult.Succeed)
end

return var_0_0
