local CmdFinishTransition = class("CmdFinishTransition", require("app.core.fsm.KSComTransition"))

function CmdFinishTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._isDispatch = arg_1_1.isDispatch
end

function CmdFinishTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._entity.cmdFinish then
		return self._isDispatch == (self._entity:getMapType() > 1)
	end

	return false
end

return CmdFinishTransition
