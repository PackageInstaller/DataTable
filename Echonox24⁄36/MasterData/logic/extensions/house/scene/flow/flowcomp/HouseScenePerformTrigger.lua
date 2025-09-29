-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/flow/flowcomp/HouseScenePerformTrigger.lua

module("logic.extensions.house.scene.flow.flowcomp.HouseScenePerformTrigger", package.seeall)

local M = class("HouseScenePerformTrigger", ISceneFlowComp)
local kFindDoubleCtrlInterval = 1
local kFindDoubleCtrlMultiNum = 0.9

function M:onEnterDone()
	self._vec3Temp = Vector3.New()
	self._showOnePerformTimer = SchedulerCtrl.New(self._showOnePerform, self)
	self._findDoubleCtrlTimer = SchedulerCtrl.New(self._findAllDoublePerformCtrl, self)

	self._findDoubleCtrlTimer:restart(kFindDoubleCtrlInterval, true)

	self._dictDoublePerformCtrl = {}
	self._dictSinglePerformCtrl = {}
	self._mainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()

	self:_rollOnePerformance()
	HouseDispatcher:addEventListener(HouseEventType.REMOVE_HERO_UNIT, self._onRemoveUnit, self)
end

function M:onExit()
	HouseDispatcher:removeEventListener(HouseEventType.REMOVE_HERO_UNIT, self._onRemoveUnit, self)
	self._showOnePerformTimer:clear()

	self._showOnePerformTimer = nil

	self._findDoubleCtrlTimer:clear()

	self._findDoubleCtrlTimer = nil

	for id, doubleCtrl in pairs(self._dictDoublePerformCtrl) do
		doubleCtrl:clear()
	end

	table.clear(self._dictDoublePerformCtrl)

	for id, singleCtrl in pairs(self._dictSinglePerformCtrl) do
		singleCtrl:clear()
	end

	table.clear(self._dictSinglePerformCtrl)

	self._vec3Temp = nil
	self._mainCamera = false
end

function M:_rollOnePerformance()
	local intervalStr = HouseConfig.instance:getHouseConst("PerformRollInterval")
	local intervalList = string.split(intervalStr.strValue, "#")
	local time = math.random(tonumber(intervalList[1]), tonumber(intervalList[2]))

	self._showOnePerformTimer:restart(time, false)
end

function M:_showOnePerform()
	if not HouseFacade.instance:isEditingFurniture() then
		local range = HouseConfig.instance:getHouseConst("PerformSearchRange")
		local multiNum = range.numValue * 2 / UnityEngine.Screen.width
		local units = self:_findUnitsInScreen(multiNum)
		local dictCtrl = {}

		for _, unit in ipairs(units) do
			local canPerf, ctrl = self:_canUnitPerform(unit)

			if canPerf then
				dictCtrl[ctrl:getId()] = ctrl
			end
		end

		local ctrls = {}

		for _, ctrl in pairs(dictCtrl) do
			table.insert(ctrls, ctrl)
		end

		if #ctrls > 0 then
			local runCtrl = ctrls[math.random(1, #ctrls)]

			runCtrl:showPerformance()
		end
	end

	self:_rollOnePerformance()
end

function M:_canUnitPerform(unit)
	local runningCtrl = unit.performCtrl:getRunningCtrl()

	if runningCtrl then
		if runningCtrl:getCtrlType() == HouseEnum.PerformCtrlType.Double and runningCtrl:canPerform() then
			return true, runningCtrl
		else
			return false
		end
	elseif HousePerformUtil.canUnitTriggerPerform(unit, true) then
		local singleCtrl = self:_getOrCreateSingleCtrl(unit)

		if singleCtrl:canPerform() then
			local COs = singleCtrl:reFindAllUsablePerformCO()

			if #COs > 0 then
				return true, singleCtrl
			end
		end
	end

	return false
end

function M:_findAllDoublePerformCtrl()
	if not HouseFacade.instance:isEditingFurniture() then
		local units = self:_findUnitsInScreen(kFindDoubleCtrlMultiNum)
		local unitsNum = #units

		if unitsNum > 1 then
			for i = 1, unitsNum - 1 do
				for j = i + 1, unitsNum do
					local unitA = units[i]
					local unitB = units[j]
					local unitAUnableTrigger = self:_tryTriggerDoublePerform(unitA, unitB)

					if unitAUnableTrigger then
						break
					end
				end
			end
		end
	end
end

function M:_canUnitTriggerDouble(unit)
	local canPerform = HousePerformUtil.canUnitTriggerPerform(unit)
	local enableContact = unit.performCtrl:enableContact()

	return canPerform and enableContact
end

function M:_conditionOfUnits(unitA, unitB)
	local canTrigger = false

	if unitA.navMesh:getCurZoneId() == unitB.navMesh:getCurZoneId() then
		canTrigger = true
	end

	if canTrigger and NavMeshUtil.getZoneTypeByZoneId(unitA.navMesh:getCurZoneId()) == HouseEnum.ZoneType.Room then
		local offset = unitA.go.transform:InverseTransformPoint(unitB.navMesh:getNavMeshGo().transform.position)

		canTrigger = math.abs(offset.y) < 0.1
	end

	return canTrigger
end

function M:_tryTriggerDoublePerform(unitA, unitB)
	local doubleCtrl = self:_getOrCreateDoubleCtrl(unitA, unitB)
	local enableCondition = self:_conditionOfUnits(unitA, unitB)
	local aCanTrigger = self:_canUnitTriggerDouble(unitA)
	local bCanTrigger = self:_canUnitTriggerDouble(unitB)

	if enableCondition and aCanTrigger and bCanTrigger and doubleCtrl:getContactStatus() == HouseEnum.ContactStatus.None then
		local unitAPosX, unitAPosY, unitAPosZ = unitA.navMesh:getNavMeshGoPos()
		local unitBPosX, unitBPosY, unitBPosZ = unitB.navMesh:getNavMeshGoPos()
		local distance = HouseConfig.instance:getHouseConst("ContactDistance")
		local disPow = math.pow(unitAPosX - unitBPosX, 2) + math.pow(unitAPosY - unitBPosY, 2) + math.pow(unitAPosZ - unitBPosZ, 2)

		if disPow < math.pow(distance.numValue, 2) then
			doubleCtrl:tryTrigger()
		end
	end

	return not aCanTrigger
end

function M:_findUnitsInScreen(multiNum)
	local unitList = self._flow.unitMgr:getAllUnit()
	local units = {}

	for _, unit in ipairs(unitList) do
		self._vec3Temp:Set(unit.navMesh:getNavMeshGoPos())

		local inScreen = self:_judgePosInScreen(self._vec3Temp, multiNum)

		if inScreen then
			table.insert(units, unit)
		end
	end

	return units
end

function M:_judgePosInScreen(worldPos, multiNum)
	local screenPos = self._mainCamera:WorldToScreenPoint(worldPos)
	local screenWidth = UnityEngine.Screen.width
	local screenHeight = UnityEngine.Screen.height
	local minEdgeX = 0 - (multiNum - 1) * screenWidth / 2
	local maxEdgeX = screenWidth + (multiNum - 1) * screenWidth / 2
	local minEdgeY = 0
	local maxEdgeY = screenHeight

	return minEdgeX < screenPos.x and maxEdgeX > screenPos.x and minEdgeY < screenPos.y and maxEdgeY > screenPos.y
end

function M:_getOrCreateDoubleCtrl(unitA, unitB)
	local ctrlId = HousePerformCtrl.createId(unitA.heroId, unitB.heroId)
	local doubleCtrl = self._dictDoublePerformCtrl[ctrlId]

	if not doubleCtrl then
		doubleCtrl = HouseDoublePerformCtrl.New()

		doubleCtrl:setId(ctrlId)

		self._dictDoublePerformCtrl[ctrlId] = doubleCtrl
	end

	doubleCtrl:setPerformUnits(unitA, unitB)

	return doubleCtrl
end

function M:_getOrCreateSingleCtrl(unit)
	local ctrlId = HousePerformCtrl.createId(unit.heroId)
	local singleCtrl = self._dictSinglePerformCtrl[ctrlId]

	if not singleCtrl then
		singleCtrl = HouseSinglePerformCtrl.New()

		singleCtrl:setId(ctrlId)

		self._dictSinglePerformCtrl[ctrlId] = singleCtrl
	end

	singleCtrl:setPerformUnits(unit)

	return singleCtrl
end

function M:_onRemoveUnit(e, unitId, heroId)
	for ctrlId, doubleCtrl in pairs(self._dictDoublePerformCtrl) do
		if doubleCtrl:containHero(heroId) then
			doubleCtrl:clear()

			self._dictDoublePerformCtrl[ctrlId] = nil
		end
	end

	for ctrlId, singleCtrl in pairs(self._dictSinglePerformCtrl) do
		if singleCtrl:containHero(heroId) then
			singleCtrl:clear()

			self._dictSinglePerformCtrl[ctrlId] = nil
		end
	end
end

return M
