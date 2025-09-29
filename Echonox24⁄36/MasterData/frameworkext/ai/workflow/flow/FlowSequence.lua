module("frameworkext.ai.workflow.flow.FlowSequence", package.seeall)

local var_0_0 = class("FlowSequence", FlowBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._children = {}
	arg_1_0._curIndex = 0
end

function var_0_0.addChild(arg_2_0, arg_2_1)
	if arg_2_1 then
		table.insert(arg_2_0._children, arg_2_1)

		arg_2_1.parent = arg_2_0
	end
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	var_0_0.super.onStart(arg_3_0, arg_3_1)

	arg_3_0._curIndex = 0

	arg_3_0:next()
end

function var_0_0.next(arg_4_0)
	arg_4_0._curIndex = arg_4_0._curIndex + 1

	if #arg_4_0._children >= arg_4_0._curIndex then
		arg_4_0._children[arg_4_0._curIndex]:onStart(arg_4_0.context)
	end
end

function var_0_0.onChildDone(arg_5_0, arg_5_1)
	if arg_5_1.result == WorkResult.Succeed then
		if arg_5_0._curIndex == #arg_5_0._children then
			arg_5_0:onDone(WorkResult.Succeed)
		else
			arg_5_0:next()
		end
	else
		arg_5_0:onDone(WorkResult.Fail)
	end
end

function var_0_0.onInterrupt(arg_6_0)
	var_0_0.super.onInterrupt(arg_6_0)

	if arg_6_0._children[arg_6_0._curIndex].status == WorkStatus.Running then
		arg_6_0._children[arg_6_0._curIndex]:onInterrupt()
	end
end

function var_0_0.getChildren(arg_7_0)
	return arg_7_0._children
end

function var_0_0.onDestroy(arg_8_0)
	var_0_0.super.onDestroy(arg_8_0)

	local var_8_0 = #arg_8_0._children

	for iter_8_0 = 1, var_8_0 do
		arg_8_0._children[iter_8_0]:onDestroy()
	end

	arg_8_0._children = nil
end

return var_0_0
