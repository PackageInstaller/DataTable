local var_0_0 = g.core.const.ConstMgr.outpostConst
local RoleNormalRecoverState = class("RoleNormalRecoverState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleNormalRecoverState:onCreate()
	self._stUUID = var_0_0.FsmState.NORMAL_RECOVER
end

function RoleNormalRecoverState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
end

function RoleNormalRecoverState:doBeforeEntering()
	self:setFinish(false)
end

function RoleNormalRecoverState:onTickUpdate(arg_4_1)
	self:setFinish(true)
end

return RoleNormalRecoverState
