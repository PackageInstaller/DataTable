module("bootstrap.flow.base.BoostrapFlowParentNode", package.seeall)

local var_0_0 = class("BoostrapFlowParentNode", BoostrapFlowNode)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._children = false
end

function var_0_0.onStart(arg_2_0)
	return (var_0_0.super.onStart(arg_2_0))
end

function var_0_0.addChild(arg_3_0, arg_3_1)
	if not arg_3_0._children then
		arg_3_0._children = {}
	end

	table.insert(arg_3_0._children, arg_3_1)
	arg_3_1:setParent(arg_3_0)

	arg_3_1._childrenIndex = #arg_3_0._children
end

function var_0_0.removeChild(arg_4_0, arg_4_1)
	if not arg_4_0._children then
		return
	end

	arg_4_1:setParent(nil)
	table.removebyvalue(arg_4_0._children, arg_4_1)
end

function var_0_0.removeChildAt(arg_5_0, arg_5_1)
	if not arg_5_0._children then
		return
	end

	local var_5_0 = arg_5_0:getChildAt(arg_5_1)

	if var_5_0 then
		var_5_0:setParent(nil)
		table.remove(arg_5_0._children, arg_5_1)
	end
end

function var_0_0.removeAllChild(arg_6_0)
	if not arg_6_0._children then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._children) do
		iter_6_1:setParent(nil)
	end

	table.clear(arg_6_0._children)
end

function var_0_0.getChildren(arg_7_0)
	return arg_7_0._children
end

function var_0_0.getChildrenCount(arg_8_0)
	if arg_8_0._children then
		return #arg_8_0._children
	end

	return 0
end

function var_0_0.getFirstChild(arg_9_0)
	return arg_9_0:getChildAt(1)
end

function var_0_0.getChildAt(arg_10_0, arg_10_1)
	return arg_10_0._children[arg_10_1]
end

function var_0_0.onChildEnd(arg_11_0, arg_11_1)
	printError(string.format("no implement exception in class [%s]", tostring(arg_11_0.class)))
end

function var_0_0.canInterrupt(arg_12_0)
	local var_12_0 = true

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._children) do
		if iter_12_1:getStatus() == BootstrapFlowConst.BTStatus.RUNNING and not iter_12_1:canInterrupt() then
			var_12_0 = false

			break
		end
	end

	return var_12_0
end

function var_0_0.onInterrupt(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._children) do
		if iter_13_1:getStatus() == BootstrapFlowConst.BTStatus.RUNNING then
			iter_13_1:onInterruptWithoutReport()
		end
	end

	return var_0_0.super.onInterrupt(arg_13_0, arg_13_1)
end

function var_0_0.onInterruptWithoutReport(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._children) do
		if iter_14_1:getStatus() == BootstrapFlowConst.BTStatus.RUNNING then
			iter_14_1:onInterruptWithoutReport()
		end
	end

	var_0_0.super.onInterruptWithoutReport(arg_14_0)
end

function var_0_0.onEnd(arg_15_0, arg_15_1)
	return var_0_0.super.onEnd(arg_15_0, arg_15_1)
end

function var_0_0.onReset(arg_16_0)
	if arg_16_0._children then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._children) do
			iter_16_1:onReset()
		end
	end

	var_0_0.super.onReset(arg_16_0)
end

function var_0_0.onReuse(arg_17_0, arg_17_1)
	var_0_0.super.onReuse(arg_17_0, arg_17_1)
end

function var_0_0.onRecycle(arg_18_0)
	if arg_18_0._children then
		table.clear(arg_18_0._children)
	end

	var_0_0.super.onRecycle(arg_18_0)
end

function var_0_0.onDestroy(arg_19_0)
	if arg_19_0._children then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0._children) do
			iter_19_1:destroy()
		end
	end

	var_0_0.super.onDestroy(arg_19_0)

	arg_19_0._children = false
end

return var_0_0
