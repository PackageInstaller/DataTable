local var_0_0 = 0
local FsmState = class("FsmState")

function FsmState:ctor()
	self._stateId = nil
	self._stateDict = {}
	self.fsm = nil
	self.owner = nil
end

function FsmState:setFsm(arg_2_1)
	self.fsm = arg_2_1
end

function FsmState:setOwner(arg_3_1)
	self.owner = arg_3_1
end

function FsmState:getStateId()
	return self._stateId
end

function FsmState:getFsm()
	return self.fsm
end

function FsmState:addTran(arg_6_1, arg_6_2)
	if arg_6_1 == var_0_0 or arg_6_2 == var_0_0 then
		return false
	end

	if self._stateDict[arg_6_2] then
		return false
	end

	self._stateDict[arg_6_1] = arg_6_2

	return true
end

function FsmState:getStateByTran(arg_7_1)
	return self._stateDict[arg_7_1] or var_0_0
end

function FsmState:doBeforeEnter()
	return
end

function FsmState:doAfterExit()
	return
end

function FsmState:doReason(arg_10_1, arg_10_2)
	return
end

function FsmState:doAct(arg_11_1, arg_11_2)
	return
end

return FsmState
