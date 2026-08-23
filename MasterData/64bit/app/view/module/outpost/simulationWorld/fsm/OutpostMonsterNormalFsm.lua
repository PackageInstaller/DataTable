local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = "app.view.module.outpost.simulationWorld.fsm.monsterIdleState."
local var_0_2 = "app.view.module.outpost.simulationWorld.fsm.transition."
local OutpostMonsterNormalFsm = class("OutpostMonsterNormalFsm", require("app.core.fsm.KSComFSM"))

function OutpostMonsterNormalFsm:ctor()
	OutpostMonsterNormalFsm.super.ctor(self)
end

function OutpostMonsterNormalFsm:_doStartupEntrance()
	self:transitionTo((require("app.core.fsm.KSComTransition").new({
		tid = var_0_0.FsmState.Idle
	})))
end

function OutpostMonsterNormalFsm:_doInitAllStates()
	local var_3_0 = self:_getState("MonsterDeadState")
	local var_3_1 = self:_getState("MonsterMoveToTargetState")
	local var_3_2 = self:_getState("MonsterMoveToPosState")
	local var_3_3 = self:_getState("MonsterIdleState")
	local var_3_4 = self:_getTran("HpTransition", {
		isRate = false,
		checkValue = 0,
		isLower = true,
		entity = self._ownerObj
	})
	local var_3_5 = self:_getTran("MoveTransition", {
		isTarget = true,
		entity = self._ownerObj
	})

	var_3_3:addTransitionState(var_3_5, var_3_1)
	var_3_2:addTransitionState(var_3_5, var_3_1)
	var_3_1:addTransitionState(self:_getTran("MoveTransition", {
		isTarget = true,
		isCheckStop = true,
		entity = self._ownerObj
	}), var_3_3)
	var_3_1:addTransitionState(var_3_4, var_3_0)
	var_3_2:addTransitionState(var_3_4, var_3_0)
	var_3_2:addTransitionState(self:_getTran("FinishTransition"), var_3_3)
	var_3_3:addTransitionState(var_3_4, var_3_0)
	var_3_3:addTransitionState(self:_getTran("MoveTransition", {
		isTarget = false,
		entity = self._ownerObj
	}), var_3_2)
end

function OutpostMonsterNormalFsm:_getTran(arg_4_1, arg_4_2)
	return self:addTransition(require(var_0_2 .. arg_4_1).new(arg_4_2))
end

function OutpostMonsterNormalFsm:_getState(arg_5_1)
	local var_5_0 = require(var_0_1 .. arg_5_1).new()

	self:_addState(var_5_0)

	return var_5_0
end

function OutpostMonsterNormalFsm:_getCommonState(arg_6_1)
	local var_6_0 = require("app.view.module.outpost.simulationWorld.fsm.commonAtkState." .. arg_6_1).new()

	self:_addState(var_6_0)

	return var_6_0
end

return OutpostMonsterNormalFsm
