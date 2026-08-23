local CmdCmdMoveTransition = class("CmdCmdMoveTransition", require("app.core.fsm.KSComTransition"))

function CmdCmdMoveTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._isDispatch = arg_1_1.isDispatch
end

function CmdCmdMoveTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._entity.cmdBuild then
		return not self._entity.inBuilding
	end

	return false
end

return CmdCmdMoveTransition
