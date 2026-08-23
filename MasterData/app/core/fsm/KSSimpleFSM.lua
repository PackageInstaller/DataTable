local KSSimpleFSM = class("KSSimpleFSM")

function KSSimpleFSM:ctor()
	self._ownerObj = nil
	self._curState = nil
	self._allState = {}
end

function KSSimpleFSM:initPrepareFSM(arg_2_1)
	self._ownerObj = arg_2_1

	self:_doInitAllStates()
end

function KSSimpleFSM:cleanupFSM()
	self:_performTransition(nil)

	for iter_3_0, iter_3_1 in pairs(self._allState) do
		iter_3_1:cleanupState()
	end

	self._allState = nil
	self._ownerObj = nil
end

function KSSimpleFSM:startupFSM()
	self:_doStartupEntrance()
end

function KSSimpleFSM:updateTickFSM(arg_5_1)
	if self._curState == nil then
		return
	end

	local var_5_0 = self._curState:doReasonState(arg_5_1)

	if var_5_0 ~= nil then
		self._curState:actState(var_5_0)
	end
end

function KSSimpleFSM:transitionTo(arg_6_1)
	local var_6_0 = self._curState == nil and self:getStateByTransition(arg_6_1) or self._curState:getNextState(arg_6_1)

	if var_6_0 == nil then
		return false
	end

	self:_performTransition(var_6_0)

	return true
end

function KSSimpleFSM:getStateByTransition(arg_7_1)
	return self._allState[arg_7_1]
end

function KSSimpleFSM:getCurStateID()
	if self._curState == nil then
		return nil
	else
		return self._curState:getUniqueID()
	end
end

function KSSimpleFSM:_performTransition(arg_9_1)
	if self._curState ~= nil then
		self._curState:doBeforeLeaving()
	end

	self._curState = arg_9_1

	if self._curState ~= nil then
		self._curState:doBeforeEntering()
	end
end

function KSSimpleFSM:_addState(arg_10_1)
	arg_10_1:initPrepareState(self)

	local var_10_0 = arg_10_1:getUniqueID()

	if self._allState[var_10_0] ~= nil then
		self._allState[var_10_0]:cleanupState()
	end

	self._allState[var_10_0] = arg_10_1
end

function KSSimpleFSM:_doInitAllStates()
	return
end

function KSSimpleFSM:_doStartupEntrance()
	return
end

return KSSimpleFSM
