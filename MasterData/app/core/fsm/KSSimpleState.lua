local KSSimpleState = class("KSSimpleState")

function KSSimpleState:ctor()
	self._ownerFSM = nil
	self._stUUID = nil
	self._taskFinish = false
end

function KSSimpleState:initPrepareState(arg_2_1)
	self._ownerFSM = arg_2_1
end

function KSSimpleState:cleanupState()
	self._ownerFSM = nil
end

function KSSimpleState:doBeforeEntering()
	return
end

function KSSimpleState:doBeforeLeaving()
	return
end

function KSSimpleState:doReasonState(arg_6_1)
	return nil
end

function KSSimpleState:actState(arg_7_1)
	self._ownerFSM:transitionTo(arg_7_1)
end

function KSSimpleState:getUniqueID()
	return self._stUUID
end

function KSSimpleState:getOwnerObject()
	return self._ownerFSM._ownerObj
end

function KSSimpleState:getNextState(arg_10_1)
	return self._ownerFSM:getStateByTransition(arg_10_1)
end

function KSSimpleState:_setTaskFinish()
	self._taskFinish = true
end

function KSSimpleState:_isTaskFinish()
	return self._taskFinish
end

return KSSimpleState
