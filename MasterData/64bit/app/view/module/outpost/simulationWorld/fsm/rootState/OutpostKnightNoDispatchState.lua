local OutpostKnightNoDispatchFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostKnightNoDispatchFsm")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostKnightNoDispatchState = class("OutpostKnightNoDispatchState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function OutpostKnightNoDispatchState:onCreate()
	self._stUUID = var_0_1.FsmState.Root_NoDispatch
	self._curFsm = nil
end

function OutpostKnightNoDispatchState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
end

function OutpostKnightNoDispatchState:doBeforeEntering()
	if not self._curFsm then
		self._curFsm = OutpostKnightNoDispatchFsm.new()

		self._curFsm:initPrepareFSM(self._ownerFSM._ownerObj)
		self._curFsm:startupFSM()
	end
end

function OutpostKnightNoDispatchState:onTickUpdate(arg_4_1)
	self._curFsm:updateTickFSM(arg_4_1)
end

function OutpostKnightNoDispatchState:doBeforeLeaving()
	self._curFsm:setStateFinish()
	self._entity:setMovePos(nil)
end

return OutpostKnightNoDispatchState
