local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local KsMath = require("app.core.utils.KsMath")
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_3 = g.core.model.User.outpostData
local var_0_4 = g.core.const.ConstMgr.outpostConst
local RoleIdleState = class("RoleIdleState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleIdleState:onCreate()
	self._stUUID = var_0_4.FsmState.Idle
end

function RoleIdleState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._maxRange = self._entity:getAttr():getAttackMaxRange()
end

function RoleIdleState:doBeforeEntering()
	var_0_3:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
end

function RoleIdleState:onTickUpdate(arg_4_1)
	if not self._entity.fightTarget or not self._entity.fightTarget:canVictim() or not self._entity:isSameMapType(self._entity.fightTarget) then
		self._entity:setFightTarget(nil)

		local var_4_0

		for iter_4_0, iter_4_1 in ipairs((self._map:queryRangeEntities(self._entity.x, self._entity.y, self._maxRange))) do
			if self._entity:isEnemy(iter_4_1) and iter_4_1:canVictim() and self._entity:isSameMapType(iter_4_1) then
				var_4_0 = iter_4_1

				break
			end
		end

		if var_4_0 then
			self._entity:setFightTarget(var_4_0)
		elseif self._entity:isKnight() then
			local var_4_1 = self._map:getGridByMapType((self._entity:getMapType()))
			local var_4_2 = KsMath.mathCoordinateIndex(var_4_1[math.random(1, #var_4_1)])

			self._entity:setMovePos(cc.p(OutpostCommon.coordToPixel(var_4_2.x, var_4_2.y)))
		end
	else
		local var_4_3 = self._entity:getAttr():getAttackMinRange()

		if self._entity:getDis2(self._entity.fightTarget) < var_4_3 * var_4_3 then
			local var_4_4 = self._entity.x - self._entity.fightTarget.x
			local var_4_5 = self._entity.y - self._entity.fightTarget.y

			if self._entity.x - self._entity.fightTarget.x == 0 and var_4_5 == 0 then
				local var_4_6 = math.random(0, 2 * math.pi)

				var_4_4 = math.cos(var_4_6)
				var_4_5 = math.sin(var_4_6)
			end

			local var_4_7 = math.sqrt(var_4_4 * var_4_4 + var_4_5 * var_4_5)

			self._entity:setMovePos(cc.p(self._entity.fightTarget.x + var_4_4 / var_4_7 * var_4_3 + 10, self._entity.fightTarget.y + var_4_5 / var_4_7 * var_4_3 + 10))
		else
			self._entity:setMoveTarget(self._entity.fightTarget)
		end
	end
end

return RoleIdleState
