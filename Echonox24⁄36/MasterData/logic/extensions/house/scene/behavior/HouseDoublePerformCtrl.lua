-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/behavior/HouseDoublePerformCtrl.lua

module("logic.extensions.house.scene.behavior.HouseDoublePerformCtrl", package.seeall)

local M = class("HouseDoublePerformCtrl", HousePerformCtrl)
local PerformStatus = HouseEnum.PerformStatus
local ContactStatus = HouseEnum.ContactStatus
local AnimationState = HouseEnum.AnimationState
local PerformEffectType = HouseEnum.PerformEffectType
local PerformCtrlType = HouseEnum.PerformCtrlType
local kContactDistance = 0.6
local vec3Temp1 = Vector3.New()
local vec3Temp2 = Vector3.New()

function M:ctor()
	M.super.ctor(self)

	self._contactStatus = ContactStatus.None
	self._canStartPerform = false
	self._leftUnit = nil
	self._rightUnit = nil
	self._tryStartContactTimer = SchedulerCtrl.New(self._tryStartContact, self)
	self._endContactProcessTimer = SchedulerCtrl.New(self._endContactProcess, self)
	self._endContactCdTimer = SchedulerCtrl.New(self._endContactCd, self)
end

function M:clear()
	self._tryStartContactTimer:clear()

	self._tryStartContactTimer = nil

	self._endContactProcessTimer:clear()

	self._endContactProcessTimer = nil

	self._endContactCdTimer:clear()

	self._endContactCdTimer = nil

	M.super.clear(self)

	self._contactStatus = ContactStatus.None
	self._canStartPerform = false
	self._leftUnit = nil
	self._rightUnit = nil
end

function M:getCtrlType()
	return PerformCtrlType.Double
end

function M:canPerform()
	return self._performStatus == PerformStatus.None and self._contactStatus == ContactStatus.Running and self._canStartPerform
end

function M:canPerformForGM()
	return self._contactStatus == ContactStatus.Running and self._canStartPerform
end

function M:reFindAllUsablePerformCO()
	self._usablePerformCOs = {}

	local dict = HouseConfig.instance:getPerformCODict()

	for _, performCO in pairs(dict) do
		local canPlay = self:_canPlayDefaultPerform(performCO)

		if canPlay and performCO:getPerformType() == PerformCtrlType.Double and performCO:isHeroIdsMatch(self._id) and performCO:isStatusMatch(self._performUnitA) and performCO:isStatusMatch(self._performUnitB) then
			table.insert(self._usablePerformCOs, performCO)
		end
	end

	return self._usablePerformCOs
end

function M:interruptPerform()
	if self._contactStatus == ContactStatus.Running then
		M.super.interruptPerform(self)

		self._contactStatus = ContactStatus.CDing

		self:_tryEndContact()
	end
end

function M:endPerformance(isInterrput)
	M.super.endPerformance(self, isInterrput)
	self:_tryEndContact()
end

function M:getContactStatus()
	return self._contactStatus
end

function M:tryTrigger()
	local COs = self:reFindAllUsablePerformCO()
	local hasCustom = false

	for _, CO in ipairs(COs) do
		if CO:getEffectType() == PerformEffectType.Custom then
			hasCustom = true

			break
		end
	end

	local defaultRate = HouseConfig.instance:getHouseConst("ContactRateDefault")
	local upRate = HouseConfig.instance:getHouseConst("ContactRateUp")
	local rate = hasCustom and upRate.numValue or defaultRate.numValue
	local randomNum = math.random(1, 100)

	if randomNum <= rate and #COs > 0 then
		self:_triggerSucceed()
	else
		self:_triggerFailed()
	end
end

function M:_triggerSucceed()
	self._contactStatus = ContactStatus.Running
	self._canStartPerform = false

	self._performUnitA.performCtrl:setRunningCtrl(self)
	self._performUnitB.performCtrl:setRunningCtrl(self)
	self._performUnitA.ai:stopCurrentAI()
	self._performUnitB.ai:stopCurrentAI()
	self:_setUnitsDestination()
	self._tryStartContactTimer:restart(0.5, true)
end

function M:_triggerFailed()
	self._contactStatus = ContactStatus.CDing

	self:_startContactCd(false)
end

function M:_tryStartContact()
	local isLeftArrived = self._leftUnit.navMeshMover:isArrivedDestination()
	local isRightArrived = self._rightUnit.navMeshMover:isArrivedDestination()

	if isLeftArrived and isRightArrived then
		self._tryStartContactTimer:stop()
		self._leftUnit.navMesh:setNavMeshAgentStatus(false)
		self._rightUnit.navMesh:setNavMeshAgentStatus(false)
		self._leftUnit.navMeshMover:setStopChangeAngle(true)
		self._rightUnit.navMeshMover:setStopChangeAngle(true)
		self._leftUnit.navMeshMover:setDirection(HouseEnum.UnitDirection.Right)
		self._rightUnit.navMeshMover:setDirection(HouseEnum.UnitDirection.Left)
		self._leftUnit.meshModel:play(AnimationState.Idle, true)
		self._rightUnit.meshModel:play(AnimationState.Idle, true)

		self._canStartPerform = true

		self._endContactProcessTimer:restart(self:_getContactTime(), false)
	end
end

function M:_setUnitsDestination()
	local unitAPosX, unitAPosY, unitAPosZ = self._performUnitA.navMesh:getNavMeshGoPos()
	local unitBPosX, unitBPosY, unitBPosZ = self._performUnitB.navMesh:getNavMeshGoPos()
	local angleA = self._performUnitA.navMeshMover:getCurrAngle()
	local angleB = self._performUnitB.navMeshMover:getCurrAngle()
	local centerPosX = (unitAPosX + unitBPosX) / 2
	local centerPosY = (unitAPosY + unitBPosY) / 2
	local centerPosZ = (unitAPosZ + unitBPosZ) / 2
	local angle = (angleA + angleB) / 2
	local aScreenPosX, aScreenPosY = HouseSceneUtil.worldPosToScreenPos(angle, unitAPosX, unitAPosY)
	local bScreenPosX, bScreenPosY = HouseSceneUtil.worldPosToScreenPos(angle, unitBPosX, unitBPosY)

	self._leftUnit = nil
	self._rightUnit = nil

	if aScreenPosX < bScreenPosX then
		self._leftUnit = self._performUnitA
		self._rightUnit = self._performUnitB
	else
		self._leftUnit = self._performUnitB
		self._rightUnit = self._performUnitA
	end

	local centerScreenPosX, centerScreenPosY = HouseSceneUtil.worldPosToScreenPos(angle, centerPosX, centerPosY)
	local leftPosX, leftPosY = HouseSceneUtil.screenPosToWorldPos(angle, centerScreenPosX - kContactDistance, centerScreenPosY)
	local rightPosX, rightPosY = HouseSceneUtil.screenPosToWorldPos(angle, centerScreenPosX + kContactDistance, centerScreenPosY)

	vec3Temp1:Set(leftPosX, leftPosY, centerPosZ)
	vec3Temp2:Set(rightPosX, rightPosY, centerPosZ)
	self._leftUnit.navMesh:setDestination(vec3Temp1)
	self._rightUnit.navMesh:setDestination(vec3Temp2)
end

function M:_getContactTime()
	local timeStr = HouseConfig.instance:getHouseConst("ContactContinueTime")
	local timeList = string.split(timeStr.strValue, "#")

	return math.random(tonumber(timeList[1]), tonumber(timeList[2]))
end

function M:_endContactProcess()
	self._contactStatus = ContactStatus.CDing

	self:_tryEndContact()
end

function M:_tryEndContact()
	if self._contactStatus == ContactStatus.CDing and self._performStatus ~= PerformStatus.Running then
		self._performUnitA.performCtrl:setRunningCtrl(nil)
		self._performUnitB.performCtrl:setRunningCtrl(nil)
		self._performUnitA.performCtrl:startContactCd()
		self._performUnitB.performCtrl:startContactCd()
		self._performUnitA.navMesh:setNavMeshAgentStatus(true)
		self._performUnitB.navMesh:setNavMeshAgentStatus(true)
		self._performUnitA.navMeshMover:setStopChangeAngle(false)
		self._performUnitB.navMeshMover:setStopChangeAngle(false)
		self._performUnitA.ai:setStop(false)
		self._performUnitB.ai:setStop(false)
		self:_startContactCd(true)
	end
end

function M:_startContactCd(isSucceed)
	self._canStartPerform = false

	local failCd = HouseConfig.instance:getHouseConst("ContactFailCd")
	local succeedCd = HouseConfig.instance:getHouseConst("ContactSucceedCd")
	local time = isSucceed and succeedCd.numValue or failCd.numValue

	self._endContactCdTimer:restart(time, false)
end

function M:_endContactCd()
	self._contactStatus = ContactStatus.None
end

return M
