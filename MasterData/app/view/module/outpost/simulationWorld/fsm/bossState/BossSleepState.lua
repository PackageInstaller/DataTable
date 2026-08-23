local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.const.ConstMgr.outpostConst
local BossSleepState = class("BossSleepState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function BossSleepState:onCreate()
	self._stUUID = var_0_2.FsmState.Sleep
end

function BossSleepState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._maxRange = self._entity:getAttr():getAttackMaxRange()
end

function BossSleepState:doBeforeEntering()
	var_0_1:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
end

function BossSleepState:onTickUpdate(arg_4_1)
	return
end

return BossSleepState
