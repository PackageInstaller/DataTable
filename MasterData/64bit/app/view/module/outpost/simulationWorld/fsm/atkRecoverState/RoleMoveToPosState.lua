local var_0_0 = g.core.config.outpost_parameter_info
local var_0_1 = table.remove
local WalkLine = require("app.core.ksmap.entity.WalkLine")
local var_0_3 = g.core.const.ConstMgr.outpostConst
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_5 = g.core.model.User.outpostData
local RoleMoveToPosState = class("RoleMoveToPosState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleMoveToPosState:onCreate()
	self._stUUID = var_0_3.FsmState.MoveToPos
end

function RoleMoveToPosState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._knight = self._entity:getEntityKnightStruct()
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._pathList = {}
	self._walkLine = WalkLine.new()
	self._nextPos = nil
	self._hasBossHpValue = var_0_0.get(var_0_3.WorldParam.HasBossHpCheck).parameter * 0.001
	self._hasBossHungerValue = var_0_0.get(var_0_3.WorldParam.HasBossHungerCheck).parameter
	self._hasBossMoodValue = var_0_0.get(var_0_3.WorldParam.HasBossMoodCheck).parameter
	self._hasBossFatigueValue = var_0_0.get(var_0_3.WorldParam.HasBossFatigueCheck).parameter
end

function RoleMoveToPosState:doBeforeEntering()
	self:setFinish(false)
	self:tryFindBuild()

	if self._targetBuild then
		var_0_5:dispatchWorldEvent(OutpostEvent.RoleMove, {
			entity = self._entity,
			nextPos = self._nextPos,
			targetBuild = self._targetBuild
		})
	else
		var_0_5:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
	end
end

function RoleMoveToPosState:tryFindBuild()
	local var_4_0 = var_0_3.BuildType.None

	if var_0_5:getBuildData():getBuild({
		type = var_0_3.BuildType.Exchange
	}):canSellByKnightBag(self._entity:getEntityKnightStruct():getOwnBagData()) then
		var_4_0 = var_0_3.BuildType.Exchange
	elseif self._map:hasBoss() then
		if self._entity:getAttr():getHpRate() <= self._hasBossHpValue then
			var_4_0 = var_0_3.BuildType.Hospital
		elseif self._entity.hunger <= self._hasBossHungerValue then
			var_4_0 = var_0_3.BuildType.Restaurant
		elseif self._entity.mood <= self._hasBossMoodValue then
			var_4_0 = var_0_3.BuildType.Tavern
		elseif self._entity:getFatigue() <= self._hasBossFatigueValue then
			var_4_0 = var_0_3.BuildType.Hotel
		end
	elseif self._entity:isDead() then
		var_4_0 = var_0_3.BuildType.Hospital
	elseif self._entity.hunger <= 0 then
		var_4_0 = var_0_3.BuildType.Restaurant
	elseif self._entity.mood <= 0 then
		var_4_0 = var_0_3.BuildType.Tavern
	elseif self._entity:getFatigue() <= 0 then
		var_4_0 = var_0_3.BuildType.Hotel
	end

	self._targetBuild = self._map:getBuildByType(var_4_0)

	if not self._targetBuild then
		self._targetBuild = nil

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

function RoleMoveToPosState:onTickUpdate(arg_5_1)
	if not self._targetBuild then
		self:tryFindBuild()

		return
	end

	var_0_5:dispatchWorldEvent(OutpostEvent.KnightToBuild, {
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
		elseif self._targetBuild:getBuildType() == var_0_3.BuildType.Exchange then
			local var_5_0 = {
				orderType = var_0_3.EXCHANGE_TYPE.SELL
			}

			var_5_0.knightId = self._entity:getEntityKnightStruct():getServerId()

			self._targetBuild:getBuildStruct():onEffect(var_5_0)
			self._entity:setMovePos(nil)
			self:setFinish(true)
		elseif self._targetBuild:tryJoinKnight(self._entity) then
			self._entity:setMovePos(nil)
			self:setFinish(true)
		end

		return
	end

	local var_5_1, var_5_2 = self._walkLine:step(self._entity:getMoveSpeed() * arg_5_1)

	if var_5_1.x == self._nextPos.x and var_5_1.y == self._nextPos.y then
		self._nextPos = var_0_1(self._pathList, 1)

		if self._nextPos then
			self._walkLine:setLine(var_5_1, self._nextPos)

			local var_5_3, var_5_4 = self._walkLine:step(var_5_2)

			self._entity:setPosVec2(var_5_3)
		else
			self._entity:setPosVec2(var_5_1)
			var_0_5:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
		end
	else
		self._entity:setPosVec2(var_5_1)
	end
end

function RoleMoveToPosState:pathFind(arg_6_1)
	local var_6_0 = cc.p(self._entity:getPos())

	self._pathList = self._world:aStarPath(var_6_0, self._entity.movePos, arg_6_1)

	if self._pathList then
		var_0_1(self._pathList, 1)

		self._nextPos = var_0_1(self._pathList, 1)

		self._walkLine:setLine(var_6_0, self._nextPos)
	else
		self._pathList = {}
		self._nextPos = self._entity.movePos

		self._walkLine:setLine(var_6_0, self._nextPos)
	end

	self._task = nil
end

function RoleMoveToPosState:doBeforeLeaving()
	self._targetBuild = nil

	self._entity:setMovePos(nil)
	self:stopTask()
end

return RoleMoveToPosState
