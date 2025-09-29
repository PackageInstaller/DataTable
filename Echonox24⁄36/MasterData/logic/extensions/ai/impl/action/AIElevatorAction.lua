-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIElevatorAction.lua

module("logic.extensions.ai.impl.action.AIElevatorAction", package.seeall)

local M = class("AIElevatorAction", AINode)
local PlayerStatus = HouseEnum.PlayerStatus
local BehaviorStatus = HouseEnum.BehaviorStatus
local ElevatorHeroStatus = SceneEnum.ElevatorHeroStatus
local ElevatorMoveStatus = SceneEnum.ElevatorMoveStatus
local UnitDirection = HouseEnum.UnitDirection

function M:ctor(context)
	M.super.ctor(self, context)

	self._pushBtnTimer = SchedulerCtrl.New(self._onPushBtnEnd, self)
	self._blockUpdate = false
	self._blockTrigger = false
	self._heroStatus = ElevatorHeroStatus.None
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)
end

function M:onStart()
	M.super.onStart(self)

	self._blockUpdate = false
	self._blockTrigger = false

	local unit = self:getContext():getUnit()

	unit.navMesh:setNavMeshAgentStatus(true)
	unit.followRobot:setNavMeshAgentStatus(true)

	local moveDir = unit.model:getTowardDirection()

	self._heroStatus = ElevatorHeroStatus.Wait
	self._currElevatorLevelUnit = HouseSceneUtil.getElevatorUnit(unit.model:getCurrentLevelId())

	if moveDir ~= ElevatorMoveStatus.Hold then
		local isUp = moveDir == ElevatorMoveStatus.Up

		if not self._currElevatorLevelUnit.status:isBtnOn(isUp) then
			self._heroStatus = ElevatorHeroStatus.PushBtn
		end
	end

	self:_triggerActionByHeroStatus()
	self:_setEvents(true)
	self:_refreshUnitEleavtorStatus()

	return self
end

function M:onUpdate()
	if not self._blockUpdate then
		local unit = self:getContext():getUnit()
		local hasArrived = unit.navMeshMover:isArrivedDestination()

		if self._heroStatus == ElevatorHeroStatus.PushBtn then
			if hasArrived then
				self._heroStatus = ElevatorHeroStatus.Wait

				self:_refreshUnitEleavtorStatus()
				unit.navMesh:setNavMeshAgentStatus(false)
				unit.meshModel:play(HouseEnum.AnimationState.Play, false)

				self._blockUpdate = true
				self._blockTrigger = true

				self._pushBtnTimer:restart(1.5, false)
				HouseDispatcher:dispatchEvent(HouseEventType.ELEAVTOR_PUSH_BTN, unit.model:getCurrentLevelId(), unit.model:getTowardDirection())
			end
		elseif self._heroStatus == ElevatorHeroStatus.Wait then
			if hasArrived then
				unit.model:setStatus(PlayerStatus.WaitingElevator)
			end
		elseif self._heroStatus == ElevatorHeroStatus.MoveInEleavtor then
			local distance = unit.navMesh:getRemainingDistance()

			if not unit.model:judgeStatus(PlayerStatus.Elevator) and distance and distance < 2.5 then
				unit.model:setStatus(PlayerStatus.Elevator)
				unit.model:setBehaviorStatus(BehaviorStatus.Elevator)
				unit.navMesh:setRadius(CommEnum.NavMeshRadius.EnterElevator)
				unit.followRobot:setRadius(CommEnum.NavMeshRadius.EnterElevator)
			end

			if hasArrived then
				self._heroStatus = ElevatorHeroStatus.InEleavtor

				self:_refreshUnitEleavtorStatus()
				unit.navMeshMover:setDirection(UnitDirection.Forward)
			end
		elseif self._heroStatus == ElevatorHeroStatus.MoveOutEleavtor then
			self:_resetHero()
			self:_resetData()

			return self:onEnd(AIConst.AIStatus.SUCCESS)
		end
	end

	return self
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.ELEAVTOR_TRIGGER_HERO_STATUS, self._onTriggerHeroStatus, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.ELEAVTOR_TRIGGER_HERO_STATUS, self._onTriggerHeroStatus, self)
	end
end

function M:_refreshUnitEleavtorStatus()
	local unit = self:getContext():getUnit()

	unit.model:setElevatorStatus(self._heroStatus)
end

function M:_onTriggerHeroStatus(e, triggerUnit, status)
	self._blockUpdate = true

	local unit = self:getContext():getUnit()

	if triggerUnit == unit then
		self._heroStatus = status

		self:_refreshUnitEleavtorStatus()
		self:_triggerActionByHeroStatus()
	end

	self._blockUpdate = false
end

function M:_triggerActionByHeroStatus()
	if self._blockTrigger then
		return
	end

	local unit = self:getContext():getUnit()

	if self._heroStatus == ElevatorHeroStatus.Wait then
		local pos = self._currElevatorLevelUnit.lineMgr:getWaitPosByUnit(unit)

		self:_setUnitDestination(pos)
		unit.followRobot:switchFollow(false)
		unit.followRobot:setDestination(pos, -0.5)
	elseif self._heroStatus == ElevatorHeroStatus.PushBtn then
		local pos = self._currElevatorLevelUnit.status:getDownBtnTriggerPos()

		if self._currElevatorLevelUnit:isBottom() then
			pos = self._currElevatorLevelUnit.status:getUpBtnTriggerPos()
		end

		self:_setUnitDestination(pos)

		local waitPos = self._currElevatorLevelUnit.lineMgr:getWaitPosByUnit(unit)

		unit.followRobot:switchFollow(false)
		unit.followRobot:setDestination(waitPos, -0.5)
	elseif self._heroStatus == ElevatorHeroStatus.MoveInEleavtor then
		local lobbyUnit = self._currElevatorLevelUnit:getLobbyUnit()
		local pos = lobbyUnit.posMgr:getRidePosByUnit(unit)

		self:_setUnitDestination(pos)
		unit.followRobot:switchFollow(false)
		unit.followRobot:setDestination(pos, 0, 0.5)
	elseif self._heroStatus == ElevatorHeroStatus.MoveOutEleavtor then
		-- block empty
	end
end

function M:_setUnitDestination(pos)
	local unit = self:getContext():getUnit()

	unit.navMesh:setNavMeshAgentStatus(true)
	unit.navMeshMover:setStopChangeAngle(false)
	unit.navMesh:setDestination(pos)
	unit.navMesh:resumeNavMesh()
end

function M:_onPushBtnEnd()
	self._blockTrigger = false

	self:_triggerActionByHeroStatus()

	self._blockUpdate = false
end

function M:_resetHero()
	local unit = self:getContext():getUnit()

	self._currElevatorLevelUnit.lineMgr:removeWaitUnit(unit)

	local lobbyUnit = self._currElevatorLevelUnit:getLobbyUnit()

	lobbyUnit.posMgr:removeRideUnit(unit)
	unit.model:clearStatus(PlayerStatus.WaitingElevator)
	unit.model:clearStatus(PlayerStatus.Elevator)
	unit.model:clearBehaviorStatus(BehaviorStatus.Elevator)
	unit.navMesh:setRadius()
	unit.followRobot:setRadius()
	unit.followRobot:switchFollow(true)
	unit.model:clearElevator()
	unit.navMesh:setNavMeshAgentStatus(true)
	unit.navMeshMover:setStopChangeAngle(false)

	local robot = unit.followRobot:getFollowUnit()

	if robot then
		robot.navMesh:setNavMeshAgentStatus(true)
		robot.navMeshMover:setStopChangeAngle(false)
	end

	self._currElevatorLevelUnit = nil
end

function M:onReset()
	if self._heroStatus ~= ElevatorHeroStatus.None then
		self:_resetHero()
	end

	self:_resetData()
	M.super.onReset(self)
end

function M:onRecycle()
	if self._heroStatus ~= ElevatorHeroStatus.None then
		self:_resetHero()
	end

	self:_resetData()
	M.super.onRecycle(self)
end

function M:onDestroy()
	M.super.onDestroy(self)
end

function M:_resetData()
	self:_setEvents(false)
	self._pushBtnTimer:stop()

	self._blockUpdate = false
	self._blockTrigger = false
	self._heroStatus = ElevatorHeroStatus.None

	self:_refreshUnitEleavtorStatus()
end

return M
