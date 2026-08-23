local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = "app.view.module.outpost.simulationWorld.fsm.atkBossState."
local var_0_2 = "app.view.module.outpost.simulationWorld.fsm.transition."
local OutpostKnightAtkBossFsm = class("OutpostKnightAtkBossFsm", require("app.core.fsm.KSComFSM"))

function OutpostKnightAtkBossFsm:ctor()
	OutpostKnightAtkBossFsm.super.ctor(self)
end

function OutpostKnightAtkBossFsm:_doStartupEntrance()
	self:transitionTo((require("app.core.fsm.KSComTransition").new({
		tid = var_0_0.FsmState.FindBoss
	})))
end

function OutpostKnightAtkBossFsm:_doInitAllStates()
	local var_3_0 = self:_getState("RoleMoveToPosState")
	local var_3_1 = self:_getState("RoleFindBossState")
	local var_3_2 = self:_getState("RoleReadyingBossState")
	local var_3_3 = self:_getCommonState("RoleDeadState")
	local var_3_4 = self:_getCommonState("RoleNormalSkillState")
	local var_3_5 = self:_getCommonState("RoleActiveSkillState")
	local var_3_6 = self:_getCommonState("RoleReadyingAtkState")
	local var_3_7 = self:_getTran("ReadyingAtkTransition", {
		checkHasTarget = true,
		entity = self._ownerObj
	})
	local var_3_8 = self:_getTran("ReadyingAtkTransition", {
		checkHasTarget = false,
		entity = self._ownerObj
	})
	local var_3_9 = self:_getTran("MoveTransition", {
		isTarget = false,
		entity = self._ownerObj
	})
	local var_3_10 = self:_getTran("HpTransition", {
		isRate = false,
		checkValue = 0,
		isLower = true,
		entity = self._ownerObj
	})

	var_3_1:addTransitionState(var_3_7, var_3_2)
	var_3_0:addTransitionState(var_3_7, var_3_2)
	var_3_6:addTransitionState(var_3_8, var_3_1)
	var_3_2:addTransitionState(var_3_8, var_3_1)
	var_3_0:addTransitionState(self:_getTran("MoveTransition", {
		isCheckStop = true,
		isTarget = true,
		entity = self._ownerObj
	}), var_3_1)
	var_3_3:addTransitionState(var_3_9, var_3_0)
	var_3_1:addTransitionState(var_3_9, var_3_0)
	var_3_2:addTransitionState(var_3_10, var_3_3)
	var_3_6:addTransitionState(var_3_10, var_3_3)
	var_3_0:addTransitionState(var_3_10, var_3_3)
	var_3_4:addTransitionState(var_3_10, var_3_3)
	var_3_5:addTransitionState(var_3_10, var_3_3)
	var_3_1:addTransitionState(var_3_10, var_3_3)

	if self._ownerObj.activeSkill then
		var_3_6:addTransitionState(self:_getTran("CdTransition", {
			cdName = "activeSkillCd",
			entity = self._ownerObj
		}), var_3_5)
	end

	if self._ownerObj.normalSkill then
		var_3_6:addTransitionState(self:_getTran("CdTransition", {
			cdName = "normalSkillCd",
			entity = self._ownerObj
		}), var_3_4)
	end

	local var_3_11 = self:_getTran("FinishTransition")

	var_3_0:addTransitionState(var_3_11, var_3_1)
	var_3_4:addTransitionState(var_3_11, var_3_6)
	var_3_5:addTransitionState(var_3_11, var_3_6)
	var_3_2:addTransitionState(var_3_11, var_3_6)
end

function OutpostKnightAtkBossFsm:_getTran(arg_4_1, arg_4_2)
	return self:addTransition(require(var_0_2 .. arg_4_1).new(arg_4_2))
end

function OutpostKnightAtkBossFsm:_getState(arg_5_1)
	local var_5_0 = require(var_0_1 .. arg_5_1).new()

	self:_addState(var_5_0)

	return var_5_0
end

function OutpostKnightAtkBossFsm:_getCommonState(arg_6_1)
	local var_6_0 = require("app.view.module.outpost.simulationWorld.fsm.commonAtkState." .. arg_6_1).new()

	self:_addState(var_6_0)

	return var_6_0
end

return OutpostKnightAtkBossFsm
