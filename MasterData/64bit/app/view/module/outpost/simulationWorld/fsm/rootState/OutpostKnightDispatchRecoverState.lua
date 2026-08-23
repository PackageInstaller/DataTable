local OutpostKnightDispatchRecoverFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostKnightDispatchRecoverFsm")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostKnightDispatchRecoverState = class("OutpostKnightDispatchRecoverState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function OutpostKnightDispatchRecoverState:onCreate()
	self._stUUID = var_0_1.FsmState.Root_DispatchRecover
	self._curFsm = nil
end

function OutpostKnightDispatchRecoverState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
end

function OutpostKnightDispatchRecoverState:doBeforeEntering()
	if not self._curFsm then
		self._curFsm = OutpostKnightDispatchRecoverFsm.new()

		self._curFsm:initPrepareFSM(self._ownerFSM._ownerObj)
		self._curFsm:startupFSM()
	end
end

function OutpostKnightDispatchRecoverState:onTickUpdate(arg_4_1)
	self._curFsm:updateTickFSM(arg_4_1)
end

function OutpostKnightDispatchRecoverState:doBeforeLeaving()
	self._curFsm:setStateFinish()
	self._entity:setMovePos(nil)
end

return OutpostKnightDispatchRecoverState
