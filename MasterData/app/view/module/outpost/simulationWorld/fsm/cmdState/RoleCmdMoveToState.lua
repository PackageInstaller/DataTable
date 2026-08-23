local var_0_0 = table.remove
local WalkLine = require("app.core.ksmap.entity.WalkLine")
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_3 = g.core.model.User.outpostData
local var_0_4 = g.core.const.ConstMgr.outpostConst
local RoleCmdMoveToState = class("RoleCmdMoveToState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleCmdMoveToState:onCreate()
	self._stUUID = var_0_4.FsmState.CMD_MOVE_TO
end

function RoleCmdMoveToState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._knight = self._entity:getEntityKnightStruct()
	self._world = self._entity.world
	self._pathList = {}
	self._walkLine = WalkLine.new()
	self._nextPos = nil
	self._cacheBuild = nil
end

function RoleCmdMoveToState:doBeforeEntering()
	self:setFinish(false)

	if not self._entity.cmdBuild then
		self:setFinish(true)

		return
	end

	self._cacheBuild = self._entity.cmdBuild
	self._targetBuild = self._entity.world:getVirtualMap():getBuildByType(self._entity.cmdBuild)

	if not self._targetBuild then
		self._targetBuild = nil

		var_0_3:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)

		return
	else
		local var_3_0 = self._targetBuild:getBuildDoorRandomPos()

		if var_3_0 then
			self._entity:setMovePos(var_3_0)
		else
			self:setFinish(true)

			return
		end
	end

	self._pathList = nil

	self:startTask(handler(self, self.pathFind))
end

function RoleCmdMoveToState:pathFind(arg_4_1)
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
			var_0_3:dispatchWorldEvent(OutpostEvent.RoleMove, {
				entity = self._entity,
				nextPos = self._nextPos
			})
		end)
	else
		var_0_3:dispatchWorldEvent(OutpostEvent.RoleMove, {
			entity = self._entity,
			nextPos = self._nextPos
		})
	end

	self._task = nil
end

function RoleCmdMoveToState:onTickUpdate(arg_6_1)
	if not self._pathList then
		return
	end

	if not self._targetBuild then
		return
	end

	local var_6_0 = g.core.module.ModuleManager:getCurModule().display

	if var_6_0:getName() == "OutpostGameStage" and not self._notWaited and self._entity.cmdBuild == var_0_4.BuildType.WeaponShop then
		self._notWaited = true

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	end

	if self._cacheBuild ~= self._entity.cmdBuild then
		self._world:changeTipsData(var_0_4.TIPS_TYPE.KNIGHT)
		self._entity:getEntityKnightStruct():setClickChangeEquip(false)
		self:doBeforeEntering()

		return
	end

	var_0_3:dispatchWorldEvent(OutpostEvent.KnightToBuild, {
		entity = self._entity,
		nextPos = self._nextPos,
		targetBuild = self._targetBuild
	})

	if not self._nextPos then
		if self._entity.cmdBuild == var_0_4.BuildType.Exchange then
			local var_6_1 = {
				orderType = var_0_4.EXCHANGE_TYPE.SELL
			}

			var_6_1.knightId = self._entity:getEntityKnightStruct():getServerId()

			self._entity.world:getVirtualMap():getBuildByType(var_0_4.BuildType.Exchange):getBuildStruct():onEffect(var_6_1)
			self._entity:clearCmdState()
		elseif self._entity.cmdBuild == var_0_4.BuildType.ArmorShop or self._entity.cmdBuild == var_0_4.BuildType.WeaponShop then
			local var_6_2 = self._entity:getEntityKnightStruct():getServerId()

			self._world:changeTipsData(var_0_4.TIPS_TYPE.KNIGHT, var_6_2, {
				isKnight = true,
				entity = self._entity,
				knightId = var_6_2,
				buildType = self._entity.cmdBuild
			})

			if var_6_0:getName() == "OutpostGameStage" and self._entity.cmdBuild == var_0_4.BuildType.WeaponShop and self._notWaited and not self._isReady then
				self._isReady = true

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
			end

			self._entity:getEntityKnightStruct():setClickChangeEquip(true)
		end

		return
	end

	local var_6_3, var_6_4 = self._walkLine:step(self._entity:getMoveSpeed() * arg_6_1)

	if var_6_3.x == self._nextPos.x and var_6_3.y == self._nextPos.y then
		self._nextPos = var_0_0(self._pathList, 1)

		if self._nextPos then
			self._walkLine:setLine(var_6_3, self._nextPos)

			local var_6_5, var_6_6 = self._walkLine:step(var_6_4)

			self._entity:setPosVec2(var_6_5)
		else
			self._entity:setPosVec2(var_6_3)
			var_0_3:dispatchWorldEvent(OutpostEvent.RoleIdle, self._entity)
		end
	else
		self._entity:setPosVec2(var_6_3)
	end

	var_0_3:dispatchWorldEvent(OutpostEvent.KnightToBuild, {
		entity = self._entity,
		nextPos = self._nextPos,
		targetBuild = self._targetBuild
	})
end

function RoleCmdMoveToState:doBeforeLeaving()
	self._entity:setMovePos(nil)
	self:stopTask()
end

return RoleCmdMoveToState
