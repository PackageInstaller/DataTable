module("frameworkext.ai.workflow.flow.FlowRepeatUntilSucceed", package.seeall)

local var_0_0 = class("FlowRepeatUntilSucceed", FlowRepeatForever)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.onChildDone(arg_2_0, arg_2_1)
	if arg_2_1.result == WorkResult.Succeed then
		arg_2_0:onDone(WorkResult.Succeed)
	else
		arg_2_1:onStart(arg_2_0.context)
	end
end

return var_0_0
