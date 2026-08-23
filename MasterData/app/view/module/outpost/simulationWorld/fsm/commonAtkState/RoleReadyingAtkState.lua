local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.const.ConstMgr.outpostConst
local RoleReadyingAtkState = class("RoleReadyingAtkState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleReadyingAtkState:onCreate()
	self._stUUID = var_0_2.FsmState.ReadyingAtk
end

function RoleReadyingAtkState:onInitState()
	self._entity = self._ownerFSM._ownerObj
end

function RoleReadyingAtkState:doBeforeEntering()
	var_0_1:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
	var_0_1:dispatchWorldEvent(OutpostEvent.KnightInAttacking, {
		isInAttacking = true,
		entity = self._entity
	})
end

function RoleReadyingAtkState:onTickUpdate(arg_4_1)
	if self._entity.fightTarget and not self._entity.fightTarget:canVictim() and not self._entity:isSameMapType(self._entity.fightTarget) then
		self._entity:setFightTarget(nil)
	end
end

function RoleReadyingAtkState:doBeforeLeaving(arg_5_1)
	var_0_1:dispatchWorldEvent(OutpostEvent.KnightInAttacking, {
		isInAttacking = false,
		entity = self._entity
	})
end

return RoleReadyingAtkState
