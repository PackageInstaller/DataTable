local var_0_0 = g.core.const.ConstMgr.outpostConst
local MonsterHasBossDeadState = class("MonsterHasBossDeadState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function MonsterHasBossDeadState:onCreate()
	self._stUUID = var_0_0.FsmState.Dead
end

return MonsterHasBossDeadState
