-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIEatFood.lua

module("logic.extensions.ai.impl.action.AIEatFood", package.seeall)

local M = class("AIEatFood", AINode)
local AnimationState = HouseEnum.AnimationState
local PlayerStatus = HouseEnum.PlayerStatus
local BehaviorStatus = HouseEnum.BehaviorStatus
local kRobotRelativePosX = 0
local kRobotRelativePosY = 0.585
local kRobotRelativePosZ = 0.741
local kRobotRelativePosXTable = 0
local kRobotRelativePosYTable = 0.386
local kRobotRelativePosZTable = 0.835
local kFoodRobotPosX = 0.431
local kFoodRobotPosY = -0.764
local kFoodRobotPosZ = 0.009
local kFoodRobotRotaX = -2.562
local kFoodRobotRotaY = 257.69
local kFoodRobotRotaZ = 5.546
local kFoodRobotPosXTable = 0.427
local kFoodRobotPosYTable = -0.787
local kFoodRobotPosZTable = 0.011
local kFoodRobotRotaXTable = -1.379
local kFoodRobotRotaYTable = 257.753
local kFoodRobotRotaZTable = 5.556
local kFoodHandPosX = -0.332
local kFoodHandPosY = -0.111
local kFoodHandPosZ = -0.69
local kFoodHandRotaX = -157.358
local kFoodHandRotaY = 159.902
local kFoodHandRotaZ = 65.541
local kFoodTablePosX = 0
local kFoodTablePosY = -0.06
local kFoodTablePosZ = 1.06
local kFoodTableRotaX = 0
local kFoodTableRotaY = 180
local kFoodTableRotaZ = 0
local kRobotMoveOffsetY = 4
local kMoveTime = 2

function M:ctor(context)
	M.super.ctor(self, context)

	self._minWaitTime = 0
	self._maxWaitTime = 0
	self._endTime = 0

	self:_resetData()
end

function M:_resetData()
	self._eating = false
	self._chairUnit = nil
	self._triggerIdx = nil
	self._robotUnit = nil
	self._foodHandTakeStartTime = -1
	self._foodHandTakeCatchTime = -1
	self._foodHandTakeCompleteTime = -1
	self._putDown3CompleteTime = -1
	self._putDown2TriggerTime = -1
	self._putDown2CompleteTime = -1
	self._foodTableTakeCompleteTime = -1
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._minWaitTime = aiConfigData.minTime
	self._maxWaitTime = aiConfigData.maxTime
end

function M:onStart()
	M.super.onStart(self)

	self._eating = false

	local unit = self:getContext():getUnit()

	if self._endTime <= 0 then
		local waitTime = 0

		if self._minWaitTime == self._maxWaitTime then
			waitTime = self._minWaitTime
		else
			waitTime = math.random(self._minWaitTime, self._maxWaitTime)
		end

		if waitTime <= 0 then
			return self:onEnd(AIConst.AIStatus.SUCCESS)
		else
			self._endTime = Time.time + waitTime
		end
	end

	if Time.time >= self._endTime then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	local chairUUId = self:getContext():getEatFoodChairId()
	local zoneId = unit.navMesh:getCurZoneId()
	local roomUnit = HouseSceneUtil.getHouseRoomUnit(zoneId)

	if roomUnit then
		local chairUnit = roomUnit.furnitureMgr:getFurnitureByUUId(chairUUId)

		if chairUnit then
			local triggers = chairUnit.perform:getFreeTriggers()

			if #triggers > 0 and chairUnit.perform:hasPathToTrigger() then
				self:_startEatFoodAction(chairUnit, triggers[1])

				return self
			end
		end
	end

	return self:onEnd(AIConst.AIStatus.FAILD)
end

function M:onUpdate()
	if Time.time >= self._endTime then
		self:_endEatFoodAction()

		return self:onEnd(AIConst.AIStatus.SUCCESS)
	else
		local unit = self:getContext():getUnit()

		if self._foodHandTakeStartTime > 0 and Time.time > self._foodHandTakeStartTime then
			self._foodHandTakeStartTime = -1

			self._robotUnit.meshModel:play(AnimationState.PutDown3, false)

			self._putDown3CompleteTime = Time.time + self._robotUnit.meshModel:getAnimationDuration(AnimationState.PutDown3)
		end

		if self._foodHandTakeCatchTime > 0 and Time.time > self._foodHandTakeCatchTime then
			self._foodHandTakeCatchTime = -1

			unit.mountBinder:bindGameObject(MeshModelMount.RightHand, self._goFood)
			Astral.TransformUtil.SetLocalPos(self._goFood.transform, kFoodHandPosX, kFoodHandPosY, kFoodHandPosZ)
			Astral.TransformUtil.SetLocalRotation(self._goFood.transform, kFoodHandRotaX, kFoodHandRotaY, kFoodHandRotaZ)
		end

		if self._foodHandTakeCompleteTime > 0 and Time.time > self._foodHandTakeCompleteTime then
			self._foodHandTakeCompleteTime = -1

			unit.meshModel:play(AnimationState.FoodHand, true)
		end

		if self._putDown3CompleteTime > 0 and Time.time > self._putDown3CompleteTime then
			self._putDown3CompleteTime = -1

			self:_disappearRobot()
		end

		if self._putDown2TriggerTime > 0 and Time.time > self._putDown2TriggerTime then
			self._putDown2TriggerTime = -1

			goutil.addChildToParent(self._goFood, unit.meshModel:getInst())
			Astral.TransformUtil.SetLocalPos(self._goFood.transform, kFoodTablePosX, kFoodTablePosY, kFoodTablePosZ)
			Astral.TransformUtil.SetLocalRotation(self._goFood.transform, kFoodTableRotaX, kFoodTableRotaY, kFoodTableRotaZ)
		end

		if self._putDown2CompleteTime > 0 and Time.time > self._putDown2CompleteTime then
			self._putDown2CompleteTime = -1

			self:_disappearRobot()
			unit.meshModel:play(AnimationState.FoodTableTake, false)

			self._foodTableTakeCompleteTime = Time.time + unit.meshModel:getAnimationDuration(AnimationState.FoodTableTake)
		end

		if self._foodTableTakeCompleteTime > 0 and Time.time > self._foodTableTakeCompleteTime then
			self._foodTableTakeCompleteTime = -1

			unit.meshModel:play(AnimationState.FoodTable, true)
		end
	end

	return self
end

function M:handleEnd()
	self._endTime = 0

	self:_resetData()
	self:_setChairNotUsed()
end

function M:_setChairNotUsed()
	local chairUUId = self:getContext():getEatFoodChairId()

	if chairUUId then
		local mo = HouseFurnitureModel.instance:getFurniture(chairUUId)

		if mo then
			mo:setUsed(false)
		end
	end

	self:getContext():setEatFoodChairId(nil)
end

function M:_endEatFoodAction()
	self:_destroyFood()

	local unit = self:getContext():getUnit()

	unit.navMesh:setNavMeshAgentStatus(true)
	unit.navMeshMover:setStopChangeAngle(false)
	unit.model:clearStatus(PlayerStatus.Eating)
	unit.model:clearBehaviorStatus(BehaviorStatus.Eat)
	unit.meshModel:play(AnimationState.Idle, true)

	if self._chairUnit:isEffective() then
		self._chairUnit.perform:setTriggerUsed(self._triggerIdx, false)
	end
end

function M:_startEatFoodAction(chairUnit, triggerIdx)
	self._eating = true
	self._chairUnit = chairUnit
	self._triggerIdx = triggerIdx

	local unit = self:getContext():getUnit()

	unit.model:setStatus(PlayerStatus.Eating)
	unit.model:setBehaviorStatus(BehaviorStatus.Eat)
	unit.navMesh:setNavMeshAgentStatus(false)
	unit.navMeshMover:setStopChangeAngle(true)
	chairUnit.perform:setTriggerUsed(triggerIdx, true)

	local posX, posY, posZ = chairUnit.perform:getTriggerPos(triggerIdx)

	unit.navMesh:setNavAgentPos(posX, posY, posZ)

	local rotaX, rotaY, rotaZ, rotaW = chairUnit.perform:getTriggerRotation(triggerIdx)
	local go = unit.navMesh:getNavMeshGo()

	Astral.TransformUtil.SetRotation(go.transform, rotaX, rotaY, rotaZ, rotaW)
	unit.meshModel:play(AnimationState.Sit, true)

	self._eatWithDesk = self:_checkEatWithDesk(chairUnit)

	local foodId = HouseConfig.instance:getRandomFood(unit.heroId, self._eatWithDesk)
	local foodCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseFood, foodId)
	local foodUrl = GameUrl.getHouseMeshModelUrl(foodCO.resName)

	self._resLoader = SingleResLoader.New()

	self._resLoader:load(foodUrl, self._onFoodResLoaded, self)
end

function M:_onFoodResLoaded()
	local unit = self:getContext():getUnit()
	local dir = unit.navMeshMover:getDirection()
	local relativePosX = self._eatWithDesk and kRobotRelativePosXTable or kRobotRelativePosX
	local relativePosY = self._eatWithDesk and kRobotRelativePosYTable or kRobotRelativePosY
	local relativePosZ = self._eatWithDesk and kRobotRelativePosZTable or kRobotRelativePosZ
	local posX, posY, posZ = unit.mountRoot:getRelativeWorldPosByLocalPos(relativePosX, relativePosY, relativePosZ)
	local luaTable = {}

	luaTable.direction = dir + 180
	luaTable.flyActionName = AnimationState.Idle2
	luaTable.unitPos = {
		x = posX,
		y = posY,
		z = posZ
	}

	local roomId = unit.navMesh:getCurZoneId()
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)

	luaTable.angle = roomCO.angle
	luaTable.baseOffset = {
		z = 0,
		x = 0,
		y = 0
	}
	luaTable.moveOffset = {
		z = 0,
		x = 0,
		y = kRobotMoveOffsetY
	}
	luaTable.flyTime = kMoveTime
	luaTable.flyFinCallback = self._putdownFood
	luaTable.flyFinTarget = self
	luaTable.flyStartCallback = self._beforePutdownFood
	luaTable.flyStartTarget = self
	self._robotUnit = unit.followRobot:flyNewRobot(luaTable)
end

function M:_checkEatWithDesk(chairUnit)
	local withDesk = false
	local roomUnit = chairUnit.model:getBelongRoom()
	local gridList = roomUnit.furnitureMap:getFrontGridsByUnit(chairUnit)
	local deskUnit
	local grid = gridList[1]

	if grid then
		local unitId = grid.occupyUnitList[1]

		if unitId and unitId > 0 then
			deskUnit = roomUnit.furnitureMgr:getFurnitureUnit(unitId)
		end
	end

	local count = 0

	if deskUnit then
		for _, gridData in ipairs(gridList) do
			local unitId = gridData.occupyUnitList[1]

			if unitId and unitId == deskUnit.id then
				count = count + 1
			end
		end
	end

	if count == #gridList and count > 0 then
		local sign1 = deskUnit.model:getFoodMatchSign()
		local sign2 = chairUnit.model:getFoodMatchSign()

		if sign1 == sign2 and sign1 > 0 then
			withDesk = true
		end
	end

	return withDesk
end

function M:_destroyFood()
	if self._goFood then
		goutil.destroy(self._goFood)
	end

	self._goFood = nil

	if self._resLoader then
		self._resLoader:clear()
	end

	self._resLoader = nil
end

function M:_beforePutdownFood(robotUnit)
	self._goFood = self._resLoader:getResInstance()

	robotUnit.mountBinder:bindGameObject(MeshModelMount.RightHand, self._goFood)

	local posX = self._eatWithDesk and kFoodRobotPosXTable or kFoodRobotPosX
	local posY = self._eatWithDesk and kFoodRobotPosYTable or kFoodRobotPosY
	local posZ = self._eatWithDesk and kFoodRobotPosZTable or kFoodRobotPosZ

	Astral.TransformUtil.SetLocalPos(self._goFood.transform, posX, posY, posZ)

	local rotaX = self._eatWithDesk and kFoodRobotRotaXTable or kFoodRobotRotaX
	local rotaY = self._eatWithDesk and kFoodRobotRotaYTable or kFoodRobotRotaY
	local rotaZ = self._eatWithDesk and kFoodRobotRotaZTable or kFoodRobotRotaZ

	Astral.TransformUtil.SetLocalRotation(self._goFood.transform, rotaX, rotaY, rotaZ)
end

function M:_putdownFood()
	local unit = self:getContext():getUnit()

	if self._eatWithDesk then
		self._robotUnit.meshModel:play(AnimationState.PutDown2, false)

		self._putDown2TriggerTime = Time.time + self._robotUnit.meshModel:getAnimationEffectFrameTime(AnimationState.PutDown2, 1)
		self._putDown2CompleteTime = Time.time + self._robotUnit.meshModel:getAnimationDuration(AnimationState.PutDown2)
	else
		unit.meshModel:play(AnimationState.FoodHandTake, false)

		self._foodHandTakeStartTime = Time.time + unit.meshModel:getAnimationEffectFrameTime(AnimationState.FoodHandTake, 1)
		self._foodHandTakeCatchTime = Time.time + unit.meshModel:getAnimationEffectFrameTime(AnimationState.FoodHandTake, 2)
		self._foodHandTakeCompleteTime = Time.time + unit.meshModel:getAnimationDuration(AnimationState.FoodHandTake)
	end
end

function M:_disappearRobot()
	self._robotUnit.meshModel:play(AnimationState.Idle2, true)
	DG.Tweening.DOTween.Kill(self._robotUnit.go)
	self._robotUnit.material:doScreenDoorAlpha(1, 0, kMoveTime)

	local modelGO = self._robotUnit.meshModel:getInst()
	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:Append(modelGO.transform:DOLocalMoveY(kRobotMoveOffsetY, kMoveTime, false))
	sequence:AppendCallback(self._destroyRobot, self)
	sequence:SetTarget(self._robotUnit.go)
end

function M:_destroyRobot()
	if self._robotUnit then
		DG.Tweening.DOTween.Kill(self._robotUnit.go)
	end

	self._robotUnit = nil

	local unit = self:getContext():getUnit()

	unit.followRobot:destroyRobot()
end

function M:onReset()
	self:_setChairNotUsed()

	if self._eating then
		self:_destroyRobot()
		self:_endEatFoodAction()
	end

	M.super.onReset(self)
	self:_resetData()
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	self:_setChairNotUsed()

	if self._eating then
		self:_destroyRobot()
		self:_endEatFoodAction()
	end

	M.super.onRecycle(self)

	self._endTime = 0

	self:_resetData()
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._endTime = 0

	self:_resetData()
end

return M
