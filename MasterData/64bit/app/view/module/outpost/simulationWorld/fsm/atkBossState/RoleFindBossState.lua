local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.const.ConstMgr.outpostConst
local RoleFindBossState = class("RoleFindBossState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleFindBossState:onCreate()
	self._stUUID = var_0_2.FsmState.FindBoss
end

function RoleFindBossState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
end

function RoleFindBossState:doBeforeEntering()
	var_0_1:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
end

function RoleFindBossState:onTickUpdate(arg_4_1)
	local var_4_0 = self._map:getBoss()
	local var_4_1 = next(var_4_0)

	if var_4_1 then
		self._entity:setFightTarget(var_4_0[var_4_1])

		local var_4_2 = self._entity:getAttr():getAttackMaxRange()

		self._entity:setMovePos(cc.p(var_4_0[var_4_1].x + math.random(-var_4_2, var_4_2), var_4_0[var_4_1].y + math.random(-var_4_2, var_4_2)))
	else
		self._entity:setFightTarget(nil)
	end
end

return RoleFindBossState
