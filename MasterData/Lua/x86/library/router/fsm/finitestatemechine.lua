local FiniteStateMechine = class("FiniteStateMechine")

function FiniteStateMechine:Ctor()
	self.states_ = {}
	self.curState_ = nil
end

function FiniteStateMechine:AddState(arg_2_1)
	if self.states_[arg_2_1:GetStateName()] then
		return
	end

	self.states_[arg_2_1:GetStateName()] = arg_2_1
end

function FiniteStateMechine:SetInitState(arg_3_1)
	self.curState_ = self.states_[arg_3_1]
end

function FiniteStateMechine:GetCurState()
	return self.curState_
end

function FiniteStateMechine:CanTransition(arg_5_1)
	if self.curState_:GetStateName() == arg_5_1 then
		return false
	end

	if self.curState_:GetToName() == self.states_[arg_5_1]:GetFromName() then
		return true
	end

	return false
end

function FiniteStateMechine:Trigger(arg_6_1)
	if self:CanTransition(arg_6_1) then
		self.curState_:OnLeave()

		self.curState_ = self.states_[arg_6_1]

		self.curState_:OnEnter()
	else
		print("can not transition " .. arg_6_1)
	end
end

function FiniteStateMechine:Dispose()
	for iter_7_0, iter_7_1 in pairs(self.states_) do
		iter_7_1:Dispose()
	end

	self.states_ = nil
end

return FiniteStateMechine
