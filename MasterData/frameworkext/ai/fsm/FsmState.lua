module("frameworkext.ai.fsm.FsmState", package.seeall)

local var_0_0 = class("FsmState")

var_0_0.Entered = 1
var_0_0.Exited = 2

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.stateId = arg_1_1
	arg_1_0._stateMachine = nil
	arg_1_0._stateGroup = nil
end

function var_0_0.setFsm(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._stateMachine = arg_2_1
	arg_2_0._stateGroup = arg_2_2
end

function var_0_0.getGroup(arg_3_0)
	return 0
end

function var_0_0.onEnter(arg_4_0)
	if arg_4_0._dispatcher then
		arg_4_0._dispatcher:dispatch(var_0_0.Entered)
	end
end

function var_0_0.onExit(arg_5_0)
	return
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0._stateMachine = nil
	arg_6_0._dispatcher = nil
end

function var_0_0.doExitDone(arg_7_0)
	if arg_7_0._dispatcher then
		arg_7_0._dispatcher:dispatch(var_0_0.Exited)
	end

	arg_7_0._stateGroup:onExitDone(arg_7_0)
end

function var_0_0.addEnteredListener(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._dispatcher then
		arg_8_0._dispatcher = {}

		NotifyDispatcher.extend(arg_8_0._dispatcher)
	end

	arg_8_0._dispatcher:addListener(var_0_0.Entered, arg_8_1, arg_8_2)
end

function var_0_0.removeEnteredListener(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._dispatcher then
		return
	end

	arg_9_0._dispatcher:removeListener(var_0_0.Entered, arg_9_1, arg_9_2)
end

function var_0_0.addExitedListener(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._dispatcher then
		arg_10_0._dispatcher = {}

		NotifyDispatcher.extend(arg_10_0._dispatcher)
	end

	arg_10_0._dispatcher:addListener(var_0_0.Exited, arg_10_1, arg_10_2)
end

function var_0_0.removeExitedListener(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._dispatcher then
		return
	end

	arg_11_0._dispatcher:removeListener(var_0_0.Exited, arg_11_1, arg_11_2)
end

return var_0_0
