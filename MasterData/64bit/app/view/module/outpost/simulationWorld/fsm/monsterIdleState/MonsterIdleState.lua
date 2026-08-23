local var_0_0 = {
	-1,
	-1,
	-1,
	0,
	1,
	1,
	0,
	-1,
	0,
	1,
	1,
	-1,
	1,
	0,
	1,
	1
}
local var_0_1 = math.random
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_3 = g.core.model.User.outpostData
local var_0_4 = g.core.const.ConstMgr.outpostConst
local MonsterIdleState = class("MonsterIdleState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function MonsterIdleState:onCreate()
	self._stUUID = var_0_4.FsmState.Idle
end

function MonsterIdleState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._tickCount = 0
	self._idleTime = 0
	self._lastDirIndex = self:getRandomDirIndex()
end

function MonsterIdleState:getRandomDirIndex()
	return 2 * var_0_1(0, 7)
end

function MonsterIdleState:getRandomIdleTime()
	return var_0_1(2, 6)
end

function MonsterIdleState:getRandomMoveLen()
	return var_0_1(2, 6)
end

function MonsterIdleState:doBeforeEntering()
	self._maxRange = self._entity:getAttr():getAttackMaxRange()
	self._idleTime = self:getRandomIdleTime()

	var_0_3:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
end

function MonsterIdleState:onTickUpdate(arg_7_1)
	self._tickCount = self._tickCount + 1

	if self._tickCount < var_0_4.WorldParam.TickDelayCount then
		return
	end

	self._tickCount = 0

	if not self._entity.fightTarget or not self._entity.fightTarget:canVictim() or not self._entity:isSameMapType(self._entity.fightTarget) then
		self._entity:setFightTarget(nil)

		local var_7_0

		for iter_7_0, iter_7_1 in ipairs((self._map:queryRangeEntities(self._entity.x, self._entity.y, self._maxRange))) do
			if self._entity:isEnemy(iter_7_1) and iter_7_1:canVictim() and self._entity:isSameMapType(iter_7_1) then
				var_7_0 = iter_7_1

				break
			end
		end

		if var_7_0 then
			self._entity:setFightTarget(var_7_0)
		else
			self._idleTime = self._idleTime - arg_7_1

			if self._idleTime > 0 then
				return
			end

			local var_7_1, var_7_2 = self._map:pixelToCoord(self._entity.x, self._entity.y)
			local var_7_3 = var_7_1 + var_0_0[self._lastDirIndex + 1]
			local var_7_4 = var_7_2 + var_0_0[self._lastDirIndex + 2]

			for iter_7_2 = 1, self:getRandomMoveLen() do
				if self._map:canMoveInMiniPos(var_7_3, var_7_4, self._entity:getMapType()) then
					var_7_3 = var_7_3 + var_0_0[self._lastDirIndex + 1]
					var_7_4 = var_7_4 + var_0_0[self._lastDirIndex + 2]
				else
					var_7_3 = var_7_3 - var_0_0[self._lastDirIndex + 1]
					var_7_4 = var_7_4 - var_0_0[self._lastDirIndex + 2]
					self._lastDirIndex = self:getRandomDirIndex()

					break
				end
			end

			self._entity:setMovePos(cc.p(self._map:coordToPixel(var_7_3, var_7_4)))
		end
	else
		local var_7_5 = self._entity:getAttr():getAttackMinRange()

		if self._entity:getDis2(self._entity.fightTarget) < var_7_5 * var_7_5 then
			local var_7_6 = self._entity.x - self._entity.fightTarget.x
			local var_7_7 = self._entity.y - self._entity.fightTarget.y

			if self._entity.x - self._entity.fightTarget.x == 0 and var_7_7 == 0 then
				local var_7_8 = var_0_1(0, 2 * math.pi)

				var_7_6 = math.cos(var_7_8)
				var_7_7 = math.sin(var_7_8)
			end

			local var_7_9 = math.sqrt(var_7_6 * var_7_6 + var_7_7 * var_7_7)

			self._entity:setMovePos(cc.p(self._entity.fightTarget.x + var_7_6 / var_7_9 * var_7_5 + 10, self._entity.fightTarget.y + var_7_7 / var_7_9 * var_7_5 + 10))
		else
			self._entity:setMoveTarget(self._entity.fightTarget)
		end
	end
end

return MonsterIdleState
