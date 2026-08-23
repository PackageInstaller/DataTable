local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = "app.view.module.outpost.simulationWorld.fsm.atkRecoverState."
local var_0_2 = "app.view.module.outpost.simulationWorld.fsm.transition."
local OutpostKnightDispatchRecoverFsm = class("OutpostKnightDispatchRecoverFsm", require("app.core.fsm.KSComFSM"))

function OutpostKnightDispatchRecoverFsm:ctor()
	OutpostKnightDispatchRecoverFsm.super.ctor(self)
end

function OutpostKnightDispatchRecoverFsm:_doStartupEntrance()
	self:transitionTo((require("app.core.fsm.KSComTransition").new({
		tid = var_0_0.FsmState.MoveToPos
	})))
end

function OutpostKnightDispatchRecoverFsm:_doInitAllStates()
	local var_3_0 = self:_getState("RoleMoveToPosState")
	local var_3_1 = self:_getState("RoleAtkRecoverState")
	local var_3_2 = self:_getState("RoleAtkRecoverIdleState")

	var_3_0:addTransitionState(self:_getTran("InRecoverTransition", {
		isIn = true,
		entity = self._ownerObj
	}), var_3_1)
	var_3_1:addTransitionState(self:_getTran("InRecoverTransition", {
		isIn = false,
		entity = self._ownerObj
	}), var_3_2)

	local var_3_3 = self:_getTran("FinishTransition")

	var_3_0:addTransitionState(var_3_3, var_3_2)
	var_3_2:addTransitionState(var_3_3, var_3_0)
end

function OutpostKnightDispatchRecoverFsm:_getTran(arg_4_1, arg_4_2)
	return self:addTransition(require(var_0_2 .. arg_4_1).new(arg_4_2))
end

function OutpostKnightDispatchRecoverFsm:_getState(arg_5_1)
	local var_5_0 = require(var_0_1 .. arg_5_1).new()

	self:_addState(var_5_0)

	return var_5_0
end

return OutpostKnightDispatchRecoverFsm
