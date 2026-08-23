local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = "app.view.module.outpost.simulationWorld.fsm.rootState."
local var_0_2 = "app.view.module.outpost.simulationWorld.fsm.transition."
local OutpostMonsterRootFsm = class("OutpostMonsterRootFsm", require("app.core.fsm.KSComFSM"))

function OutpostMonsterRootFsm:ctor()
	OutpostMonsterRootFsm.super.ctor(self)
end

function OutpostMonsterRootFsm:_doStartupEntrance()
	local var_2_0 = require("app.core.fsm.KSComTransition").new
	local var_2_1 = {}

	if self._ownerObj.fightTarget then
		var_2_1.tid = var_0_0.FsmState.ReadyingAtk or var_0_0.FsmState.Idle
	end

	self:transitionTo((require("app.core.fsm.KSComTransition").new(var_2_1)))
end

function OutpostMonsterRootFsm:_doInitAllStates()
	local var_3_0 = self:_getState("OutpostMonsterAtkState")
	local var_3_1 = self:_getState("OutpostMonsterNormalState")
	local var_3_2 = self:_getState("OutpostMonsterHasBossState")
	local var_3_3 = self:_getTran("HasBossTransition", {
		hasBoss = true,
		entity = self._ownerObj
	})

	var_3_0:addTransitionState(self:_getTran("ReadyingAtkTransition", {
		checkHasTarget = false,
		entity = self._ownerObj
	}), var_3_1)
	var_3_0:addTransitionState(var_3_3, var_3_2)
	var_3_1:addTransitionState(var_3_3, var_3_2)
	var_3_1:addTransitionState(self:_getTran("ReadyingAtkTransition", {
		checkHasTarget = true,
		entity = self._ownerObj
	}), var_3_0)
	var_3_2:addTransitionState(self:_getTran("HasBossTransition", {
		hasBoss = false,
		entity = self._ownerObj
	}), var_3_1)
end

function OutpostMonsterRootFsm:_getTran(arg_4_1, arg_4_2)
	return self:addTransition(require(var_0_2 .. arg_4_1).new(arg_4_2))
end

function OutpostMonsterRootFsm:_getState(arg_5_1)
	local var_5_0 = require(var_0_1 .. arg_5_1).new()

	self:_addState(var_5_0)

	return var_5_0
end

return OutpostMonsterRootFsm
