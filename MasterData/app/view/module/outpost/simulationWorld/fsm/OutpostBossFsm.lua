local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = "app.view.module.outpost.simulationWorld.fsm.bossState."
local var_0_2 = "app.view.module.outpost.simulationWorld.fsm.transition."
local OutpostBossFsm = class("OutpostBossFsm", require("app.core.fsm.KSComFSM"))

function OutpostBossFsm:ctor()
	OutpostBossFsm.super.ctor(self)
end

function OutpostBossFsm:_doStartupEntrance()
	local var_2_0 = require("app.core.fsm.KSComTransition").new
	local var_2_1 = {}

	if self._ownerObj:isInSleep() then
		var_2_1.tid = var_0_0.FsmState.Sleep or var_0_0.FsmState.Idle
	end

	self:transitionTo((require("app.core.fsm.KSComTransition").new(var_2_1)))
end

function OutpostBossFsm:_doInitAllStates()
	local var_3_0 = self:_getCommonState("RoleActiveSkillState")
	local var_3_1 = self:_getCommonState("RoleNormalSkillState")
	local var_3_2 = self:_getCommonState("RoleReadyingAtkState")
	local var_3_3 = self:_getCommonState("RoleDeadState")
	local var_3_4 = self:_getState("BossIdleState")
	local var_3_5 = self:_getState("BossSleepState")
	local var_3_6 = self:_getState("BossMoveToPosState")

	var_3_5:addTransitionState(self:_getTran("SleepTransition", {
		isSleep = false,
		entity = self._ownerObj
	}), var_3_4)
	var_3_4:addTransitionState(self:_getTran("SleepTransition", {
		isSleep = true,
		entity = self._ownerObj
	}), var_3_5)
	var_3_4:addTransitionState(self:_getTran("MoveTransition", {
		isTarget = false,
		entity = self._ownerObj
	}), var_3_6)

	local var_3_7 = self:_getTran("ReadyingAtkTransition", {
		checkHasTarget = true,
		entity = self._ownerObj
	})

	var_3_6:addTransitionState(var_3_7, var_3_2)
	var_3_4:addTransitionState(var_3_7, var_3_2)
	var_3_2:addTransitionState(self:_getTran("ReadyingAtkTransition", {
		checkHasTarget = false,
		entity = self._ownerObj
	}), var_3_4)

	if self._ownerObj.normalSkill then
		var_3_2:addTransitionState(self:_getTran("CdTransition", {
			cdName = "normalSkillCd",
			entity = self._ownerObj
		}), var_3_1)
	end

	if self._ownerObj.activeSkill then
		var_3_2:addTransitionState(self:_getTran("CdTransition", {
			cdName = "activeSkillCd",
			entity = self._ownerObj
		}), var_3_0)
	end

	local var_3_8 = self:_getTran("HpTransition", {
		isRate = false,
		checkValue = 0,
		isLower = true,
		entity = self._ownerObj
	})

	var_3_2:addTransitionState(var_3_8, var_3_3)
	var_3_1:addTransitionState(var_3_8, var_3_3)
	var_3_0:addTransitionState(var_3_8, var_3_3)
	var_3_6:addTransitionState(var_3_8, var_3_3)

	local var_3_9 = self:_getTran("FinishTransition")

	var_3_1:addTransitionState(var_3_9, var_3_2)
	var_3_0:addTransitionState(var_3_9, var_3_2)
	var_3_6:addTransitionState(var_3_9, var_3_4)
end

function OutpostBossFsm:_getTran(arg_4_1, arg_4_2)
	return self:addTransition(require(var_0_2 .. arg_4_1).new(arg_4_2))
end

function OutpostBossFsm:_getState(arg_5_1)
	local var_5_0 = require(var_0_1 .. arg_5_1).new()

	self:_addState(var_5_0)

	return var_5_0
end

function OutpostBossFsm:_getCommonState(arg_6_1)
	local var_6_0 = require("app.view.module.outpost.simulationWorld.fsm.commonAtkState." .. arg_6_1).new()

	self:_addState(var_6_0)

	return var_6_0
end

return OutpostBossFsm
