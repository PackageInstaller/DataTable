local OutpostKnightNoVitFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostKnightNoVitFsm")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostKnightNoVitState = class("OutpostKnightNoVitState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function OutpostKnightNoVitState:onCreate()
	self._stUUID = var_0_1.FsmState.Root_NoVit
	self._curFsm = nil
end

function OutpostKnightNoVitState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
end

function OutpostKnightNoVitState:doBeforeEntering()
	if not self._curFsm then
		self._curFsm = OutpostKnightNoVitFsm.new()

		self._curFsm:initPrepareFSM(self._ownerFSM._ownerObj)
		self._curFsm:startupFSM()
	end
end

function OutpostKnightNoVitState:onTickUpdate(arg_4_1)
	self._curFsm:updateTickFSM(arg_4_1)
end

function OutpostKnightNoVitState:doBeforeLeaving()
	self._curFsm:setStateFinish()
	self._entity:setMovePos(nil)
end

return OutpostKnightNoVitState
