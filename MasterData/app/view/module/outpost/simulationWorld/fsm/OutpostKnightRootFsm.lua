local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = "app.view.module.outpost.simulationWorld.fsm.rootState."
local var_0_2 = "app.view.module.outpost.simulationWorld.fsm.transition."
local OutpostKnightRootFsm = class("OutpostKnightRootFsm", require("app.core.fsm.KSComFSM"))

function OutpostKnightRootFsm:ctor()
	OutpostKnightRootFsm.super.ctor(self)
end

function OutpostKnightRootFsm:_doStartupEntrance()
	local var_2_0 = require("app.core.fsm.KSComTransition").new
	local var_2_1 = {}

	if self._ownerObj:getMapType() > 1 then
		var_2_1.tid = var_0_0.FsmState.Root_DispatchAtk or var_0_0.FsmState.Root_NoDispatch
	end

	self:transitionTo((require("app.core.fsm.KSComTransition").new(var_2_1)))
end

function OutpostKnightRootFsm:_doInitAllStates()
	local var_3_0 = self:_getState("OutpostKnightDispatchAtkState")
	local var_3_1 = self:_getState("OutpostKnightAtkBossState")
	local var_3_2 = self:_getState("OutpostKnightDispatchRecoverState")
	local var_3_3 = self:_getState("OutpostKnightNoDispatchState")
	local var_3_4 = self:_getState("OutpostKnightNoVitState")
	local var_3_5 = self:_getState("OutpostUserCmdState")
	local var_3_6 = self:_getTran("CheckRecoverTransition", {
		isNeed = false,
		entity = self._ownerObj
	})
	local var_3_7 = self:_getTran("HasBossTransition", {
		hasBoss = true,
		entity = self._ownerObj
	})
	local var_3_8 = self:_getTran("CmdEnterTransition", {
		isDispatch = false,
		entity = self._ownerObj
	})
	local var_3_9 = self:_getTran("VitCheckTransition", {
		hasVit = false,
		entity = self._ownerObj
	})

	var_3_3:addTransitionState(var_3_8, var_3_5)
	var_3_3:addTransitionState(var_3_9, var_3_4)
	var_3_3:addTransitionState(self:_getTran("DispatchTransition", {
		needDispatch = true,
		entity = self._ownerObj
	}), var_3_0)
	var_3_3:addTransitionState(var_3_7, var_3_1)
	var_3_0:addTransitionState(var_3_8, var_3_5)
	var_3_0:addTransitionState(var_3_9, var_3_4)
	var_3_0:addTransitionState(self:_getTran("DispatchTransition", {
		needDispatch = false,
		entity = self._ownerObj
	}), var_3_3)
	var_3_0:addTransitionState(self:_getTran("CheckRecoverTransition", {
		checkBossState = true,
		isNeed = true,
		entity = self._ownerObj
	}), var_3_2)
	var_3_0:addTransitionState(var_3_7, var_3_1)
	var_3_1:addTransitionState(var_3_8, var_3_5)
	var_3_1:addTransitionState(self:_getTran("HasBossTransition", {
		hasBoss = false,
		entity = self._ownerObj
	}), var_3_0)
	var_3_1:addTransitionState(self:_getTran("CheckRecoverTransition", {
		isNeed = true,
		entity = self._ownerObj
	}), var_3_2)
	var_3_2:addTransitionState(var_3_8, var_3_5)
	var_3_2:addTransitionState(var_3_9, var_3_4)
	var_3_2:addTransitionState(self:_getTran("CheckRecoverTransition", {
		checkBossState = true,
		isNeed = false,
		entity = self._ownerObj
	}), var_3_0)
	var_3_5:addTransitionState(self:_getTran("CmdFinishTransition", {
		isDispatch = true,
		entity = self._ownerObj
	}), var_3_3)
	var_3_5:addTransitionState(self:_getTran("CmdFinishTransition", {
		isDispatch = false,
		entity = self._ownerObj
	}), var_3_0)
	var_3_4:addTransitionState(var_3_8, var_3_5)
	var_3_4:addTransitionState(self:_getTran("VitCheckTransition", {
		hasVit = true,
		entity = self._ownerObj
	}), var_3_0)
	var_3_4:addTransitionState(var_3_7, var_3_1)
end

function OutpostKnightRootFsm:_getTran(arg_4_1, arg_4_2)
	return self:addTransition(require(var_0_2 .. arg_4_1).new(arg_4_2))
end

function OutpostKnightRootFsm:_getState(arg_5_1)
	local var_5_0 = require(var_0_1 .. arg_5_1).new()

	self:_addState(var_5_0)

	return var_5_0
end

return OutpostKnightRootFsm
