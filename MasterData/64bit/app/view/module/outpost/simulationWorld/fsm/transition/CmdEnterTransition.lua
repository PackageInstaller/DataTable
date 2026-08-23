local CmdEnterTransition = class("CmdEnterTransition", require("app.core.fsm.KSComTransition"))

function CmdEnterTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._isDispatch = arg_1_1.isDispatch
end

function CmdEnterTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if not self._entity.cmdFinish then
		return true
	end

	return false
end

return CmdEnterTransition
