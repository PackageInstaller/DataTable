module("frameworkext.ai.fsm.FiniteStateGroup", package.seeall)

local var_0_0 = class("FiniteStateGroup")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._states = {}
	arg_1_0._curStateId = -1
	arg_1_0._targetStateId = -1
	arg_1_0._stateMachine = arg_1_1
end

function var_0_0.getCurStateId(arg_2_0)
	return arg_2_0._curStateId
end

function var_0_0.getTargetStateId(arg_3_0)
	return arg_3_0._targetStateId
end

function var_0_0.addState(arg_4_0, arg_4_1)
	arg_4_0._states[arg_4_1.stateId] = arg_4_1

	arg_4_1:setFsm(arg_4_0._stateMachine, arg_4_0)
end

function var_0_0.destroy(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._states) do
		iter_5_1:onDestroy()
	end

	arg_5_0._states = nil
	arg_5_0._stateMachine = nil
end

function var_0_0.enterState(arg_6_0, arg_6_1)
	if arg_6_0._curStateId == arg_6_1 then
		return
	end

	if not arg_6_0._states[arg_6_1] then
		printWarn("Unkown stateId:", arg_6_1)

		return
	end

	if arg_6_0._targetStateId > -1 then
		arg_6_0._targetStateId = arg_6_1
	else
		arg_6_0._targetStateId = arg_6_1

		local var_6_0 = arg_6_0._states[arg_6_0._curStateId]

		if var_6_0 then
			var_6_0:onExit()
		else
			arg_6_0:onExitDone(nil, arg_6_0._curStateId)
		end
	end
end

function var_0_0.onExitDone(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = arg_7_2 or arg_7_1 and arg_7_1.stateId

	if arg_7_2 ~= arg_7_0._curStateId then
		return
	end

	arg_7_0._curStateId = arg_7_0._targetStateId
	arg_7_0._targetStateId = -1

	arg_7_0._states[arg_7_0._curStateId]:onEnter()
end

return var_0_0
