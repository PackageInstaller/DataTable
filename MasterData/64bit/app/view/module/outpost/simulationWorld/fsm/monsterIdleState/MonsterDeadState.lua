local var_0_0 = g.core.const.ConstMgr.outpostConst
local MonsterDeadState = class("MonsterDeadState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function MonsterDeadState:onCreate()
	self._stUUID = var_0_0.FsmState.Dead
end

return MonsterDeadState
