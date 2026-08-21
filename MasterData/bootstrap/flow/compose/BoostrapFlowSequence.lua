module("bootstrap.flow.compose.BoostrapFlowSequence", package.seeall)

local var_0_0 = class("BoostrapFlowSequence", BoostrapFlowParentNode)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._currentChildIndex = 0
end

function var_0_0.onStart(arg_2_0)
	var_0_0.super.onStart(arg_2_0)

	arg_2_0._currentChildIndex = 1

	return arg_2_0:getChildAt(arg_2_0._currentChildIndex):onStart()
end

function var_0_0.onChildEnd(arg_3_0, arg_3_1)
	if arg_3_1:getStatus() == BootstrapFlowConst.BTStatus.SUCCESS then
		arg_3_0._currentChildIndex = arg_3_0._currentChildIndex + 1

		local var_3_0 = arg_3_0:getChildAt(arg_3_0._currentChildIndex)

		if var_3_0 then
			return var_3_0:onStart()
		else
			return arg_3_0:onEnd(BootstrapFlowConst.BTStatus.SUCCESS)
		end
	else
		return arg_3_0:onEnd(BootstrapFlowConst.BTStatus.FAIL)
	end
end

function var_0_0.onReset(arg_4_0)
	var_0_0.super.onReset(arg_4_0)

	arg_4_0._currentChildIndex = 0
end

function var_0_0.onReuse(arg_5_0, arg_5_1)
	var_0_0.super.onReuse(arg_5_0, arg_5_1)
end

function var_0_0.onRecycle(arg_6_0)
	var_0_0.super.onRecycle(arg_6_0)

	arg_6_0._currentChildIndex = 0
end

function var_0_0.onDestroy(arg_7_0)
	var_0_0.super.onDestroy(arg_7_0)

	arg_7_0._currentChildIndex = nil
end

return var_0_0
