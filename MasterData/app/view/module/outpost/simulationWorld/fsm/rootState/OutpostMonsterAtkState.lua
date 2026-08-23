local OutpostMonsterAtkFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostMonsterAtkFsm")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostMonsterAtkState = class("OutpostMonsterAtkState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function OutpostMonsterAtkState:onCreate()
	self._stUUID = var_0_1.FsmState.ReadyingAtk
	self._curFsm = nil
end

function OutpostMonsterAtkState:doBeforeEntering()
	if not self._curFsm then
		self._curFsm = OutpostMonsterAtkFsm.new()

		self._curFsm:initPrepareFSM(self._ownerFSM._ownerObj)
		self._curFsm:startupFSM()
	end
end

function OutpostMonsterAtkState:onTickUpdate(arg_3_1)
	self._curFsm:updateTickFSM(arg_3_1)
end

function OutpostMonsterAtkState:doBeforeLeaving()
	self._curFsm:setStateFinish()
end

return OutpostMonsterAtkState
