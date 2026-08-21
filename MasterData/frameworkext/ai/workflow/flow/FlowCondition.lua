module("frameworkext.ai.workflow.flow.FlowCondition", package.seeall)

local var_0_0 = class("FlowCondition", FlowBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._condition = nil
	arg_1_0._conditionResult = false
	arg_1_0._trueWork = nil
	arg_1_0._falseWork = nil
	arg_1_0._children = nil
end

function var_0_0.addCondition(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._condition = arg_2_1
	arg_2_0._trueWork = arg_2_2
	arg_2_0._falseWork = arg_2_3
	arg_2_0._trueWork.parent = arg_2_0
	arg_2_0._falseWork.parent = arg_2_0
	arg_2_0._children = {
		arg_2_0._trueWork,
		arg_2_0._falseWork
	}
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	var_0_0.super.onStart(arg_3_0, arg_3_1)

	arg_3_0._conditionResult = arg_3_0._condition:isMeetCondition()

	if arg_3_0._conditionResult then
		if arg_3_0._trueWork then
			arg_3_0._trueWork:onStart(arg_3_1)
		else
			arg_3_0:onChildDone(nil)
		end
	elseif arg_3_0._falseWork then
		arg_3_0._falseWork:onStart(arg_3_1)
	else
		arg_3_0:onChildDone(nil)
	end
end

function var_0_0.onChildDone(arg_4_0, arg_4_1)
	if arg_4_1 then
		var_0_0.super.onDone(arg_4_0, arg_4_1.result)
	else
		var_0_0.super.onDone(arg_4_0, WorkResult.Succeed)
	end
end

function var_0_0.onInterrupt(arg_5_0)
	var_0_0.super.onInterrupt(arg_5_0)

	if arg_5_0._conditionResult then
		if arg_5_0._trueWork and arg_5_0._trueWork.status == WorkStatus.Running then
			arg_5_0._trueWork:onInterrupt()
		end
	elseif arg_5_0._falseWork and arg_5_0._falseWork.status == WorkStatus.Running then
		arg_5_0._falseWork:onInterrupt()
	end
end

function var_0_0.getChildren(arg_6_0)
	return arg_6_0._children
end

function var_0_0.onDestroy(arg_7_0)
	var_0_0.super.onDestroy(arg_7_0)

	if arg_7_0._trueWork then
		arg_7_0._trueWork:onDestroy()
	end

	if arg_7_0._falseWork then
		arg_7_0._falseWork:onDestroy()
	end

	arg_7_0._condition = nil
	arg_7_0._trueWork = nil
	arg_7_0._falseWork = nil
	arg_7_0._children = nil
end

return var_0_0
