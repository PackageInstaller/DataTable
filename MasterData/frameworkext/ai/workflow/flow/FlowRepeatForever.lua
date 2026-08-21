module("frameworkext.ai.workflow.flow.FlowRepeatForever", package.seeall)

local var_0_0 = class("FlowRepeatForever", FlowBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._child = nil
	arg_1_0._children = nil
end

function var_0_0.addChild(arg_2_0, arg_2_1)
	arg_2_0._child = arg_2_1
	arg_2_0._child.parent = arg_2_0
	arg_2_0._children = {
		arg_2_0._children
	}
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	var_0_0.super.onStart(arg_3_0, arg_3_1)
	arg_3_0._child:onStart(arg_3_1)
end

function var_0_0.onChildDone(arg_4_0, arg_4_1)
	arg_4_0:onDone(arg_4_1.result)
end

function var_0_0.onInterrupt(arg_5_0)
	var_0_0.super.onInterrupt(arg_5_0)

	if arg_5_0._child.status == WorkStatus.Running then
		arg_5_0._child:onInterrupt()
	end
end

function var_0_0.getChildren(arg_6_0)
	return arg_6_0._children
end

function var_0_0.onDestroy(arg_7_0)
	var_0_0.super.onDestroy(arg_7_0)
	arg_7_0._child:onDestroy()

	arg_7_0._child = nil
	arg_7_0._children = nil
end

return var_0_0
