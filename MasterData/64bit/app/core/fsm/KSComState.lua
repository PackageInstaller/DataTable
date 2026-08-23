local var_0_0 = table.insert
local KSComState = class("KSComState", import(".KSSimpleState"))

function KSComState:ctor()
	KSComState.super.ctor(self)

	self._allGraph = {}
	self._transitionTidList = {}
	self._isFinish = false

	self:onCreate()
end

function KSComState:setFinish(arg_2_1)
	self._isFinish = arg_2_1
end

function KSComState:cleanupState()
	KSComState.super.cleanupState(self)

	self._allGraph = nil

	self:onCleanupState()
end

function KSComState:initPrepareState(arg_4_1)
	self._ownerFSM = arg_4_1

	self:onInitState()
end

function KSComState:onCleanupState()
	return
end

function KSComState:onCreate()
	return
end

function KSComState:onInitState()
	return
end

function KSComState:doReasonState(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self._transitionTidList) do
		local var_8_0 = self._ownerFSM:getTransitionByUID(iter_8_1)

		if var_8_0 and var_8_0:checkTransitionOK(arg_8_1, self) then
			return var_8_0
		end
	end

	self:onTickUpdate(arg_8_1)
end

function KSComState:onTickUpdate(arg_9_1)
	return
end

function KSComState:addTransitionState(arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:getUniqueID()

	if self._allGraph[var_10_0] then
		assert(false, string.format("state %s transition is added:%s", self.__cname, arg_10_1.__cname))

		return
	end

	self._allGraph[var_10_0] = arg_10_2

	var_0_0(self._transitionTidList, var_10_0)
end

function KSComState:getNextState(arg_11_1)
	if arg_11_1 == nil then
		return nil
	end

	return self._allGraph[arg_11_1:getUniqueID()]
end

function KSComState:isFinish()
	return self._isFinish
end

return KSComState
