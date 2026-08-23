local var_0_0 = table.remove
local WalkLine = require("app.core.ksmap.entity.WalkLine")
local var_0_2 = g.core.const.ConstMgr.outpostConst
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_4 = g.core.model.User.outpostData
local KnightNoVitMoveToPosState = class("KnightNoVitMoveToPosState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function KnightNoVitMoveToPosState:onCreate()
	self._stUUID = var_0_2.FsmState.MoveToPos
end

function KnightNoVitMoveToPosState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._pathList = {}
	self._walkLine = WalkLine.new()
	self._nextPos = nil
end

function KnightNoVitMoveToPosState:doBeforeEntering()
	self:setFinish(false)
	self:tryFindBuild()
	var_0_4:dispatchWorldEvent(OutpostEvent.RoleMove, {
		entity = self._entity,
		nextPos = self._nextPos
	})
end

function KnightNoVitMoveToPosState:tryFindBuild()
	local var_4_0 = var_0_2.BuildType.None

	if self._entity:isDead() then
		var_4_0 = var_0_2.BuildType.Hospital
	elseif self._entity.hunger <= 0 then
		var_4_0 = var_0_2.BuildType.Restaurant
	elseif self._entity.mood <= 0 then
		var_4_0 = var_0_2.BuildType.Tavern
	elseif self._entity:getFatigue() <= 0 then
		var_4_0 = var_0_2.BuildType.Hotel
	end

	self._targetBuild = self._entity.world:getVirtualMap():getBuildByType(var_4_0)

	if not self._targetBuild then
		self._targetBuild = nil

		var_0_4:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)

		return
	else
		local var_4_1 = self._targetBuild:getBuildDoorRandomPos()

		if var_4_1 then
			self._entity:setMovePos(var_4_1)
		else
			self:setFinish(true)

			return
		end
	end

	self._pathList = nil

	self:startTask(handler(self, self.pathFind))
end

function KnightNoVitMoveToPosState:onTickUpdate(arg_5_1)
	if not self._targetBuild then
		self:tryFindBuild()

		return
	end

	var_0_4:dispatchWorldEvent(OutpostEvent.KnightToBuild, {
		entity = self._entity,
		nextPos = self._nextPos,
		targetBuild = self._targetBuild
	})

	if not self._pathList then
		return
	end

	if not self._nextPos then
		if not self._targetBuild:isInBuildDoorRange(self._entity.x, self._entity.y) then
			self._nextPos = self._targetBuild:getBuildDoorRandomPos()

			self._walkLine:setLine(cc.p(self._entity:getPos()), self._nextPos)
		elseif self._targetBuild:tryJoinKnight(self._entity) then
			self._entity:setMovePos(nil)
			self:setFinish(true)
		end

		return
	end

	local var_5_0, var_5_1 = self._walkLine:step(self._entity:getMoveSpeed() * arg_5_1)

	if var_5_0.x == self._nextPos.x and var_5_0.y == self._nextPos.y then
		self._nextPos = var_0_0(self._pathList, 1)

		if self._nextPos then
			self._walkLine:setLine(var_5_0, self._nextPos)

			local var_5_2, var_5_3 = self._walkLine:step(var_5_1)

			self._entity:setPosVec2(var_5_2)
		else
			self._entity:setPosVec2(var_5_0)
			var_0_4:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
		end
	else
		self._entity:setPosVec2(var_5_0)
	end
end

function KnightNoVitMoveToPosState:doBeforeLeaving()
	self._entity:setMovePos(nil)
	self:stopTask()
end

function KnightNoVitMoveToPosState:pathFind(arg_7_1)
	local var_7_0 = cc.p(self._entity:getPos())

	self._pathList = self._world:aStarPath(var_7_0, self._entity.movePos, arg_7_1)

	if self._pathList then
		var_0_0(self._pathList, 1)

		self._nextPos = var_0_0(self._pathList, 1)

		self._walkLine:setLine(var_7_0, self._nextPos)
	else
		self._pathList = {}
		self._nextPos = self._entity.movePos

		self._walkLine:setLine(var_7_0, self._nextPos)
	end

	self._task = nil
end

return KnightNoVitMoveToPosState
