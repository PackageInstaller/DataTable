local MoveTransition = class("MoveTransition", require("app.core.fsm.KSComTransition"))

function MoveTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._isTarget = arg_1_1.isTarget
	self._isCheckStop = arg_1_1.isCheckStop
end

function MoveTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._isCheckStop then
		return self._entity.moveTarget == nil and self._entity.movePos == nil
	elseif self._isTarget then
		return self._entity.moveTarget ~= nil
	else
		return self._entity.movePos ~= nil
	end
end

return MoveTransition
