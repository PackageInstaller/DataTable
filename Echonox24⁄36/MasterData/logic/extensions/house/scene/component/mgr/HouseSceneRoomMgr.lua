-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/component/mgr/HouseSceneRoomMgr.lua

module("logic.extensions.house.scene.component.mgr.HouseSceneRoomMgr", package.seeall)

local M = class("HouseSceneRoomMgr", SceneComponentBase)
local RoomType = HouseEnum.RoomType
local ROOM_TYPE_TO_UNIT_CLS = {
	[0] = HouseRoomUnit,
	[RoomType.Supervisor] = SupervisorRoomUnit,
	[RoomType.Trading] = TradingRoomUnit,
	[RoomType.Manufacturing] = ManufactureRoomUnit,
	[RoomType.Shelter] = ShelterRoomUnit,
	[RoomType.Living] = LivingRoomUnit
}
local ALL_ROOM_ROOT_PATH = "trigger/house_root_trigger/all_room"
local kRecordShelterRoomId = 9001
local kSmallLivingRoomId = 9002
local kBigLivingRoomId = 9003

function M:onInit()
	self._dictRoomUnit = {}
	self._dictRoomResLoader = {}
	self._dictRoomResData = {}
	self._dictRoomRetainCount = {}
	self._dictExtraRoom = {}
	self._recordShelterRoomUnit = nil
end

function M:onExitScene()
	LivingRoomFurnitureUtil.instance:interrupt()
	self:removeAllRoom()
	table.clear(self._dictRoomResData)
	table.clear(self._dictRoomRetainCount)
	table.clear(self._dictExtraRoom)

	for _, resLoader in pairs(self._dictRoomResLoader) do
		resLoader:clear()
	end

	table.clear(self._dictRoomResLoader)
end

function M:removeAllRoom()
	for id, roomUnit in pairs(self._dictRoomUnit) do
		roomUnit:returnSelf()

		self._dictRoomUnit[id] = nil
	end

	for id, roomUnit in pairs(self._dictExtraRoom) do
		roomUnit:returnSelf()

		self._dictExtraRoom[id] = nil
	end
end

function M:createRoomsToHouse()
	table.clear(self._dictRoomUnit)

	local zoneCOs = HouseConfig.instance:getConfigList(ConfigName.HouseZone)
	local allRoomRootGO = goutil.findChild(self._scene.stage:getHouseRootGo(), ALL_ROOM_ROOT_PATH)

	for _, zoneCO in ipairs(zoneCOs) do
		local zoneType = NavMeshUtil.getZoneTypeByZoneId(zoneCO.id)

		if zoneType == HouseEnum.ZoneType.Room then
			local rootGO = goutil.findChild(allRoomRootGO, zoneCO.roomRootPath)
			local roomUnit = self:_createRoomUnit(zoneCO, rootGO)

			self._dictRoomUnit[zoneCO.id] = roomUnit
		end

		if zoneType == HouseEnum.ZoneType.Extra then
			local rootGO = goutil.findChild(allRoomRootGO, zoneCO.roomRootPath)
			local roomUnit = self:_createRoomUnit(zoneCO, rootGO)

			self._dictExtraRoom[zoneCO.id] = roomUnit
		end
	end

	HouseDispatcher:dispatchEvent(HouseEventType.CREATE_ALL_ROOM_UNIT)
end

function M:_createRoomUnit(roomCO, addRootGO)
	local unitClass = ROOM_TYPE_TO_UNIT_CLS[roomCO.roomType]
	local roomUnit = unitClass:createInstance(string.format("house_room_%s", roomCO.id))

	roomUnit.id = roomCO.id

	roomUnit.model:setRoomCO(roomCO)
	goutil.addChildToParent(roomUnit.go, addRootGO)
	roomUnit:setUnitLocalPos(0, 0, 0)
	roomUnit:lateInit()

	return roomUnit
end

function M:getUnitById(id)
	local extraRoom = self._dictExtraRoom[id]

	if extraRoom then
		return extraRoom
	end

	return self._dictRoomUnit[id]
end

function M:getUnitsByType(roomType)
	local list = {}

	for _, roomUnit in pairs(self._dictRoomUnit) do
		if roomUnit.model:getRoomType() == roomType then
			table.insert(list, roomUnit)
		end
	end

	return list
end

function M:getUnitDict()
	return self._dictRoomUnit
end

function M:getRecordShelterRoom()
	return self._dictExtraRoom[kRecordShelterRoomId]
end

function M:getExtraSmallLivingRoom()
	return self._dictExtraRoom[kSmallLivingRoomId]
end

function M:getExtraBigLivingRoom()
	return self._dictExtraRoom[kBigLivingRoomId]
end

function M:getRoomResource(roomScenePath)
	local resLoader = self._dictRoomResLoader[roomScenePath]

	if resLoader then
		return resLoader:getResource()
	end
end

function M:getRoomCloneGo(roomScenePath)
	local roomGO
	local data = self._dictRoomResData[roomScenePath]
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(data.sceneName, 1, data.goName, goList)

	for _, go in pairs(goList) do
		if go.name == data.goName then
			roomGO = go
		end
	end

	local retainCount = checknumber(self._dictRoomRetainCount[roomScenePath])

	self._dictRoomRetainCount[roomScenePath] = retainCount + 1

	return GameObjectUtils.CloneWithLightMapData(roomGO)
end

function M:releaseRoomGo(roomScenePath)
	self._dictRoomRetainCount[roomScenePath] = self._dictRoomRetainCount[roomScenePath] - 1

	if self._dictRoomRetainCount[roomScenePath] < 1 then
		local resLoader = self._dictRoomResLoader[roomScenePath]

		if resLoader then
			resLoader:clear()
		end

		self._dictRoomRetainCount[roomScenePath] = 0
	end
end

function M:loadRoomRes(roomScenePath, roomSceneName, roomGoName)
	self._dictRoomResData[roomScenePath] = {
		sceneName = roomSceneName,
		goName = roomGoName
	}

	local resLoader = self._dictRoomResLoader[roomScenePath]

	if not resLoader then
		resLoader = SingleResLoader.New()
		self._dictRoomResLoader[roomScenePath] = resLoader
	end

	resLoader:load(roomScenePath, self._onResLoaded, self)
end

function M:_onResLoaded(resource, resLoader)
	local path = resLoader:getUrl()
	local data = self._dictRoomResData[path]

	GameObjectUtils.SetSceneActive(data.sceneName, false)
	HouseDispatcher:dispatchEvent(HouseEventType.ON_ROOM_SCENE_RESLOADED, path)
end

return M
