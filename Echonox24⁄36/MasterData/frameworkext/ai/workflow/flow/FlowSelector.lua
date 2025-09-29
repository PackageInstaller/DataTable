module("frameworkext.ai.workflow.flow.FlowSelector", package.seeall)

local var_0_0 = class("FlowSelector", FlowBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._selectWork = nil
	arg_1_0._succeedWork = nil
	arg_1_0._failWork = nil
	arg_1_0._children = nil
end

function var_0_0.addConditionWork(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._selectWork = arg_2_1
	arg_2_0._succeedWork = arg_2_2
	arg_2_0._failWork = arg_2_3
	arg_2_0._selectWork.parent = arg_2_0
	arg_2_0._succeedWork.parent = arg_2_0
	arg_2_0._failWork.parent = arg_2_0
	arg_2_0._children = {
		arg_2_0._selectWork,
		arg_2_0._succeedWork,
		arg_2_0._failWork
	}
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	var_0_0.super.onStart(arg_3_0, arg_3_1)
	arg_3_0._selectWork:onStart(arg_3_1)
end

function var_0_0.onChildDone(arg_4_0, arg_4_1)
	if arg_4_1 == arg_4_0._selectWork then
		if arg_4_1.result == WorkResult.Succeed then
			arg_4_0._succeedWork:onStart(arg_4_0.context)
		else
			arg_4_0._failWork:onStart(arg_4_0.context)
		end
	else
		arg_4_0:onDone(arg_4_1.result)
	end
end

function var_0_0.onInterrupt(arg_5_0)
	var_0_0.super.onInterrupt(arg_5_0)

	if arg_5_0._selectWork.status == WorkStatus.Running then
		arg_5_0._selectWork:onInterrupt()
	elseif arg_5_0._selectWork.status == WorkStatus.Stopped then
		if arg_5_0._succeedWork.status == WorkStatus.Running then
			arg_5_0._succeedWork:onInterrupt()
		elseif arg_5_0._failWork.status == WorkStatus.Running then
			arg_5_0._failWork:onInterrupt()
		end
	end
end

function var_0_0.getChildren(arg_6_0)
	return arg_6_0._children
end

function var_0_0.onDestroy(arg_7_0)
	var_0_0.super.onDestroy(arg_7_0)
	arg_7_0._selectWork:onDestroy()
	arg_7_0._succeedWork:onDestroy()
	arg_7_0._failWork:onDestroy()

	arg_7_0._selectWork = nil
	arg_7_0._succeedWork = nil
	arg_7_0._failWork = nil
	arg_7_0._children = nil
end

return var_0_0
