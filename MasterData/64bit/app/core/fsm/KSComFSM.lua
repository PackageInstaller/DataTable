local KSComFSM = class("KSComFSM", import(".KSSimpleFSM"))

function KSComFSM:ctor()
	KSComFSM.super.ctor(self)

	self._allTransition = {}
end

function KSComFSM:cleanupFSM()
	KSComFSM.super.cleanupFSM(self)

	self._allTransition = {}
end

function KSComFSM:transitionToByUID(arg_3_1)
	return self:transitionTo(self:getTransitionByUID(arg_3_1))
end

function KSComFSM:setStateFinish()
	if self._curState then
		self._curState:setFinish(true)
	end
end

function KSComFSM:addTransition(arg_5_1)
	local var_5_0 = arg_5_1:getUniqueID()

	if self._allTransition[var_5_0] then
		assert(false, string.format("KSComFSM:addTransition() - transition uid repeated : %d", var_5_0))

		return nil
	end

	self._allTransition[var_5_0] = arg_5_1

	return arg_5_1
end

function KSComFSM:getTransitionByUID(arg_6_1)
	return self._allTransition[arg_6_1]
end

function KSComFSM:getStateByTransition(arg_7_1)
	return self._allState[arg_7_1:getUniqueID()]
end

function KSComFSM:_doInitAllTransitions()
	return
end

function KSComFSM:_doInitAllGraphs()
	return
end

return KSComFSM
