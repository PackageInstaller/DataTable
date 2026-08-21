module("bootstrap.flow.compose.BoostrapFlowSubTree", package.seeall)

local var_0_0 = class("BoostrapFlowSubTree", BoostrapFlowParentNode)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._subTreeName = false
	arg_1_0._treeInstance = false
end

function var_0_0.onStart(arg_2_0)
	var_0_0.super.onStart(arg_2_0)

	return arg_2_0:getChildAt(1):onStart()
end

function var_0_0.onChildEnd(arg_3_0, arg_3_1)
	return arg_3_0:onEnd(arg_3_1:getStatus())
end

function var_0_0.onReset(arg_4_0)
	var_0_0.super.onReset(arg_4_0)
end

function var_0_0.onReuse(arg_5_0, arg_5_1)
	var_0_0.super.onReuse(arg_5_0, arg_5_1)
end

function var_0_0.onRecycle(arg_6_0)
	var_0_0.super.onRecycle(arg_6_0)

	arg_6_0._treeInstance = false
	arg_6_0._subTreeName = false
end

function var_0_0.onDestroy(arg_7_0)
	var_0_0.super.onDestroy(arg_7_0)

	arg_7_0._treeInstance = false
	arg_7_0._subTreeName = false
end

return var_0_0
