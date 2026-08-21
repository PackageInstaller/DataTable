local var_0_0 = class("State")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.name = arg_1_1

	if arg_1_2 ~= nil then
		arg_1_0.entering = arg_1_2
	end

	if arg_1_3 ~= nil then
		arg_1_0.exiting = arg_1_3
	end

	if arg_1_4 ~= nil then
		arg_1_0.changed = arg_1_4
	end

	arg_1_0.transitions = {}

	return
end

function var_0_0.defineTrans(arg_2_0, arg_2_1, arg_2_2)
	assert(arg_2_1, "action should not be nil at " .. arg_2_0.name)
	assert(arg_2_2, "target should not be nil at " .. arg_2_0.name)

	if arg_2_0:getTarget(arg_2_1) ~= nil then
		return
	end

	arg_2_0.transitions[arg_2_1] = arg_2_2

	return
end

function var_0_0.removeTrans(arg_3_0, arg_3_1)
	arg_3_0.transitions[arg_3_1] = nil

	return
end

function var_0_0.getTarget(arg_4_0, arg_4_1)
	return arg_4_0.transitions[arg_4_1]
end

return var_0_0
