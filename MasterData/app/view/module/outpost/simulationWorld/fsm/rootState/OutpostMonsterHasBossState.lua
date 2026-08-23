local OutpostMonsterHasBossFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostMonsterHasBossFsm")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostMonsterHasBossState = class("OutpostMonsterHasBossState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function OutpostMonsterHasBossState:onCreate()
	self._stUUID = var_0_1.FsmState.HasBossIdle
	self._curFsm = nil
end

function OutpostMonsterHasBossState:doBeforeEntering()
	if not self._curFsm then
		self._curFsm = OutpostMonsterHasBossFsm.new()

		self._curFsm:initPrepareFSM(self._ownerFSM._ownerObj)
		self._curFsm:startupFSM()
	end
end

function OutpostMonsterHasBossState:onTickUpdate(arg_3_1)
	self._curFsm:updateTickFSM(arg_3_1)
end

function OutpostMonsterHasBossState:doBeforeLeaving()
	self._curFsm:setStateFinish()
end

return OutpostMonsterHasBossState
