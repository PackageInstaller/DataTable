local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = "app.view.module.outpost.simulationWorld.fsm.monsterHasBossState."
local var_0_2 = "app.view.module.outpost.simulationWorld.fsm.transition."
local OutpostMonsterHasBossFsm = class("OutpostMonsterHasBossFsm", require("app.core.fsm.KSComFSM"))

function OutpostMonsterHasBossFsm:ctor()
	OutpostMonsterHasBossFsm.super.ctor(self)
end

function OutpostMonsterHasBossFsm:_doStartupEntrance()
	self:transitionTo((require("app.core.fsm.KSComTransition").new({
		tid = var_0_0.FsmState.HasBossIdle
	})))
end

function OutpostMonsterHasBossFsm:_doInitAllStates()
	local var_3_0 = self:_getState("MonsterHasBossDeadState")
	local var_3_1 = self:_getState("MonsterHasBossMoveToPosState")
	local var_3_2 = self:_getState("MonsterHasBossIdleState")
	local var_3_3 = self:_getTran("HpTransition", {
		isRate = false,
		checkValue = 0,
		isLower = true,
		entity = self._ownerObj
	})

	var_3_1:addTransitionState(var_3_3, var_3_0)
	var_3_1:addTransitionState(self:_getTran("FinishTransition"), var_3_2)
	var_3_2:addTransitionState(var_3_3, var_3_0)
	var_3_2:addTransitionState(self:_getTran("MoveTransition", {
		isTarget = false,
		entity = self._ownerObj
	}), var_3_1)
end

function OutpostMonsterHasBossFsm:_getTran(arg_4_1, arg_4_2)
	return self:addTransition(require(var_0_2 .. arg_4_1).new(arg_4_2))
end

function OutpostMonsterHasBossFsm:_getState(arg_5_1)
	local var_5_0 = require(var_0_1 .. arg_5_1).new()

	self:_addState(var_5_0)

	return var_5_0
end

return OutpostMonsterHasBossFsm
