local var_0_0 = "app.view.module.outpost.simulationWorld.fsm.cmdState."
local var_0_1 = "app.view.module.outpost.simulationWorld.fsm.transition."
local var_0_2 = g.core.const.ConstMgr.outpostConst
local OutpostKnightUserCmdFsm = class("OutpostKnightUserCmdFsm", require("app.core.fsm.KSComFSM"))

function OutpostKnightUserCmdFsm:ctor()
	OutpostKnightUserCmdFsm.super.ctor(self)
end

function OutpostKnightUserCmdFsm:_doStartupEntrance()
	self:transitionTo((require("app.core.fsm.KSComTransition").new({
		tid = var_0_2.FsmState.CMD_IDLE
	})))
end

function OutpostKnightUserCmdFsm:_doInitAllStates()
	local var_3_0 = self:_getState("RoleCmdIdleState")
	local var_3_1 = self:_getState("RoleCmdMoveToState")

	var_3_0:addTransitionState(self:_getTran("CmdMoveTransition", {
		isCheckStop = true,
		entity = self._ownerObj
	}), var_3_1)
	var_3_1:addTransitionState(self:_getTran("FinishTransition"), var_3_0)
end

function OutpostKnightUserCmdFsm:_getTran(arg_4_1, arg_4_2)
	return self:addTransition(require(var_0_1 .. arg_4_1).new(arg_4_2))
end

function OutpostKnightUserCmdFsm:_getState(arg_5_1)
	local var_5_0 = require(var_0_0 .. arg_5_1).new()

	self:_addState(var_5_0)

	return var_5_0
end

return OutpostKnightUserCmdFsm
