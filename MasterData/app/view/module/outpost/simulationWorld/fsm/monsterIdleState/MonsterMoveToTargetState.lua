local var_0_0 = table.remove
local WalkLine = require("app.core.ksmap.entity.WalkLine")
local var_0_2 = g.core.const.ConstMgr.outpostConst
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_4 = g.core.model.User.outpostData
local MonsterMoveToTargetState = class("MonsterMoveToTargetState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function MonsterMoveToTargetState:onCreate()
	self._stUUID = var_0_2.FsmState.MoveToTarget
end

function MonsterMoveToTargetState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._pathList = {}
	self._walkLine = WalkLine.new()
	self._nextPos = nil
	self._finalPos = nil
end

function MonsterMoveToTargetState:doBeforeEntering()
	if not self._entity.moveTarget then
		self:setFinish(true)

		return
	end

	self:setFinish(false)

	self._maxRange = self._entity:getAttr():getAttackMaxRange()
	self._maxRange2 = self._maxRange * self._maxRange
	self._pathList = nil

	self:startTask(handler(self, self.pathFind))
end

function MonsterMoveToTargetState:onTickUpdate(arg_4_1)
	if not self._pathList then
		return
	end

	if not self._nextPos then
		self._entity:setMoveTarget(nil)
		self:setFinish(true)

		return
	elseif not self._entity.moveTarget:canVictim() then
		self._entity:setMoveTarget(nil)
		self:setFinish(true)

		return
	end

	local var_4_0, var_4_1 = self._walkLine:step(self._entity:getMoveSpeed() * arg_4_1)

	if var_4_0.x == self._nextPos.x and var_4_0.y == self._nextPos.y then
		self._nextPos = var_0_0(self._pathList, 1)

		if self._nextPos then
			self._walkLine:setLine(var_4_0, self._nextPos)

			local var_4_2, var_4_3 = self._walkLine:step(var_4_1)

			self._entity:setPosVec2(var_4_2)
		else
			self._entity:setPosVec2(var_4_0)
		end
	else
		self._entity:setPosVec2(var_4_0)
	end

	if not self._entity.fightTarget then
		local var_4_4

		for iter_4_0, iter_4_1 in ipairs((self._map:queryRangeEntities(self._entity.x, self._entity.y, self._maxRange))) do
			if self._entity:isEnemy(iter_4_1) and iter_4_1:canVictim() then
				var_4_4 = iter_4_1

				break
			end
		end

		if var_4_4 then
			self._entity:setFightTarget(var_4_4)
			self._entity:setMoveTarget(nil)
			self:setFinish(true)

			return
		end
	elseif not self._entity.fightTarget:canVictim() then
		self._entity:setFightTarget(nil)
		self._entity:setMoveTarget(nil)
		self:setFinish(true)

		return
	end

	if self._entity.moveTarget:getDis2(self._finalPos) > self._maxRange2 then
		self._pathList = nil

		self:startTask(handler(self, self.pathFind))
	end
end

function MonsterMoveToTargetState:pathFind(arg_5_1)
	local var_5_0 = cc.p(self._entity:getPos())
	local var_5_1, var_5_2 = self._entity.moveTarget:getPos()

	self._finalPos = cc.p(var_5_1 + math.random(-20, 30), var_5_2 + math.random(-30, 20))
	self._pathList = self._world:aStarPath(var_5_0, self._finalPos, arg_5_1)

	if self._pathList then
		var_0_0(self._pathList, 1)

		self._nextPos = var_0_0(self._pathList, 1) or var_5_0

		self._walkLine:setLine(var_5_0, self._nextPos)
	else
		self._pathList = {}
		self._nextPos = self._finalPos

		self._walkLine:setLine(var_5_0, self._nextPos)
	end

	if arg_5_1 ~= nil then
		arg_5_1:runOnMainThread(function()
			var_0_4:dispatchWorldEvent(OutpostEvent.RoleMove, {
				entity = self._entity,
				nextPos = self._nextPos
			})
		end)
	else
		var_0_4:dispatchWorldEvent(OutpostEvent.RoleMove, {
			entity = self._entity,
			nextPos = self._nextPos
		})
	end

	self._task = nil
end

function MonsterMoveToTargetState:doBeforeLeaving()
	self._entity:setMoveTarget(nil)
	self:stopTask()
end

return MonsterMoveToTargetState
