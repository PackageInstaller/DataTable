module("frameworkext.ai.fsm.FiniteStateMachine", package.seeall)

local var_0_0 = class("FiniteStateMachine")

function var_0_0.ctor(arg_1_0)
	arg_1_0._groups = {}
	arg_1_0._states = {}
end

function var_0_0.registerState(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getGroup()
	local var_2_1 = arg_2_0._groups[var_2_0]

	if not var_2_1 then
		var_2_1 = FiniteStateGroup.New(arg_2_0)
		arg_2_0._groups[var_2_0] = var_2_1
	end

	arg_2_0._states[arg_2_1.stateId] = arg_2_1

	var_2_1:addState(arg_2_1)
end

function var_0_0.getState(arg_3_0, arg_3_1)
	return arg_3_0._states[arg_3_1]
end

function var_0_0.isActive(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._states[arg_4_1]

	if not var_4_0 then
		printWarn("Unkown FiniteStateMachine stateId:", arg_4_1)

		return false
	end

	local var_4_1 = var_4_0:getGroup()
	local var_4_2 = arg_4_0._groups[var_4_1]

	if not var_4_2 then
		return false
	end

	return var_4_2:getCurStateId() == arg_4_1
end

function var_0_0.isExiting(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._states[arg_5_1]

	if not var_5_0 then
		printWarn("Unkown FiniteStateMachine stateId:", arg_5_1)

		return false
	end

	local var_5_1 = var_5_0:getGroup()
	local var_5_2 = arg_5_0._groups[var_5_1]

	if not var_5_2 then
		return false
	end

	return var_5_2:getCurStateId() == arg_5_1 and var_5_2:getTargetStateId() > -1
end

function var_0_0.isTargetState(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._states[arg_6_1]

	if not var_6_0 then
		printWarn("Unkown FiniteStateMachine stateId:", arg_6_1)

		return false
	end

	local var_6_1 = var_6_0:getGroup()
	local var_6_2 = arg_6_0._groups[var_6_1]

	if not var_6_2 then
		return false
	end

	return var_6_2:getTargetStateId() == arg_6_1
end

function var_0_0.destroy(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._groups) do
		iter_7_1:destroy()
	end

	arg_7_0._groups = nil
	arg_7_0._states = nil
end

function var_0_0.enterState(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._states[arg_8_1]

	if not var_8_0 then
		printWarn("Unkown FiniteStateMachine stateId:", arg_8_1)

		return
	end

	local var_8_1 = var_8_0:getGroup()
	local var_8_2 = arg_8_0._groups[var_8_1]

	if var_8_2 then
		var_8_2:enterState(arg_8_1)
	end
end

return var_0_0
