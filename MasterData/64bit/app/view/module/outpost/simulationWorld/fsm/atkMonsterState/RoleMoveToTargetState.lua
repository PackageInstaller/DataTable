local var_0_0 = table.remove
local WalkLine = require("app.core.ksmap.entity.WalkLine")
local var_0_2 = g.core.const.ConstMgr.outpostConst
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_4 = g.core.model.User.outpostData
local RoleMoveToTargetState = class("RoleMoveToTargetState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleMoveToTargetState:onCreate()
	self._stUUID = var_0_2.FsmState.MoveToTarget
end

function RoleMoveToTargetState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._pathList = {}
	self._walkLine = WalkLine.new()
	self._nextPos = nil
	self._finalPos = nil
end

function RoleMoveToTargetState:doBeforeEntering()
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

function RoleMoveToTargetState:pathFind(arg_4_1)
	local var_4_0 = cc.p(self._entity:getPos())
	local var_4_1, var_4_2 = self._entity.moveTarget:getPos()

	self._finalPos = cc.p(var_4_1 + math.random(-10, 10), var_4_2 + math.random(-10, 10))
	self._pathList = self._world:aStarPath(var_4_0, self._finalPos, arg_4_1)

	if self._pathList then
		var_0_0(self._pathList, 1)

		self._nextPos = var_0_0(self._pathList, 1) or var_4_0

		self._walkLine:setLine(var_4_0, self._nextPos)
	else
		self._pathList = {}
		self._nextPos = self._finalPos

		self._walkLine:setLine(var_4_0, self._nextPos)
	end

	if arg_4_1 ~= nil then
		arg_4_1:runOnMainThread(function()
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

function RoleMoveToTargetState:onTickUpdate(arg_6_1)
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

	local var_6_0, var_6_1 = self._walkLine:step(self._entity:getMoveSpeed() * arg_6_1)

	if var_6_0.x == self._nextPos.x and var_6_0.y == self._nextPos.y then
		self._nextPos = var_0_0(self._pathList, 1)

		if self._nextPos then
			self._walkLine:setLine(var_6_0, self._nextPos)

			local var_6_2, var_6_3 = self._walkLine:step(var_6_1)

			self._entity:setPosVec2(var_6_2)
		else
			self._entity:setPosVec2(var_6_0)
		end
	else
		self._entity:setPosVec2(var_6_0)
	end

	if not self._entity.fightTarget then
		local var_6_4

		for iter_6_0, iter_6_1 in ipairs((self._map:queryRangeEntities(self._entity.x, self._entity.y, self._maxRange))) do
			if self._entity:isEnemy(iter_6_1) and iter_6_1:canVictim() and self._entity:isSameMapType(iter_6_1) then
				var_6_4 = iter_6_1

				break
			end
		end

		if var_6_4 then
			self._entity:setFightTarget(var_6_4)
			self._entity:setMoveTarget(nil)
			self:setFinish(true)

			return
		end
	end

	if self._entity.moveTarget:getDis2(self._finalPos) > self._maxRange2 then
		self:stopTask()

		self._pathList = nil

		self:startTask(handler(self, self.pathFind))
	end
end

function RoleMoveToTargetState:refreshPath()
	return
end

function RoleMoveToTargetState:doBeforeLeaving()
	self._entity:setMoveTarget(nil)
	self:stopTask()
end

return RoleMoveToTargetState
