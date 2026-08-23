local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.const.ConstMgr.outpostConst
local RoleReadyingBossState = class("RoleReadyingBossState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleReadyingBossState:onCreate()
	self._stUUID = var_0_2.FsmState.ReadyingBoss
end

function RoleReadyingBossState:onInitState()
	self._entity = self._ownerFSM._ownerObj
end

function RoleReadyingBossState:doBeforeEntering()
	self:setFinish(false)
	var_0_1:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)

	if self._entity.fightTarget and self._entity.fightTarget:isInSleep() then
		var_0_1:dispatchWorldEvent(OutpostEvent.RoleMoveToBossEnd, {
			entity = self._entity,
			boss = self._entity.fightTarget
		})
	end
end

function RoleReadyingBossState:onTickUpdate(arg_4_1)
	if self._entity.fightTarget and not self._entity.fightTarget:isInSleep() then
		self:setFinish(true)
	end
end

return RoleReadyingBossState
