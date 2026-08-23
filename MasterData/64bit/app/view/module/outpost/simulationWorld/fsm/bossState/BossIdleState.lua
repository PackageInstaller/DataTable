local var_0_0 = math.random
local var_0_1 = {
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
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_3 = g.core.model.User.outpostData
local var_0_4 = g.core.const.ConstMgr.outpostConst
local BossIdleState = class("BossIdleState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function BossIdleState:onCreate()
	self._stUUID = var_0_4.FsmState.Idle
end

function BossIdleState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._maxRange = self._entity:getAttr():getAttackMaxRange()
	self._tickCount = 0
	self._idleTime = 0
	self._lastDirIndex = self:getRandomDirIndex()
end

function BossIdleState:doBeforeEntering()
	self._idleTime = self:getRandomIdleTime()

	var_0_3:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
end

function BossIdleState:onTickUpdate(arg_4_1)
	self._tickCount = self._tickCount + 1

	if self._tickCount < var_0_4.WorldParam.TickDelayCount then
		return
	end

	self._tickCount = 0

	if not self._entity.fightTarget or self._entity.fightTarget:needRecover() or not self._entity:isSameMapType(self._entity.fightTarget) then
		self._entity:setFightTarget(nil)

		local var_4_0

		for iter_4_0, iter_4_1 in ipairs((self._map:queryRangeEntities(self._entity.x, self._entity.y, self._maxRange))) do
			if self._entity:isEnemy(iter_4_1) and not iter_4_1:needRecover() and self._entity:isSameMapType(iter_4_1) then
				var_4_0 = iter_4_1

				break
			end
		end

		if var_4_0 then
			self._entity:setFightTarget(var_4_0)
		else
			self._idleTime = self._idleTime - arg_4_1

			if self._idleTime > 0 then
				return
			end

			local var_4_1, var_4_2 = self._map:pixelToCoord(self._entity.x, self._entity.y)
			local var_4_3 = var_4_1 + var_0_1[self._lastDirIndex + 1]
			local var_4_4 = var_4_2 + var_0_1[self._lastDirIndex + 2]

			for iter_4_2 = 1, self:getRandomMoveLen() do
				if self._map:canMoveInMiniPos(var_4_3, var_4_4, self._entity:getMapType()) then
					var_4_3 = var_4_3 + var_0_1[self._lastDirIndex + 1]
					var_4_4 = var_4_4 + var_0_1[self._lastDirIndex + 2]
				else
					var_4_3 = var_4_3 - var_0_1[self._lastDirIndex + 1]
					var_4_4 = var_4_4 - var_0_1[self._lastDirIndex + 2]
					self._lastDirIndex = self:getRandomDirIndex()

					break
				end
			end

			self._entity:setMovePos(cc.p(self._map:coordToPixel(var_4_3, var_4_4)))
		end
	else
		self._entity:setMovePos(cc.p(self._entity.fightTarget.x, self._entity.fightTarget.y))
	end
end

function BossIdleState:getRandomDirIndex()
	return 2 * var_0_0(0, 7)
end

function BossIdleState:getRandomIdleTime()
	return var_0_0(3, 10)
end

function BossIdleState:getRandomMoveLen()
	return var_0_0(3, 5)
end

return BossIdleState
