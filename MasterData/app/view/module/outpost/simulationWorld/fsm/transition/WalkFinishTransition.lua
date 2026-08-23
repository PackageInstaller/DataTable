local WalkFinishTransition = class("WalkFinishTransition", require("app.core.fsm.KSComTransition"))

function WalkFinishTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._isTarget = arg_1_1.isTarget
	self._isCheckStop = arg_1_1.isCheckStop
end

function WalkFinishTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._isCheckStop then
		return self._entity.movePos == nil
	else
		return self._entity.movePos ~= nil
	end
end

return WalkFinishTransition
