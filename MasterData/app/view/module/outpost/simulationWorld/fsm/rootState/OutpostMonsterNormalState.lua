local OutpostMonsterNormalFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostMonsterNormalFsm")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostMonsterNormalState = class("OutpostMonsterNormalState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function OutpostMonsterNormalState:onCreate()
	self._stUUID = var_0_1.FsmState.Idle
	self._curFsm = nil
end

function OutpostMonsterNormalState:doBeforeEntering()
	if not self._curFsm then
		self._curFsm = OutpostMonsterNormalFsm.new()

		self._curFsm:initPrepareFSM(self._ownerFSM._ownerObj)
		self._curFsm:startupFSM()
	end
end

function OutpostMonsterNormalState:onTickUpdate(arg_3_1)
	self._curFsm:updateTickFSM(arg_3_1)
end

function OutpostMonsterNormalState:doBeforeLeaving()
	self._curFsm:setStateFinish()
end

return OutpostMonsterNormalState
