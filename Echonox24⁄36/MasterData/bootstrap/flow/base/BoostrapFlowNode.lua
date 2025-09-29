module("bootstrap.flow.base.BoostrapFlowNode", package.seeall)

local var_0_0 = class("BoostrapFlowNode")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._context = arg_1_1
	arg_1_0._status = BootstrapFlowConst.BTStatus.INACTIVE
	arg_1_0._parent = nil
	arg_1_0._childrenIndex = -1
	arg_1_0._aiTag = ""
	arg_1_0._errorStrName = ""
end

function var_0_0.getCapacity(arg_2_0)
	return 9999
end

function var_0_0.getContext(arg_3_0)
	return arg_3_0._context
end

function var_0_0.getStatus(arg_4_0)
	return arg_4_0._status
end

function var_0_0.setParent(arg_5_0, arg_5_1)
	arg_5_0._parent = arg_5_1
end

function var_0_0.getParent(arg_6_0)
	return arg_6_0._parent
end

function var_0_0.onStart(arg_7_0)
	arg_7_0._status = BootstrapFlowConst.BTStatus.RUNNING

	return arg_7_0
end

function var_0_0.onEnd(arg_8_0, arg_8_1)
	if arg_8_1 == nil then
		printError(string.format("the param['status'] of method['onEnd'] is nil in class[%s]", tostring(arg_8_0)))
	end

	arg_8_0._status = arg_8_1

	arg_8_0:handleEndBefore()

	local var_8_0 = arg_8_0

	if arg_8_0:getParent() then
		var_8_0 = arg_8_0:getParent():onChildEnd(arg_8_0)
	end

	arg_8_0:handleEnd()

	return var_8_0
end

function var_0_0.setEndBeforeCallback(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._endBeforeCallback = arg_9_1
	arg_9_0._endBeforeCallbackHandler = arg_9_2
end

function var_0_0.setEndCallback(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._endCallback = arg_10_1
	arg_10_0._endCallbackHandler = arg_10_2
end

function var_0_0.handleEndBefore(arg_11_0)
	if arg_11_0._endBeforeCallback then
		arg_11_0._endBeforeCallback(arg_11_0._endBeforeCallbackHandler)
	end
end

function var_0_0.handleEnd(arg_12_0)
	if arg_12_0._endCallback then
		arg_12_0._endCallback(arg_12_0._endCallbackHandler)
	end
end

function var_0_0.handleInterrupt(arg_13_0)
	return
end

function var_0_0.canInterrupt(arg_14_0)
	return true
end

function var_0_0.interruptWithoutReport(arg_15_0)
	if arg_15_0._status == BootstrapFlowConst.BTStatus.RUNNING and arg_15_0:canInterrupt() then
		arg_15_0:onInterruptWithoutReport()

		return true
	end

	return false
end

function var_0_0.onInterruptWithoutReport(arg_16_0)
	arg_16_0._status = BootstrapFlowConst.BTStatus.INACTIVE

	arg_16_0:handleInterrupt()
	arg_16_0:handleEnd()
end

function var_0_0.interrupt(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 or BootstrapFlowConst.BTStatus.FAIL

	if not arg_17_1 or arg_17_1 ~= BootstrapFlowConst.BTStatus.FAIL and arg_17_1 ~= BootstrapFlowConst.BTStatus.SUCCESS then
		printError(string.format("interrupt status error [%s]", tostring(arg_17_1)))

		return false, nil
	end

	if arg_17_0._status == BootstrapFlowConst.BTStatus.RUNNING and arg_17_0:canInterrupt() then
		return true, arg_17_0:onInterrupt(arg_17_1)
	end

	return false, nil
end

function var_0_0.onInterrupt(arg_18_0, arg_18_1)
	arg_18_0._status = arg_18_1

	arg_18_0:handleInterrupt()

	return arg_18_0:onEnd(arg_18_1)
end

function var_0_0.onUpdate(arg_19_0)
	local var_19_0 = tostring(arg_19_0.class)

	if arg_19_0._errorStrName ~= var_19_0 then
		printError(string.format("no implement exception or logic error in class [%s]", var_19_0))
	end

	arg_19_0._errorStrName = var_19_0
end

function var_0_0.getChildrenIndex(arg_20_0)
	return arg_20_0._childrenIndex
end

function var_0_0.onReset(arg_21_0)
	arg_21_0._status = BootstrapFlowConst.BTStatus.INACTIVE
	arg_21_0._errorStrName = ""
end

function var_0_0.reuse(arg_22_0, arg_22_1)
	arg_22_0:onReuse(arg_22_1)
end

function var_0_0.onReuse(arg_23_0, arg_23_1)
	arg_23_0._context = arg_23_1
end

function var_0_0.reset(arg_24_0)
	arg_24_0:onReset()
end

function var_0_0.onRecycle(arg_25_0)
	arg_25_0._status = BootstrapFlowConst.BTStatus.INACTIVE
	arg_25_0._context = nil
	arg_25_0._errorStrName = ""
	arg_25_0._childrenIndex = nil
	arg_25_0._parent = nil
end

function var_0_0.destroy(arg_26_0)
	arg_26_0:onDestroy()
end

function var_0_0.onDestroy(arg_27_0)
	arg_27_0._status = nil
	arg_27_0._context = nil
	arg_27_0._childrenIndex = nil
	arg_27_0._parent = nil
	arg_27_0._errorStrName = nil
end

return var_0_0
