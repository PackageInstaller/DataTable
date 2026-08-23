local var_0_0 = table.remove
local WalkLine = require("app.core.ksmap.entity.WalkLine")
local var_0_2 = g.core.const.ConstMgr.outpostConst
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_4 = g.core.model.User.outpostData
local RoleMoveToPosState = class("RoleMoveToPosState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleMoveToPosState:onCreate()
	self._stUUID = var_0_2.FsmState.MoveToPos
end

function RoleMoveToPosState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._pathList = {}
	self._walkLine = WalkLine.new()
	self._nextPos = nil
end

function RoleMoveToPosState:doBeforeEntering()
	if not self._entity.movePos then
		self:setFinish(true)

		return
	end

	self:setFinish(false)

	self._maxRange = self._entity:getAttr():getAttackMaxRange()
	self._pathList = nil

	self:startTask(handler(self, self.pathFind))
end

function RoleMoveToPosState:pathFind(arg_4_1)
	local var_4_0 = cc.p(self._entity:getPos())

	self._pathList = self._world:aStarPath(var_4_0, self._entity.movePos, arg_4_1)

	if self._pathList then
		var_0_0(self._pathList, 1)

		self._nextPos = var_0_0(self._pathList, 1)

		self._walkLine:setLine(var_4_0, self._nextPos)
	else
		self._pathList = {}
		self._nextPos = self._entity.movePos

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

function RoleMoveToPosState:onTickUpdate(arg_6_1)
	if not self._pathList then
		return
	end

	if not self._nextPos then
		self._entity:setMovePos(nil)
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

	if not self._entity.fightTarget or not self._entity.fightTarget:isBoss() then
		self:setFinish(true)
		self._entity:setMovePos(nil)
	end
end

function RoleMoveToPosState:doBeforeLeaving()
	self._entity:setMovePos(nil)
	self:stopTask()
end

return RoleMoveToPosState
