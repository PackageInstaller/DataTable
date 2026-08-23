local OutpostKnightDispatchAtkFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostKnightDispatchAtkFsm")
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_2 = g.core.model.User.outpostData
local var_0_3 = g.core.const.ConstMgr.outpostConst
local OutpostKnightDispatchAtkState = class("OutpostKnightDispatchAtkState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function OutpostKnightDispatchAtkState:onCreate()
	self._stUUID = var_0_3.FsmState.Root_DispatchAtk
	self._curFsm = nil
end

function OutpostKnightDispatchAtkState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
end

function OutpostKnightDispatchAtkState:doBeforeEntering()
	if not self._curFsm then
		self._curFsm = OutpostKnightDispatchAtkFsm.new()

		self._curFsm:initPrepareFSM(self._ownerFSM._ownerObj)
		self._curFsm:startupFSM()
	end
end

function OutpostKnightDispatchAtkState:onTickUpdate(arg_4_1)
	self._curFsm:updateTickFSM(arg_4_1)
end

function OutpostKnightDispatchAtkState:doBeforeLeaving()
	self._curFsm:setStateFinish()
	self._entity:setMovePos(nil)
	var_0_2:dispatchWorldEvent(OutpostEvent.KnightInAttacking, {
		isInAttacking = false,
		entity = self._entity
	})
end

return OutpostKnightDispatchAtkState
