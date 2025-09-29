-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIGotoBath.lua

module("logic.extensions.ai.impl.action.AIGotoBath", package.seeall)

local M = class("AIGotoBath", AINode)
local UnitDirection = HouseEnum.UnitDirection
local AnimationState = HouseEnum.AnimationState
local PlayerStatus = HouseEnum.PlayerStatus
local WallType = HouseEnum.WallType
local FurnitureAnimation = HouseEnum.FurnitureAnimation
local WorkStatusMode = HouseEnum.WorkStatusMode
local vec3Temp = Vector3.New()
local kFadeOutTime = 1.5
local kFadeInTime = 1

function M:ctor(context)
	M.super.ctor(self, context)

	self._minWaitTime = 0
	self._maxWaitTime = 0
	self._endTime = 0
	self._bathStep = 0
	self._hasAddUnitEvent = false
	self._targetBathUnit = nil
	self._targetBathMO = nil
	self._fadeOutTime = -1
	self._fadeInTime = -1
	self._unitPosX = nil
	self._unitPosY = nil
	self._unitPosZ = nil
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._minWaitTime = aiConfigData.minTime
	self._maxWaitTime = aiConfigData.maxTime
end

function M:onStart()
	M.super.onStart(self)

	self._bathStep = 0
	self._targetBathUnit = nil
	self._targetBathMO = nil

	local unit = self:getContext():getUnit()
	local curZoneId = unit.navMesh:getCurZoneId()
	local roomUnit = HouseSceneUtil.getHouseRoomUnit(curZoneId)
	local zoneMO, bunkInfo = LivingFacilitiesZoneController.instance:findZoneByHeroId(unit.heroId)

	if zoneMO and roomUnit and zoneMO:getId() == curZoneId then
		local bathUnits = HouseSceneUtil.filterUsefulBathRoomByUnits(roomUnit.furnitureMgr:getDictFurnitureUnit())

		if #bathUnits > 0 then
			self:_startBath(bathUnits)

			return self
		elseif HouseSceneUtil.playersRoomHasBath(unit.heroId) then
			local data = self:getContext():getBehaviorData()

			if unit.pajama:canPajama() then
				if data.mode == WorkStatusMode.Start then
					unit.pajama:setPajama(true)
				elseif data.mode == WorkStatusMode.End then
					unit.pajama:setPajama(false)
				end
			end

			return self:onEnd(AIConst.AIStatus.SUCCESS)
		end
	end

	return self:onEnd(AIConst.AIStatus.FAILD)
end

function M:onUpdate()
	local unit = self:getContext():getUnit()

	if self._bathStep == 1 then
		self:_findUsableBath()
	elseif self._bathStep == 2 then
		local hasArrived = unit.navMeshMover:isArrivedDestination()

		if hasArrived then
			self:_startBathAction()
		end
	elseif self._bathStep == 3 then
		if self._fadeOutTime > 0 and Time.time > self._fadeOutTime then
			self._fadeOutTime = -1

			self:_doPajamaAction()
		end

		if Time.time >= self._endTime then
			self._bathStep = 4

			self:_endBathAction()
		end
	elseif self._bathStep == 4 then
		if self._fadeInTime > 0 and Time.time > self._fadeInTime then
			self:_afterFadeIn()
		end
	elseif self._bathStep == 5 then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self
end

function M:handleEnd()
	self._endTime = 0
	self._bathStep = 0
	self._bathUnits = nil
	self._targetBathUnit = nil
	self._targetBathMO = nil
	self._fadeOutTime = -1
	self._fadeInTime = -1
	self._unitPosX = nil
	self._unitPosY = nil
	self._unitPosZ = nil
end

function M:_startBath(bathUnits)
	self._bathStep = 1
	self._bathUnits = bathUnits
	self._targetBathUnit = nil
	self._targetBathMO = nil
end

function M:_findUsableBath()
	self._targetBathUnit = nil
	self._targetBathMO = nil

	local unit = self:getContext():getUnit()

	for _, furnUnit in ipairs(self._bathUnits or {}) do
		if furnUnit:isEffective() then
			local uuid = furnUnit.model:getUUId()
			local furnMO = HouseFurnitureModel.instance:getFurniture(uuid)

			if furnMO and not furnMO:getUsed() then
				self._targetBathUnit = furnUnit
				self._targetBathMO = furnMO

				break
			end
		end
	end

	if self._targetBathUnit then
		self._targetBathMO:setUsed(true)
		unit.model:setStatus(PlayerStatus.Bathing)

		local posX, posY, posZ = self._targetBathUnit.perform:getTriggerPos(1)

		vec3Temp:Set(posX, posY, posZ)
		unit.navMesh:setDestination(vec3Temp)

		self._bathStep = 2
	end
end

function M:_startBathAction()
	local waitTime = 0

	if self._minWaitTime == self._maxWaitTime then
		waitTime = self._minWaitTime
	else
		waitTime = math.random(self._minWaitTime, self._maxWaitTime)
	end

	self._endTime = Time.time + waitTime + kFadeOutTime
	self._fadeOutTime = Time.time + kFadeOutTime

	local unit = self:getContext():getUnit()
	local dir = UnitDirection.Back
	local wallType = HouseSceneUtil.CoordXMapToWallType(self._targetBathMO:getCoordX())

	if wallType == WallType.Left then
		dir = UnitDirection.Left
	elseif wallType == WallType.Right then
		dir = UnitDirection.Right
	end

	unit.navMesh:setNavMeshAgentStatus(false)
	unit.navMeshMover:setStopChangeAngle(true)
	unit.navMeshMover:setDirection(dir)
	unit.meshModel:play(AnimationState.Idle, true)
	unit.material:doScreenDoorAlpha(1, 0, kFadeOutTime)

	self._unitPosX, self._unitPosY, self._unitPosZ = unit.navMesh:getNavMeshGoPos()

	if self._targetBathUnit:isEffective() then
		self._targetBathUnit.animation:play(FurnitureAnimation.Open)
	end

	self._bathStep = 3
end

function M:_endBathAction(immdeiate)
	self:_setUnitEvent(false)

	if self._targetBathUnit and self._targetBathUnit:isEffective() then
		self._targetBathUnit.animation:play(FurnitureAnimation.Close)
	end

	if self._targetBathMO then
		self._targetBathMO:setUsed(false)
	end

	local unit = self:getContext():getUnit()

	unit.model:clearStatus(PlayerStatus.Bathing)

	if self._unitPosX then
		unit.navMesh:setNavAgentPos(self._unitPosX, self._unitPosY, self._unitPosZ)
	end

	if immdeiate then
		unit.material:setScreenDoorAlpha(1)
		unit.material:setScreenDoorAlphaEnable(false)
		self:_afterFadeIn()
	else
		local dir = UnitDirection.Forward
		local wallType = HouseSceneUtil.CoordXMapToWallType(self._targetBathMO:getCoordX())

		if wallType == WallType.Left then
			dir = UnitDirection.Right
		elseif wallType == WallType.Right then
			dir = UnitDirection.Left
		end

		unit.navMeshMover:setDirection(dir)
		unit.material:doScreenDoorAlpha(0, 1, kFadeInTime)

		self._fadeInTime = Time.time + kFadeInTime
	end
end

function M:_afterFadeIn()
	self._fadeInTime = -1
	self._bathStep = 5

	local unit = self:getContext():getUnit()

	unit.navMesh:setNavMeshAgentStatus(true)
	unit.navMeshMover:setStopChangeAngle(false)
end

function M:_doPajamaAction()
	local data = self:getContext():getBehaviorData()
	local unit = self:getContext():getUnit()

	if unit.pajama:canPajama() and (data.mode == WorkStatusMode.Start or data.mode == WorkStatusMode.End) then
		unit.navMesh:setNavAgentPos(self._unitPosX, self._unitPosY, 999)
		self:_setUnitEvent(true)

		if data.mode == WorkStatusMode.Start then
			unit.pajama:setPajama(true)
		else
			unit.pajama:setPajama(false)
		end
	end
end

function M:_setUnitEvent(isOn)
	local unit = self:getContext():getUnit()

	if isOn and not self._hasAddUnitEvent then
		unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)

		self._hasAddUnitEvent = true
	elseif not isOn and self._hasAddUnitEvent then
		unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)

		self._hasAddUnitEvent = false
	end
end

function M:_onMeshModelLoaded()
	local unit = self:getContext():getUnit()

	unit.material:setScreenDoorAlphaEnable(true)
	unit.material:setScreenDoorAlpha(0)
	unit.navMesh:setNavAgentPos(self._unitPosX, self._unitPosY, self._unitPosZ)
end

function M:onReset()
	if self._bathStep > 0 then
		self:_endBathAction(true)
	end

	self:_setUnitEvent(false)
	M.super.onReset(self)

	self._endTime = 0
	self._bathStep = 0
	self._bathUnits = nil
	self._targetBathUnit = nil
	self._targetBathMO = nil
	self._fadeOutTime = -1
	self._fadeInTime = -1
	self._unitPosX = nil
	self._unitPosY = nil
	self._unitPosZ = nil
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	if self._bathStep > 0 then
		self:_endBathAction(true)
	end

	self:_setUnitEvent(false)
	M.super.onRecycle(self)

	self._endTime = 0
	self._bathStep = 0
	self._bathUnits = nil
	self._targetBathUnit = nil
	self._targetBathMO = nil
	self._fadeOutTime = -1
	self._fadeInTime = -1
	self._unitPosX = nil
	self._unitPosY = nil
	self._unitPosZ = nil
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._endTime = 0
	self._bathStep = 0
	self._bathUnits = nil
	self._targetBathUnit = nil
	self._targetBathMO = nil
	self._fadeOutTime = nil
	self._fadeInTime = nil
	self._unitPosX = nil
	self._unitPosY = nil
	self._unitPosZ = nil
end

return M
