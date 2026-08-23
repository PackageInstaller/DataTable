local OutpostKnightUserCmdFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostKnightUserCmdFsm")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostUserCmdState = class("OutpostUserCmdState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function OutpostUserCmdState:onCreate()
	self._stUUID = var_0_1.FsmState.Cmd
	self._curFsm = nil
end

function OutpostUserCmdState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
end

function OutpostUserCmdState:doBeforeEntering()
	if not self._curFsm then
		self._curFsm = OutpostKnightUserCmdFsm.new()

		self._curFsm:initPrepareFSM(self._ownerFSM._ownerObj)
		self._curFsm:startupFSM()
	end
end

function OutpostUserCmdState:onTickUpdate(arg_4_1)
	self._curFsm:updateTickFSM(arg_4_1)
end

function OutpostUserCmdState:doBeforeLeaving()
	self._curFsm:setStateFinish()
	self._entity:clearCmdState()
	self._entity:setMovePos(nil)
	self._world:changeTipsData(var_0_1.TIPS_TYPE.KNIGHT)
end

return OutpostUserCmdState
