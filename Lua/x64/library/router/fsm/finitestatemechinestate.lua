local var_0_0 = class("FiniteStateMechineState")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.state_ = arg_1_1
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnLeave(arg_3_0)
	return
end

function var_0_0.GetStateName(arg_4_0)
	return arg_4_0.state_.name
end

function var_0_0.GetFromName(arg_5_0)
	return arg_5_0.state_.from
end

function var_0_0.GetToName(arg_6_0)
	return arg_6_0.state_.to
end

return var_0_0
