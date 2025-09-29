-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/component/HouseSceneShelterRecorder.lua

module("logic.extensions.house.scene.component.HouseSceneShelterRecorder", package.seeall)

local M = class("HouseSceneShelterRecorder", SceneComponentBase)
local RoomType = HouseEnum.RoomType
local BehaviorType = HouseEnum.BehaviorType
local WorkStatus = HouseEnum.WorkStatus
local WorkType = HouseEnum.WorkType

function M:onInit()
	self._recordShelterUseClone = nil
	self._recordParam = nil
	self._heroUnit = nil
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self._recordShelterUseClone = false
	self._recordParam = nil
	self._heroUnit = nil
end

function M:onExitScene()
	local roomUnit = self._scene.roomMgr:getRecordShelterRoom()

	if roomUnit then
		roomUnit:removeInnerEventListener(UnitActionType.HouseRoomResLoaded, self._shelterRoomResHasLoaded, self)
	end

	HouseDispatcher:removeEventListener(HouseEventType.SHELTER_ROOM_INVALID_FINISH, self._onEndShelterInvalid, self)
	self:_removeHeroUnit()

	self._recordShelterUseClone = false
	self._recordParam = nil
end

function M:showRecordShelterRoomInvalid(luaTable)
	self._recordParam = luaTable or {}
	self._recordShelterUseClone = false

	self:_createHeroIntoRoom()
	self:_createRoomAndPlay()
end

function M:_createRoomAndPlay()
	local roomUnit = self._scene.roomMgr:getRecordShelterRoom()

	if roomUnit then
		local protomerCO = ContainmentConfig.instance:getProtomerCoById(self._recordParam.protomerId)

		roomUnit.model._subRoomType = protomerCO.shelterRoomType

		roomUnit.resLoader:setResData(false)
		roomUnit.resLoader:removeAllListener()

		local targetResUrl = roomUnit.resLoader._resScenePath
		local sameResRoom
		local shelterRooms = self._scene.roomMgr:getUnitsByType(RoomType.Shelter)

		for _, room in ipairs(shelterRooms) do
			if room.resLoader:getCurrResPath() == targetResUrl then
				sameResRoom = room

				break
			end
		end

		if sameResRoom then
			local cloneGO = GameObjectUtils.CloneWithLightMapData(sameResRoom.resLoader.roomGo)

			roomUnit.resLoader.roomGo = cloneGO
			roomUnit.resLoader.__recordCloneRoomGO = cloneGO

			roomUnit.resLoader:_adjustRoomGoPos()
			roomUnit:hasLoadedRoomRes()

			self._recordShelterUseClone = true

			self:_shelterRoomResHasLoaded()
		else
			roomUnit:addInnerEventListener(UnitActionType.HouseRoomResLoaded, self._shelterRoomResHasLoaded, self)
			roomUnit.resLoader:_loadResStatic()
		end
	end
end

function M:_shelterRoomResHasLoaded()
	local roomUnit = self._scene.roomMgr:getRecordShelterRoom()

	if roomUnit then
		roomUnit:removeInnerEventListener(UnitActionType.HouseRoomResLoaded, self._shelterRoomResHasLoaded, self)
		HouseDispatcher:addEventListener(HouseEventType.SHELTER_ROOM_INVALID_FINISH, self._onEndShelterInvalid, self)

		local luaTable = {}

		luaTable.totalDuration = self._recordParam.totalDuration

		roomUnit.shelterPerform:showInvalidPerform(luaTable)

		local beginCallback = self._recordParam.beginCallback

		if beginCallback then
			beginCallback(self._recordParam.beginTarget)
		end
	end
end

function M:_onEndShelterInvalid(e, roomId)
	HouseDispatcher:removeEventListener(HouseEventType.SHELTER_ROOM_INVALID_FINISH, self._onEndShelterInvalid, self)

	local roomUnit = self._scene.roomMgr:getRecordShelterRoom()

	if roomUnit and roomUnit.model:getRoomId() == roomId then
		self:endRecordShelterRoomInvalid()

		local finishCallback = self._recordParam.finishCallback

		if finishCallback then
			finishCallback(self._recordParam.finishTarget)
		end
	end
end

function M:_createHeroIntoRoom()
	local roomUnit = self._scene.roomMgr:getRecordShelterRoom()
	local heroId = checknumber(self._recordParam.heroId)

	if roomUnit and heroId > 0 then
		local roomId = roomUnit.model:getRoomId()
		local navMO = HouseNavigationModel.instance:getMOByZoneId(roomId)
		local leftPos = navMO:getLeftBorderPos()
		local rightPos = navMO:getRightBorderPos()
		local posX = (leftPos.x + rightPos.x) / 2
		local posY = (leftPos.y + rightPos.y) / 2
		local posZ = (leftPos.z + rightPos.z) / 2
		local info = {
			entityCode = heroId,
			x = posX,
			y = posY,
			z = posZ,
			bornZoneId = roomId
		}

		self._heroUnit = self._scene.unitFactory:createUnit(UnitTag.Player, info)
		self._heroUnit.scheduleModel._targetRoomId = roomId
		self._heroUnit.scheduleModel._curWorkStatus = WorkStatus.Work
		self._heroUnit.scheduleModel._curWorkType = WorkType.Shelter

		self._heroUnit.behaviorMgr:createBehaviorInFirst(BehaviorType.RandomWalk)
	end
end

function M:_removeHeroUnit()
	if self._heroUnit then
		self._scene.unitFactory:removeUnit(UnitTag.Player, self._heroUnit.id)
	end

	self._heroUnit = nil
end

function M:endRecordShelterRoomInvalid()
	local roomUnit = self._scene.roomMgr:getRecordShelterRoom()

	if roomUnit then
		roomUnit:startUnloadRoomRes()

		if self._recordShelterUseClone then
			goutil.destroy(roomUnit.resLoader.__recordCloneRoomGO)
		else
			roomUnit.resLoader._resLoader:clear()
		end
	end

	self:_removeHeroUnit()
end

return M
