-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/util/HouseSceneUtil.lua

module("logic.extensions.house.util.HouseSceneUtil", package.seeall)

local HouseSceneUtil = {}
local RoomType = HouseEnum.RoomType
local WorkStatus = HouseEnum.WorkStatus
local WorkType = HouseEnum.WorkType
local BehaviorStatus = HouseEnum.BehaviorStatus
local BehaviorType = HouseEnum.BehaviorType
local RingType = HouseEnum.RingType
local LivingRoomType = HouseEnum.LivingRoomType
local vec3Temp = Vector3.New()
local vec3Temp2 = Vector3.New()

HouseSceneUtil.WorkStatusToBehaviorTypes = {
	[WorkStatus.Sleep] = {
		BehaviorType.SleepBH_1,
		BehaviorType.SleepBH_2,
		BehaviorType.SleepBH_3
	},
	[WorkStatus.Eat] = {
		BehaviorType.EatBaseBH,
		BehaviorType.EatBH_1,
		BehaviorType.EatBH_2
	},
	[WorkStatus.Rest] = {
		BehaviorType.RestBaseBH,
		BehaviorType.RestBH_1
	},
	[WorkStatus.Work] = {
		[WorkType.Supervisor] = {
			BehaviorType.WorkSupervisorBaseBH,
			BehaviorType.WorkSupervisorBH_1
		},
		[WorkType.Trading] = {
			BehaviorType.WorkTradingBaseBH,
			BehaviorType.WorkTradingBH_1,
			BehaviorType.WorkTradingBH_2,
			BehaviorType.WorkTradingBH_3
		},
		[WorkType.Manufacturing] = {
			BehaviorType.WorkManufacturBaseBH,
			BehaviorType.WorkManufacturBH_1
		},
		[WorkType.Shelter] = {
			BehaviorType.WorkShelterBaseBH,
			BehaviorType.WorkShelterBH_1,
			BehaviorType.WorkShelterBH_2
		}
	}
}

function HouseSceneUtil.calculCirclePos(radius, angle)
	local posX = math.cos(math.rad(angle - 90)) * radius
	local posY = math.sin(math.rad(angle - 90)) * radius

	return posX, posY
end

function HouseSceneUtil.getPosByScreenOffset(posX, posY, angle, screenOffsetX, screenOffsetY)
	local A = math.cos(math.rad(angle))
	local B = math.sin(math.rad(angle))
	local screenPosX = posX * A + posY * B
	local screenPosY = posY * A - posX * B

	screenPosX = screenPosX + screenOffsetX
	screenPosY = screenPosY + screenOffsetY

	local resultPosX = (A * screenPosX - B * screenPosY) / (A * A + B * B)
	local resultPosY = (B * screenPosX + A * screenPosY) / (A * A + B * B)

	return resultPosX, resultPosY
end

function HouseSceneUtil.getRoomIdBySchedule(scheduleData)
	local hour = ServerTime.nowDateServerLook().hour
	local curWorkStatus = scheduleData.schedule[hour + 1]

	if not curWorkStatus then
		local schedule = HouseConfig.instance:getHouseConst(string.format("defaultSchedule%s", scheduleData.index)).numValues

		curWorkStatus = schedule[hour + 1]
	end

	local workCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, scheduleData.job)
	local roomId, bornRoomId = HouseSceneUtil.getRoomIdByWorkStatus(scheduleData.hero, curWorkStatus, workCO.workType, scheduleData)

	return roomId, curWorkStatus, bornRoomId
end

function HouseSceneUtil.getRoomIdByWorkStatus(heroId, workStatus, workType, scheduleData)
	local dormitoryRoomId
	local zoneMO = LivingFacilitiesZoneController.instance:findZoneByHeroId(heroId)

	if zoneMO then
		dormitoryRoomId = zoneMO:getId()
	else
		dormitoryRoomId = HouseSceneUtil.getRandomLivingRoomId()
	end

	local scheduleRoomId, bornRoomId

	if workStatus == WorkStatus.Work then
		if workType == WorkType.Supervisor then
			scheduleRoomId = HouseEnum.SUPERVISOR_ROOM_ID
			bornRoomId = scheduleRoomId
		elseif workType == WorkType.Trading then
			scheduleRoomId = HouseEnum.TRADING_ROOM_ID

			local ids = {
				HouseEnum.SUPERVISOR_ROOM_ID,
				HouseEnum.TRADING_ROOM_ID,
				HouseEnum.MANUFACTURE_ROOM_ID
			}

			bornRoomId = ids[math.random(1, #ids)]
		elseif workType == WorkType.Manufacturing then
			scheduleRoomId = HouseEnum.MANUFACTURE_ROOM_ID
			bornRoomId = scheduleRoomId
		elseif workType == WorkType.Shelter then
			local cfgWork

			if scheduleData then
				cfgWork = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, scheduleData.job)
			end

			scheduleRoomId = cfgWork and cfgWork.zoneId or 1101
			bornRoomId = scheduleRoomId
		end
	elseif workStatus == WorkStatus.Sleep then
		scheduleRoomId = dormitoryRoomId
		bornRoomId = scheduleRoomId
	elseif workStatus == WorkStatus.Eat then
		scheduleRoomId = dormitoryRoomId
		bornRoomId = scheduleRoomId
	elseif workStatus == WorkStatus.Rest then
		scheduleRoomId = dormitoryRoomId
		bornRoomId = scheduleRoomId
	end

	return scheduleRoomId, bornRoomId
end

function HouseSceneUtil.getWorkStatusByHeroId(heroId)
	local scheduleNO = HouseWorkerModel.instance:getScheduleByHeroId(heroId)
	local timeInfo = ServerTime.nowDateServerLook()
	local workStatus = scheduleNO.schedule[timeInfo.hour + 1]

	return workStatus
end

function HouseSceneUtil.getCamFOV(fov)
	local designWidth = 1624
	local designHeight = 750
	local width = UnityEngine.Screen.width
	local height = UnityEngine.Screen.height
	local rate = designWidth * height / (width * designHeight)

	fov = fov or HouseEnum.DEFAULT_FOV

	return fov * rate
end

function HouseSceneUtil.getRandomLivingRoomId()
	local roomIds = {}
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.roomMgr then
		local roomUnits = curScene.roomMgr:getUnitDict()

		for roomId, roomUnit in pairs(roomUnits) do
			if roomUnit.model:getRoomType() == RoomType.Living then
				table.insert(roomIds, roomId)
			end
		end
	end

	if #roomIds > 0 then
		return roomIds[math.random(1, #roomIds)]
	end
end

function HouseSceneUtil.findRestRoomId(heroId)
	local occupyDict = HouseSceneUtil.getRoomOccupyData()
	local maxMemberCount = 4
	local roomIds = {
		{},
		{},
		{},
		{},
		{}
	}
	local zoneList = LivingFacilitiesZoneModel.instance:getZoneList()

	for _, zoneMO in ipairs(zoneList) do
		local id = zoneMO:getId()
		local type = zoneMO:getType()

		if maxMemberCount > checknumber(occupyDict[id]) then
			if zoneMO:getIsActive() then
				if type == LivingRoomType.Dormitory then
					table.insert(roomIds[3], id)
				elseif type == LivingRoomType.PrivateDormitory then
					table.insert(roomIds[4], id)
				elseif type == LivingRoomType.SpecialDormitory then
					table.insert(roomIds[5], id)
				else
					table.insert(roomIds[1], id)
				end
			else
				table.insert(roomIds[2], id)
			end
		end
	end

	for i, ids in ipairs(roomIds) do
		if #ids > 0 then
			if i == 1 then
				local datas = {}
				local totalWeight = 0

				for _, id in ipairs(ids) do
					local mo = LivingFacilitiesZoneModel.instance:getZoneById(id)
					local weight = HouseConfig.instance:getHeroLivingRoomWeight(heroId, mo:getType())
					local data = {}

					data.id = id
					data.weight = weight

					table.insert(datas, data)

					totalWeight = totalWeight + weight
				end

				local randomNum = math.random(1, totalWeight)
				local calculWeight = 0

				for _, data in ipairs(datas) do
					calculWeight = calculWeight + data.weight

					if randomNum <= calculWeight then
						return data.id
					end
				end
			else
				return ids[math.random(1, #ids)]
			end
		end
	end

	local zone = zoneList[math.random(1, #zoneList)]

	printWarn("所有已解锁的生活设施都被占满了！随机选一个休息目的地", zone:getId())

	return zone:getId()
end

function HouseSceneUtil.getRoomOccupyData()
	local occupyDict = {}

	local function _addOccupyData(roomId)
		if roomId then
			if occupyDict[roomId] == nil then
				occupyDict[roomId] = 1
			else
				occupyDict[roomId] = occupyDict[roomId] + 1
			end
		end
	end

	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	if curSceneFlow and curSceneFlow.unitMgr then
		local unitDict = curSceneFlow.unitMgr:getUnitDict()

		for _, unit in pairs(unitDict) do
			_addOccupyData(unit.model:getOccupyRoom())
		end
	end

	return occupyDict
end

function HouseSceneUtil.getBehaviorsByWorkType(workType)
	local behaviors = {}

	for status, behaviorList in pairs(HouseSceneUtil.WorkStatusToBehaviorTypes) do
		if status ~= WorkStatus.Work then
			for _, bh in ipairs(behaviorList) do
				table.insert(behaviors, bh)
			end
		end
	end

	local map = HouseSceneUtil.WorkStatusToBehaviorTypes[WorkStatus.Work]

	for _, bh in ipairs(map[workType]) do
		table.insert(behaviors, bh)
	end

	return behaviors
end

function HouseSceneUtil.getWorkStatusByBehavior(behavior)
	for status, behaviorList in pairs(HouseSceneUtil.WorkStatusToBehaviorTypes) do
		if table.indexof(behaviorList, behavior) then
			return status, nil
		end
	end

	for type, behaviorList in pairs(HouseSceneUtil.WorkStatusToBehaviorTypes[WorkStatus.Work]) do
		if table.indexof(behaviorList, behavior) then
			return WorkStatus.Work, type
		end
	end
end

function HouseSceneUtil.getNearestElevatorId(pos, ringType, targetZoneId, withQueue)
	local allElevatorCOs = HouseConfig.instance:getConfigList(ConfigName.Elevator)
	local elevatorId
	local minDis = 999999
	local elevatorUnit
	local filterElevatorCOs = {}

	if targetZoneId and targetZoneId > 0 then
		local COs = HouseSceneUtil.getElevatorsWithZone(targetZoneId)

		for _, co in ipairs(COs) do
			local filterCO = HouseSceneUtil.getElevatorInSameCol(co.id, ringType)

			if filterCO then
				table.insert(filterElevatorCOs, filterCO)
			end
		end
	end

	local elevatorCOs = #filterElevatorCOs > 0 and filterElevatorCOs or allElevatorCOs

	for _, elevatorCO in ipairs(elevatorCOs) do
		if elevatorCO.ringType == ringType then
			local elevatorLevelUnit = HouseSceneUtil.getElevatorUnit(elevatorCO.id)

			if elevatorLevelUnit and (withQueue and not elevatorLevelUnit.lineMgr:isWaitQueueFull() or not withQueue) then
				local elePosX, elePosY, elePosZ = elevatorLevelUnit:getPos()
				local distance = math.pow(pos.x - elePosX, 2) + math.pow(pos.y - elePosY, 2)

				if distance < minDis then
					minDis = distance
					elevatorUnit = elevatorLevelUnit
					elevatorId = elevatorCO.id
				end
			end
		end
	end

	return elevatorId, elevatorUnit
end

function HouseSceneUtil.getElevatorUnit(id)
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.unitFactory then
		return curScene.unitFactory:getElevatorUnit(checknumber(id))
	end
end

function HouseSceneUtil.getElevatorsWithZone(zoneId)
	local elevatorCOList = {}
	local ringType = NavMeshUtil.getRingTypeByZoneId(zoneId)
	local allElevatorCOs = HouseConfig.instance:getConfigList(ConfigName.Elevator)

	for _, elevatorCO in ipairs(allElevatorCOs) do
		if elevatorCO.ringType == ringType then
			local conectRooms = elevatorCO.conectRoom

			if not conectRooms then
				table.insert(elevatorCOList, elevatorCO)
			elseif table.indexof(conectRooms, zoneId) then
				table.insert(elevatorCOList, elevatorCO)
			end
		end
	end

	return elevatorCOList
end

function HouseSceneUtil.getElevatorInSameCol(elevatorId, ringType)
	local elevatorLevelCo = HouseConfig.instance:getElevatorCoById(elevatorId)
	local elevatorLobbyId = elevatorLevelCo.levelId[1]
	local elevatorLobbyCo = HouseConfig.instance:getElevatorCoById(elevatorLobbyId)
	local levelIds = elevatorLobbyCo.levelId
	local targetEleId = checknumber(levelIds[ringType])

	if targetEleId > 0 and targetEleId ~= elevatorId then
		return HouseConfig.instance:getElevatorCoById(targetEleId)
	end
end

function HouseSceneUtil.adjustRingType(elevatorId, ringType)
	local adjustRingType
	local distance = 99
	local elevatorLevelCo = HouseConfig.instance:getElevatorCoById(elevatorId)
	local elevatorLobbyId = elevatorLevelCo.levelId[1]
	local elevatorLobbyCo = HouseConfig.instance:getElevatorCoById(elevatorLobbyId)
	local levelIds = elevatorLobbyCo.levelId

	for i, levelId in ipairs(levelIds) do
		if levelId > 0 and levelId ~= elevatorId then
			local co = HouseConfig.instance:getElevatorCoById(levelId)
			local tempDis = math.abs(co.ringType - ringType)

			if tempDis < distance then
				adjustRingType = co.ringType
				distance = tempDis
			end
		end
	end

	return adjustRingType
end

function HouseSceneUtil.canWalkToTargetZone(curZoneId, targetZoneId)
	local curRingType = NavMeshUtil.getRingTypeByZoneId(curZoneId)
	local targetRingType = NavMeshUtil.getRingTypeByZoneId(targetZoneId)

	if curRingType == targetRingType then
		local allElevatorCOs = HouseConfig.instance:getConfigList(ConfigName.Elevator)

		for _, elevatorCO in ipairs(allElevatorCOs) do
			if elevatorCO.ringType == targetRingType then
				local conectRooms = elevatorCO.conectRoom

				if not conectRooms then
					return true
				elseif table.indexof(conectRooms, targetZoneId) and table.indexof(conectRooms, curZoneId) then
					return true
				end
			end
		end
	end

	return false
end

function HouseSceneUtil.getRandomRoomPos(zoneId)
	local mo = HouseNavigationModel.instance:getMOByZoneId(zoneId)

	if mo then
		return mo:getRandomPoint()
	end
end

function HouseSceneUtil.getNearestProSuitPoint(elevatorId, unitPos)
	local curScene = SceneMgr.instance:getCurScene()
	local houseRootGo = curScene.stage:getHouseRootGo()
	local roomUnits = curScene.roomMgr:getUnitsByType(RoomType.Shelter)
	local suitPosList = {}

	for _, roomUnit in ipairs(roomUnits) do
		local leftElevatorId, leftSuitPos = roomUnit.model:getLeftElevatorAndSuit()

		if leftElevatorId == elevatorId then
			table.insert(suitPosList, leftSuitPos)
		end

		local rightElevatorId, rightSuitPos = roomUnit.model:getRightElevatorAndSuit()

		if rightElevatorId == elevatorId then
			table.insert(suitPosList, rightSuitPos)
		end
	end

	local minDis = 999999
	local targetSuitPos

	for _, suitPos in ipairs(suitPosList) do
		local distance = math.pow(unitPos.x - suitPos.x, 2) + math.pow(unitPos.y - suitPos.y, 2)

		if distance < minDis then
			minDis = distance
			targetSuitPos = suitPos
		end
	end

	return targetSuitPos
end

function HouseSceneUtil.getReturnGoodsRoomId(workType)
	if workType == WorkType.Shelter then
		return 1203
	end
end

function HouseSceneUtil.worldPosToScreenPos(angle, posX, posY)
	local A = math.cos(math.rad(angle))
	local B = math.sin(math.rad(angle))
	local screenPosX = posX * A + posY * B
	local screenPosY = posY * A - posX * B

	return screenPosX, screenPosY
end

function HouseSceneUtil.screenPosToWorldPos(angle, screenPosX, screenPosY)
	local A = math.cos(math.rad(angle))
	local B = math.sin(math.rad(angle))
	local pow = A * A + B * B
	local posX = (A * screenPosX - B * screenPosY) / pow
	local posY = (B * screenPosX + A * screenPosY) / pow

	return posX, posY
end

function HouseSceneUtil.worldPosByScreenOffset(angle, posX, posY, offsetScreenX, offsetScreenY)
	local A = math.cos(math.rad(angle))
	local B = math.sin(math.rad(angle))
	local screenPosX = posX * A + posY * B
	local screenPosY = posY * A - posX * B

	screenPosX = screenPosX + offsetScreenX
	screenPosY = screenPosY + offsetScreenY

	local pow = A * A + B * B

	posX = (A * screenPosX - B * screenPosY) / pow
	posY = (B * screenPosX + A * screenPosY) / pow

	return posX, posY
end

function HouseSceneUtil.getHousePlayerUnit(heroId)
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	if curSceneFlow and curSceneFlow.unitMgr then
		local unitDict = curSceneFlow.unitMgr:getUnitDict()

		return unitDict[heroId]
	end
end

function HouseSceneUtil.getMainPlayer()
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.getMainPlayer then
		local mainPlayer = curScene:getMainPlayer()

		return mainPlayer
	end
end

function HouseSceneUtil.getPlayersByZoneId(zoneId)
	local units = {}
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	if curSceneFlow and curSceneFlow.unitMgr then
		local unitDict = curSceneFlow.unitMgr:getUnitDict()

		for _, unit in pairs(unitDict) do
			if unit.navMesh:getCurZoneId() == zoneId and not unit.navMesh:getIsManualWalk() then
				table.insert(units, unit)
			end
		end
	end

	return units
end

function HouseSceneUtil.hasNeighborInRange(targetUnit, range)
	if not targetUnit.navMesh:getIsManualWalk() then
		local curSceneFlow = SceneFace.instance:getCurSceneFlow()

		if curSceneFlow and curSceneFlow.unitMgr then
			local unitDict = curSceneFlow.unitMgr:getUnitDict()

			for _, unit in pairs(unitDict) do
				if unit ~= targetUnit and unit.navMesh:getCurZoneId() == targetUnit.navMesh:getCurZoneId() and range >= HouseSceneUtil.getDistanceBetweenUnits(unit, targetUnit) then
					return true
				end
			end
		end
	end

	return false
end

function HouseSceneUtil.getDistanceBetweenUnits(unit1, unit2)
	vec3Temp:Set(unit1.navMesh:getNavMeshGoPos())
	vec3Temp2:Set(unit2.navMesh:getNavMeshGoPos())

	return Vector3.Distance(vec3Temp, vec3Temp2)
end

function HouseSceneUtil.getHouseRoomUnit(roomId)
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.roomMgr then
		return curScene.roomMgr:getUnitById(roomId)
	end
end

function HouseSceneUtil.isPlayerInRoomWithType(unit, roomTypes)
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.roomMgr then
		local zoneId = unit.navMesh:getCurZoneId()
		local roomUnit = curScene.roomMgr:getUnitById(zoneId)

		if roomUnit and table.indexof(roomTypes, roomUnit.model:getRoomType()) then
			return true
		end
	end

	return false
end

function HouseSceneUtil.getZoneName(unit)
	if unit then
		local zoneId = unit.navMesh:getCurZoneId()
		local zoneType = NavMeshUtil.getZoneTypeByZoneId(zoneId)

		if zoneType == HouseEnum.ZoneType.Room then
			return HouseMainUtil.getRoomName(zoneId)
		end

		if unit.model:judgeBehaviorStatus(BehaviorStatus.Elevator) then
			return lang("tip_elevator")
		end

		return lang("tip_corridor")
	end
end

function HouseSceneUtil.CoordXMapToWallType(coordX)
	return math.floor(coordX / 100)
end

function HouseSceneUtil.adjustCoordWithFix(furnitureId, coordX, coordY)
	local CO = BackpackConfig.instance:getItemInfoByItemId(furnitureId)
	local fixCoord = CO.fixCoord

	if not string.nilorempty(fixCoord) then
		local strList = string.split(fixCoord, "#")
		local type = tonumber(strList[1])
		local value = tonumber(strList[2])

		if type == 1 then
			coordY = value
		elseif type == 2 then
			coordX = value
		end
	end

	return coordX, coordY
end

function HouseSceneUtil.getPaperIdByFurniture(furnitureId)
	local cfgList = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.DrawingItemType)

	for _, cfg in ipairs(cfgList) do
		if cfg.furniture == furnitureId then
			return cfg.id
		end
	end
end

function HouseSceneUtil.isDormitoryRoom(roomType)
	local dormitoryTypes = {
		LivingRoomType.Dormitory,
		LivingRoomType.PrivateDormitory,
		LivingRoomType.SpecialDormitory
	}

	if table.indexof(dormitoryTypes, roomType) then
		return true
	end

	return false
end

function HouseSceneUtil.isSingleDormitoryRoom(roomType)
	local dormitoryTypes = {
		LivingRoomType.PrivateDormitory,
		LivingRoomType.SpecialDormitory
	}

	if table.indexof(dormitoryTypes, roomType) then
		return true
	end

	return false
end

function HouseSceneUtil.isMultiDormitoryRoom(roomType)
	local dormitoryTypes = {
		LivingRoomType.Dormitory
	}

	if table.indexof(dormitoryTypes, roomType) then
		return true
	end

	return false
end

function HouseSceneUtil.getNormalMeshUrl(heroId)
	local entityCO = BattleConfigUtil.getEntityConfig(heroId)
	local modelCO = ModelConfig.instance:getModelConfig(entityCO.modelId)

	return GameUrl.getHouseMeshModelUrl(modelCO.houseResName), modelCO
end

function HouseSceneUtil.getPajamaMeshUrl(heroId)
	local entityCO = BattleConfigUtil.getEntityConfig(heroId)
	local modelCO = ModelConfig.instance:getModelConfig(entityCO.modelId)

	return GameUrl.getHousePajamaMeshModelUrl(modelCO.houseResName), modelCO
end

function HouseSceneUtil.playersRoomHasBath(heroId)
	local zoneMO, bunkInfo = LivingFacilitiesZoneController.instance:findZoneByHeroId(heroId)

	if zoneMO then
		local furnMOs = HouseFurnitureModel.instance:getRoomFurnitures(zoneMO:getId())

		for _, furnMO in ipairs(furnMOs) do
			if furnMO:isBathRoom() then
				return true
			end
		end
	end

	return false
end

function HouseSceneUtil.isHeroInActiveZone(heroUnit)
	local zoneId = heroUnit.navMesh:getCurZoneId()
	local zoneType = NavMeshUtil.getZoneTypeByZoneId(zoneId)

	if zoneType == HouseEnum.ZoneType.Room then
		local openTyp = HouseMainRoomModel.instance:getRoomOpenTyp(zoneId)

		if openTyp ~= HouseMainEnum.RoomOpenTyp.OpenActive then
			return false
		end
	end

	return true
end

function HouseSceneUtil.filterUsefulBathRoomByUnits(furnUnits)
	local bathUnits = {}

	for _, furnUnit in pairs(furnUnits) do
		if furnUnit.model:isBathRoom() and furnUnit.perform:hasPathToTrigger() then
			table.insert(bathUnits, furnUnit)
		end
	end

	return bathUnits
end

function HouseSceneUtil.getIdxByWeights(weights)
	local totalWeight = 0

	for i = 1, #weights do
		totalWeight = totalWeight + weights[i]
	end

	local randomNum = math.random(1, totalWeight)
	local calculWeight = 0

	for idx, weight in ipairs(weights) do
		calculWeight = calculWeight + weight

		if randomNum <= calculWeight then
			return idx
		end
	end
end

function HouseSceneUtil.adjustUnitAngle(angle, rotaX, rotaY, rotaZ, dirAngle)
	local roll = Quaternion.Euler(0, 0, angle)
	local curRotation = Quaternion.Euler(rotaX, rotaY, rotaZ)
	local rotate = Quaternion.Inverse(roll) * curRotation
	local euler = rotate.eulerAngles

	dirAngle = dirAngle or euler.y

	local adjustRotation = roll * Quaternion.Euler(0, dirAngle, 0)
	local angles = adjustRotation.eulerAngles

	return angles.x, angles.y, angles.z
end

function HouseSceneUtil.getUnitAngleByPos(angle, posX, posY, posZ, childPosX, childPosY, childPosZ)
	local roll = Quaternion.Euler(0, 0, angle)
	local offsetPos = Vector3.New(childPosX, childPosY, childPosZ) - Vector3.New(posX, posY, posZ)

	offsetPos = Quaternion.Inverse(roll) * offsetPos

	local deg = math.deg(math.atan2(offsetPos.x, offsetPos.z))
	local curRotation = Quaternion.Euler(0, deg, 0)
	local angles = (roll * curRotation).eulerAngles

	return angles.x, angles.y, angles.z
end

function HouseSceneUtil.getUnitDirAngle(angle, rotaX, rotaY, rotaZ)
	local roll = Quaternion.Euler(0, 0, angle)
	local curRotation = Quaternion.Euler(rotaX, rotaY, rotaZ)
	local rotate = Quaternion.Inverse(roll) * curRotation
	local euler = rotate.eulerAngles

	return euler.y
end

function HouseSceneUtil.getUnitAngleOffset(angle, rotaX, rotaY, rotaZ)
	local roll = Quaternion.Euler(0, 0, angle)
	local curRotation = Quaternion.Euler(rotaX, rotaY, rotaZ)
	local rotate = Quaternion.Inverse(roll) * curRotation
	local euler = rotate.eulerAngles
	local offset = math.abs(euler.z)
	local yaw = Quaternion.Euler(0, euler.y, 0)
	local targetRotation = (roll * yaw).eulerAngles

	return offset, targetRotation.x, targetRotation.y, targetRotation.z
end

return HouseSceneUtil
