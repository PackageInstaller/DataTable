local FiniteStateMechineState = class("FiniteStateMechineState")

function FiniteStateMechineState:Ctor(arg_1_1)
	self.state_ = arg_1_1
end

function FiniteStateMechineState:OnEnter()
	return
end

function FiniteStateMechineState:OnLeave()
	return
end

function FiniteStateMechineState:GetStateName()
	return self.state_.name
end

function FiniteStateMechineState:GetFromName()
	return self.state_.from
end

function FiniteStateMechineState:GetToName()
	return self.state_.to
end

return FiniteStateMechineState
