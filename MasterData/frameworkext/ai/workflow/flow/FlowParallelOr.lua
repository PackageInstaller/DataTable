module("frameworkext.ai.workflow.flow.FlowParallelOr", package.seeall)

local var_0_0 = class("FlowParallelOr", FlowBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._children = {}
	arg_1_0._doneCount = 0
end

function var_0_0.addChild(arg_2_0, arg_2_1)
	table.insert(arg_2_0._children, arg_2_1)

	arg_2_1.parent = arg_2_0
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	var_0_0.super.onStart(arg_3_0, arg_3_1)

	arg_3_0._doneCount = 0

	local var_3_0 = #arg_3_0._children

	for iter_3_0 = 1, var_3_0 do
		arg_3_0._children[iter_3_0]:onStart(arg_3_1)
	end
end

function var_0_0.onChildDone(arg_4_0, arg_4_1)
	arg_4_0._doneCount = arg_4_0._doneCount + 1

	if arg_4_1.result == WorkResult.Succeed then
		local var_4_0 = #arg_4_0._children

		for iter_4_0 = 1, var_4_0 do
			if arg_4_0._children[iter_4_0].status == WorkStatus.Running then
				arg_4_0._children[iter_4_0]:onInterrupt()
			end
		end

		arg_4_0:onDone(WorkResult.Succeed)
	elseif arg_4_0._doneCount == #arg_4_0._children then
		var_0_0.super.onDone(WorkResult.Fail)
	end
end

function var_0_0.onInterrupt(arg_5_0)
	var_0_0.super.onInterrupt(arg_5_0)

	local var_5_0 = #arg_5_0._children

	for iter_5_0 = 1, var_5_0 do
		if arg_5_0._children[iter_5_0].status == WorkStatus.Running then
			arg_5_0._children[iter_5_0]:onInterrupt()
		end
	end
end

function var_0_0.getChildren(arg_6_0)
	return arg_6_0._children
end

function var_0_0.onDestroy(arg_7_0)
	var_0_0.super.onDestroy(arg_7_0)

	local var_7_0 = #arg_7_0._children

	for iter_7_0 = 1, var_7_0 do
		arg_7_0._children[iter_7_0]:onDestroy()
	end

	arg_7_0._children = nil
end

return var_0_0
