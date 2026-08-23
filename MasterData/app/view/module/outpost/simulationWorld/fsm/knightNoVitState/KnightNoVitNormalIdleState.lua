local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.const.ConstMgr.outpostConst
local RoleNormalRecoverState = class("RoleNormalRecoverState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleNormalRecoverState:onCreate()
	self._stUUID = var_0_2.FsmState.NORMAL_IDLE
end

function RoleNormalRecoverState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
end

function RoleNormalRecoverState:doBeforeEntering()
	self._tickTime = math.random(3, 7)

	self:setFinish(false)
	var_0_1:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
end

function RoleNormalRecoverState:onTickUpdate(arg_4_1)
	self._tickTime = self._tickTime - arg_4_1

	if self._tickTime <= 0 then
		self._tickTime = 0

		self:setFinish(true)
	end
end

return RoleNormalRecoverState
