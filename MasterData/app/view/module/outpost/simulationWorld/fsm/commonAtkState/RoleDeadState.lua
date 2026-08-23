local var_0_0 = g.core.const.ConstMgr.outpostConst
local RoleDeadState = class("RoleDeadState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleDeadState:onCreate()
	self._stUUID = var_0_0.FsmState.Dead
end

return RoleDeadState
