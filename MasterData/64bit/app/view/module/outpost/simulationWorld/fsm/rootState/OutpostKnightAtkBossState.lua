local OutpostKnightAtkBossFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostKnightAtkBossFsm")
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_2 = g.core.model.User.outpostData
local var_0_3 = g.core.const.ConstMgr.outpostConst
local OutpostKnightAtkBossState = class("OutpostKnightAtkBossState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function OutpostKnightAtkBossState:onCreate()
	self._stUUID = var_0_3.FsmState.Root_AtkBoss
	self._curFsm = nil
end

function OutpostKnightAtkBossState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
end

function OutpostKnightAtkBossState:doBeforeEntering()
	if not self._curFsm then
		self._curFsm = OutpostKnightAtkBossFsm.new()

		self._curFsm:initPrepareFSM(self._ownerFSM._ownerObj)
		self._curFsm:startupFSM()
	end
end

function OutpostKnightAtkBossState:onTickUpdate(arg_4_1)
	self._curFsm:updateTickFSM(arg_4_1)
end

function OutpostKnightAtkBossState:doBeforeLeaving()
	self._curFsm:setStateFinish()
	self._entity:setMovePos(nil)
	var_0_2:dispatchWorldEvent(OutpostEvent.KnightInAttacking, {
		isInAttacking = false,
		entity = self._entity
	})
end

return OutpostKnightAtkBossState
