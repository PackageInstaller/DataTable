local var_0_0 = class("FiniteStateMechine")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.states_ = {}
	arg_1_0.curState_ = nil
end

function var_0_0.AddState(arg_2_0, arg_2_1)
	if arg_2_0.states_[arg_2_1:GetStateName()] then
		return
	end

	arg_2_0.states_[arg_2_1:GetStateName()] = arg_2_1
end

function var_0_0.SetInitState(arg_3_0, arg_3_1)
	arg_3_0.curState_ = arg_3_0.states_[arg_3_1]
end

function var_0_0.GetCurState(arg_4_0)
	return arg_4_0.curState_
end

function var_0_0.CanTransition(arg_5_0, arg_5_1)
	if arg_5_0.curState_:GetStateName() == arg_5_1 then
		return false
	end

	local var_5_0 = arg_5_0.states_[arg_5_1]

	if arg_5_0.curState_:GetToName() == var_5_0:GetFromName() then
		return true
	end

	return false
end

function var_0_0.Trigger(arg_6_0, arg_6_1)
	if arg_6_0:CanTransition(arg_6_1) then
		arg_6_0.curState_:OnLeave()

		arg_6_0.curState_ = arg_6_0.states_[arg_6_1]

		arg_6_0.curState_:OnEnter()
	else
		print("can not transition " .. arg_6_1)
	end
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.states_) do
		iter_7_1:Dispose()
	end

	arg_7_0.states_ = nil
end

return var_0_0
