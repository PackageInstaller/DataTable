local var_0_0 = "app.view.module.outpost.simulationWorld.fsm.knightNoVitState."
local var_0_1 = "app.view.module.outpost.simulationWorld.fsm.transition."
local var_0_2 = g.core.const.ConstMgr.outpostConst
local OutpostKnightNoVitFsm = class("OutpostKnightNoVitFsm", require("app.core.fsm.KSComFSM"))

function OutpostKnightNoVitFsm:ctor()
	OutpostKnightNoVitFsm.super.ctor(self)
end

function OutpostKnightNoVitFsm:_doStartupEntrance()
	self:transitionTo((require("app.core.fsm.KSComTransition").new({
		tid = var_0_2.FsmState.NORMAL_IDLE
	})))
end

function OutpostKnightNoVitFsm:_doInitAllStates()
	local var_3_0 = self:_getState("KnightNoVitWalkState")
	local var_3_1 = self:_getState("KnightNoVitMoveToPosState")
	local var_3_2 = self:_getState("KnightNoVitNormalRecoverState")
	local var_3_3 = self:_getState("KnightNoVitNormalIdleState")

	var_3_0:addTransitionState(self:_getTran("WalkFinishTransition", {
		isCheckStop = true,
		entity = self._ownerObj
	}), var_3_3)
	var_3_3:addTransitionState(self:_getTran("CheckRecoverTransition", {
		isNeed = true,
		entity = self._ownerObj
	}), var_3_1)
	var_3_1:addTransitionState(self:_getTran("InRecoverTransition", {
		isIn = true,
		entity = self._ownerObj
	}), var_3_2)
	var_3_2:addTransitionState(self:_getTran("InRecoverTransition", {
		isIn = false,
		entity = self._ownerObj
	}), var_3_3)

	local var_3_4 = self:_getTran("FinishTransition")

	var_3_1:addTransitionState(var_3_4, var_3_3)
	var_3_3:addTransitionState(var_3_4, var_3_0)
end

function OutpostKnightNoVitFsm:_getTran(arg_4_1, arg_4_2)
	return self:addTransition(require(var_0_1 .. arg_4_1).new(arg_4_2))
end

function OutpostKnightNoVitFsm:_getState(arg_5_1)
	local var_5_0 = require(var_0_0 .. arg_5_1).new()

	self:_addState(var_5_0)

	return var_5_0
end

return OutpostKnightNoVitFsm
