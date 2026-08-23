local var_0_0 = g.core.const.ConstMgr.outpostConst
local RoleCmdIdleState = class("RoleCmdIdleState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleCmdIdleState:onCreate()
	self._stUUID = var_0_0.FsmState.CMD_IDLE
end

function RoleCmdIdleState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
end

function RoleCmdIdleState:doBeforeEntering()
	return
end

function RoleCmdIdleState:onTickUpdate(arg_4_1)
	return
end

return RoleCmdIdleState
