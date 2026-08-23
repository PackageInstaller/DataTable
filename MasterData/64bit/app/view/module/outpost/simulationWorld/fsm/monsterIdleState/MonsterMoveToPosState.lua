local WalkLine = require("app.core.ksmap.entity.WalkLine")
local var_0_2 = g.core.const.ConstMgr.outpostConst
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_4 = g.core.model.User.outpostData
local MonsterMoveToPosState = class("MonsterMoveToPosState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function MonsterMoveToPosState:onCreate()
	self._stUUID = var_0_2.FsmState.MoveToPos
end

function MonsterMoveToPosState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._pathList = {}
	self._walkLine = WalkLine.new()
	self._nextPos = nil
end

function MonsterMoveToPosState:doBeforeEntering()
	if not self._entity.movePos then
		self:setFinish(true)

		return
	end

	self:setFinish(false)

	self._nextPos = self._entity.movePos

	self._walkLine:setLine(cc.p(self._entity:getPos()), self._nextPos)

	self._maxRange = self._entity:getAttr():getAttackMaxRange()

	var_0_4:dispatchWorldEvent(OutpostEvent.RoleMove, {
		entity = self._entity,
		nextPos = self._nextPos
	})
end

function MonsterMoveToPosState:onTickUpdate(arg_4_1)
	if not self._nextPos then
		self._entity:setMovePos(nil)
		self:setFinish(true)

		return
	end

	local var_4_0, var_4_1 = self._walkLine:step(self._entity:getMoveSpeed() * arg_4_1)

	self._entity:setPosVec2(var_4_0)

	if var_4_0.x == self._nextPos.x and var_4_0.y == self._nextPos.y then
		self._nextPos = nil
	end

	if not self._entity.fightTarget or not self._entity.fightTarget:canVictim() then
		local var_4_2

		for iter_4_0, iter_4_1 in ipairs((self._map:queryRangeEntities(self._entity.x, self._entity.y, self._maxRange))) do
			if self._entity:isEnemy(iter_4_1) and iter_4_1:canVictim() then
				var_4_2 = iter_4_1

				break
			end
		end

		if var_4_2 then
			self._entity:setFightTarget(var_4_2)
		end
	else
		self._entity:setMoveTarget(self._entity.fightTarget)
	end
end

function MonsterMoveToPosState:doBeforeLeaving()
	self._entity:setMovePos(nil)
end

return MonsterMoveToPosState
