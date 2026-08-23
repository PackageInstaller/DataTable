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
local MonsterHasBossIdleState = class("MonsterHasBossIdleState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function MonsterHasBossIdleState:onCreate()
	self._stUUID = var_0_4.FsmState.Idle
end

function MonsterHasBossIdleState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._tickCount = 0
	self._idleTime = 0
	self._lastDirIndex = self:getRandomDirIndex()
end

function MonsterHasBossIdleState:getRandomDirIndex()
	return 2 * var_0_1(0, 7)
end

function MonsterHasBossIdleState:getRandomIdleTime()
	return var_0_1(2, 6)
end

function MonsterHasBossIdleState:getRandomMoveLen()
	return var_0_1(2, 6)
end

function MonsterHasBossIdleState:doBeforeEntering()
	self._maxRange = self._entity:getAttr():getAttackMaxRange()
	self._idleTime = self:getRandomIdleTime()

	var_0_3:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
end

function MonsterHasBossIdleState:onTickUpdate(arg_7_1)
	self._tickCount = self._tickCount + 1

	if self._tickCount < var_0_4.WorldParam.TickDelayCount then
		return
	end

	self._tickCount = 0
	self._idleTime = self._idleTime - arg_7_1

	if self._idleTime > 0 then
		return
	end

	local var_7_0, var_7_1 = self._map:pixelToCoord(self._entity.x, self._entity.y)
	local var_7_2 = var_7_0 + var_0_0[self._lastDirIndex + 1]
	local var_7_3 = var_7_1 + var_0_0[self._lastDirIndex + 2]

	for iter_7_0 = 1, self:getRandomMoveLen() do
		if self._map:canMoveInMiniPos(var_7_2, var_7_3, self._entity:getMapType()) then
			var_7_2 = var_7_2 + var_0_0[self._lastDirIndex + 1]
			var_7_3 = var_7_3 + var_0_0[self._lastDirIndex + 2]
		else
			var_7_2 = var_7_2 - var_0_0[self._lastDirIndex + 1]
			var_7_3 = var_7_3 - var_0_0[self._lastDirIndex + 2]
			self._lastDirIndex = self:getRandomDirIndex()

			break
		end
	end

	self._entity:setMovePos(cc.p(self._map:coordToPixel(var_7_2, var_7_3)))
end

return MonsterHasBossIdleState
