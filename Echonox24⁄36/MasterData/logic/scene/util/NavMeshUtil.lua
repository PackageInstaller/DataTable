-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/util/NavMeshUtil.lua

module("logic.scene.util.NavMeshUtil", package.seeall)

local kNavMeshPath = UnityEngine.AI.NavMeshPath.New()
local NavMeshAreas = SceneEnum.NavMeshAreas
local NORMAL_ANGLE = -60
local RADIUS = 58
local OLDX, OLDY = 0, -RADIUS

function fixMoveAngle(zoneId)
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, zoneId)

	if roomCO then
		return roomCO.angle
	end

	printWarn("小屋房间没有配置，id：", zoneId)
end

function surfaceGoNameToZoneId(surfaceName)
	local zoneId = 0
	local nameStrList = string.split(surfaceName, "_")
	local ringType = tonumber(nameStrList[2])

	if nameStrList[1] == "room" then
		zoneId = 1000 + ringType * 100 + tonumber(nameStrList[3])
	elseif nameStrList[1] == "corridor" then
		zoneId = 2000 + ringType * 100 + tonumber(nameStrList[3])
	elseif nameStrList[1] == "extraRoom" then
		zoneId = 9000 + ringType * 100 + tonumber(nameStrList[3])
	end

	return zoneId, ringType
end

function getZoneTypeByZoneId(zoneId)
	return math.floor(zoneId / 1000)
end

function getRingTypeByZoneId(zoneId)
	return math.floor(math.fmod(zoneId, 1000) / 100)
end

function calculateMoveAngle(posX, posY, areaType, zoneId)
	local angle = 0

	if NavMeshAreas.Room == areaType then
		angle = fixMoveAngle(zoneId)
	else
		angle = math.atan2(posX, -posY)
		angle = math.deg(angle)
	end

	return angle
end

function printNavMeshLine(navMeshAgent, dstPoint)
	if Astral.OSDef.isEditor then
		local navMeshPath = UnityEngine.AI.NavMeshPath.New()
		local isPath = navMeshAgent:CalculatePath(dstPoint, navMeshPath)

		if isPath then
			for i = 1, navMeshPath.corners.Length - 1 do
				UnityEngine.Debug.DrawLine(navMeshPath.corners[i - 1], navMeshPath.corners[i], Color.New(0.9, 0.1, 0.1, 255), 20)
			end
		else
			print("没有路径啦====")
		end
	end
end

function hasPath(navMesh, dstPoint, lastPointDistance)
	kNavMeshPath:ClearCorners()

	local isPath = navMesh:calculatePath(dstPoint, kNavMeshPath)

	if isPath and kNavMeshPath.status == UnityEngine.AI.NavMeshPathStatus.PathComplete then
		if lastPointDistance then
			local idx = kNavMeshPath.corners.Length - 1
			local lastPoint = kNavMeshPath.corners[idx]
			local distance = Vector3.Distance(dstPoint, lastPoint)

			return distance < lastPointDistance
		else
			return true
		end
	end

	return false
end
