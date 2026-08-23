local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.const.ConstMgr.outpostConst
local RoleAtkRecoverIdleState = class("RoleAtkRecoverIdleState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleAtkRecoverIdleState:onCreate()
	self._stUUID = var_0_2.FsmState.Idle
end

function RoleAtkRecoverIdleState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._tickTime = 1
end

function RoleAtkRecoverIdleState:doBeforeEntering()
	self:setFinish(false)

	self._tickTime = 1

	var_0_1:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
end

function RoleAtkRecoverIdleState:onTickUpdate(arg_4_1)
	self._tickTime = self._tickTime - arg_4_1

	if self._tickTime <= 0 then
		self._tickTime = 1

		self:setFinish(true)
	end
end

return RoleAtkRecoverIdleState
