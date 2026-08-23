local var_0_0 = g.core.const.ConstMgr.outpostConst
local RoleAtkRecoverState = class("RoleAtkRecoverState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleAtkRecoverState:onCreate()
	self._stUUID = var_0_0.FsmState.AtkRecover
end

return RoleAtkRecoverState
