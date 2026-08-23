local var_0_0 = g.core.const.ConstMgr.outpostConst
local RoleSubmitItemState = class("RoleSubmitItemState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleSubmitItemState:onCreate()
	self._stUUID = var_0_0.FsmState.SubmitItem
end

return RoleSubmitItemState
