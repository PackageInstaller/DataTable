local var_0_0 = 0
local FsmSystem = class("FsmSystem")

function FsmSystem:ctor(arg_1_1)
	self._fsmStateDict = {}
	self._curStateId = nil
	self.owner = arg_1_1
	self._curFsmState = nil
end

function FsmSystem:doUpdate(arg_2_1, arg_2_2)
	if not self.owner then
		return
	end

	self._curFsmState:doAct(arg_2_1, arg_2_2)
	self._curFsmState:doReason(arg_2_1, arg_2_2)
end

function FsmSystem:addState(arg_3_1)
	if not arg_3_1 then
		return false
	end

	local var_3_0 = arg_3_1:getStateId()

	if self._fsmStateDict[var_3_0] then
		return false
	end

	self._fsmStateDict[var_3_0] = arg_3_1

	arg_3_1:setFsm(self)
	arg_3_1:setOwner(self.owner)

	if not self._curFsmState then
		self._curFsmState = arg_3_1
		self._curStateId = var_3_0
	end

	return true
end

function FsmSystem:performTran(arg_4_1)
	if arg_4_1 == var_0_0 then
		return false
	end

	local var_4_0 = self._curFsmState:getStateByTran(arg_4_1)

	if var_4_0 == var_0_0 then
		return false
	end

	if self._curStateId == var_4_0 then
		return true
	end

	local var_4_1 = self._fsmStateDict[var_4_0]

	if not self._fsmStateDict[var_4_0] then
		return false
	end

	self._curFsmState:doAfterExit()

	self._curFsmState = var_4_1
	self._curStateId = var_4_0

	self._curFsmState:doBeforeEnter()
end

return FsmSystem
