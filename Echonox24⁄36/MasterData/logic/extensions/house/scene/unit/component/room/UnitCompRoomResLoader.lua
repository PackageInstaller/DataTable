-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomResLoader.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomResLoader", package.seeall)

local M = class("UnitCompRoomResLoader", UnitComponentBase)
local RoomResLoadType = HouseEnum.RoomResLoadType
local RoomType = HouseEnum.RoomType
local RoomOpenTyp = HouseMainEnum.RoomOpenTyp
local UNLOAD_INTERVAL = 3
local kTempGoName = "tempCalculPosGO"
local kEmptyRoomGoName = "empty_room"
local kUnOpenGoName = "unopen"
local kLockGoName = "lock"
local kInactiveGoName = "inactive"

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = nil
	self._isUnloading = false
	self._isShowing = false
	self._forceLoadRes = false
	self._hasLoadedRes = false
	self.roomGo = nil
	self._roomCO = nil
	self._roomId = nil
	self._ringType = nil
	self._currResPath = nil
	self._roomType = nil
	self._resScenePath = nil
	self._resSceneName = nil
	self._resRootName = nil
	self._originResPathStr = nil
	self._resLoadType = nil
	self._isResStatic = nil
	self._initPosOffset = nil
	self._resLoadedCallback = nil
	self._resLoadedTarget = nil
	self._lastRingType = nil
	self._lastCameraAngle = nil
end

function M:onInit()
	self._resLoader = SingleResLoader.New()
	self._unloadResTimer = SchedulerCtrl.New(self.unloadRes, self)
end

function M:onLateInit()
	self._roomCO = self._unit.model:getRoomCO()
	self._roomId = self._unit.model:getRoomId()
	self._ringType = self._unit.model:getRingType()
	self._currResPath = false

	self:setResData(false)
	self:refreshRoomStatus()
	self:_onEnter()
end

function M:onReuse()
	self:_onEnter()
end

function M:onReset()
	self:_onExit()
end

function M:onDestroy()
	self:onReset()

	self._resLoader = nil
	self._unloadResTimer = nil
end

function M:_onEnter()
	HouseDispatcher:addEventListener(HouseEventType.ON_SCENE_CAMERA_REFRESH, self._onCameraRefresh, self)
	HouseDispatcher:addEventListener(HouseEventType.SET_FORCE_LOAD_ROOM_RES, self._onSetRoomResForceLoad, self)
	GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._onProtomerInfoChange, self)
	GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
	HouseDispatcher:addEventListener(HouseEventType.LIVE_UNLOCK_INFO_REFRESH, self._onLiveUnlockInfoRefresh, self)
	HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_ACTIVE, self._onLiveZoneActive, self)
end

function M:_onExit()
	self:removeAllListener()

	if self._resLoader then
		if self._resLoader:getUrl() then
			self._unit:startUnloadRoomRes()
		end

		self._resLoader:clear()
	end

	if self.roomGo and not self._isResStatic then
		self._unit:startUnloadRoomRes()
		goutil.destroy(self.roomGo)
	end

	self.roomGo = nil
	self._isUnloading = false
	self._isShowing = false
	self._forceLoadRes = false
	self._roomCO = nil
	self._roomId = nil
	self._ringType = nil
	self._currResPath = false

	self:setResData(true)

	self._lastRingType = 0
	self._lastCameraAngle = 0
	self._hasLoadedRes = false
end

function M:removeAllListener()
	self._unloadResTimer:stop()
	HouseDispatcher:removeEventListener(HouseEventType.ON_ROOM_SCENE_RESLOADED, self._onRoomSceneResloaded, self)
	HouseDispatcher:removeEventListener(HouseEventType.ON_SCENE_CAMERA_REFRESH, self._onCameraRefresh, self)
	HouseDispatcher:removeEventListener(HouseEventType.SET_FORCE_LOAD_ROOM_RES, self._onSetRoomResForceLoad, self)
	GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._onProtomerInfoChange, self)
	GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
	HouseDispatcher:removeEventListener(HouseEventType.LIVE_UNLOCK_INFO_REFRESH, self._onLiveUnlockInfoRefresh, self)
	HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_ACTIVE, self._onLiveZoneActive, self)
end

function M:setResData(clearData)
	local roomType = clearData and 0 or self._unit.model:getRoomType()
	local subRoomType = clearData and 0 or self._unit.model:getSubRoomType()

	self._roomType = roomType
	self._resScenePath = false
	self._resSceneName = nil
	self._resRootName = nil
	self._originResPathStr = nil
	self._resLoadType = nil
	self._isResStatic = true
	self._initPosOffset = nil

	local resCO = HouseConfig.instance:getRoomCOByType(self._roomType, subRoomType)

	if resCO then
		local sceneResStrs = string.split(resCO.resPath, "#")

		self._resScenePath = GameUrl.getSceneUrl(sceneResStrs[1])
		self._resSceneName = string.split(sceneResStrs[1], "/")[3]
		self._resRootName = sceneResStrs[2]
		self._isResStatic = resCO.resLoadType == RoomResLoadType.Static or resCO.resLoadType == RoomResLoadType.ChangePos

		if not string.nilorempty(resCO.initPosOffset) then
			self._initPosOffset = string.splitToVector3(resCO.initPosOffset, "#")
		end

		self._originResPathStr = resCO.resPath
		self._resLoadType = resCO.resLoadType
	end
end

function M:getRoomGO()
	return self.roomGo
end

function M:getWorldPosWithLocal(posX, posY, posZ)
	if self.roomGo then
		local tempGO = goutil.findChild(self.roomGo, kTempGoName)

		if not tempGO then
			tempGO = goutil.create(kTempGoName, false)

			goutil.addChildToParent(tempGO, self.roomGo)
		end

		Astral.TransformUtil.SetLocalPos(tempGO.transform, posX, posY, posZ)

		return Astral.TransformUtil.GetPos(tempGO.transform, 0, 0, 0)
	end
end

function M:loadRes()
	if self._isResStatic then
		self:_loadResStatic()
	else
		self:_loadResDynamic()
	end
end

function M:_loadResStatic()
	local hasRes = not string.nilorempty(self._originResPathStr)

	if hasRes then
		self._resLoader:load(self._resScenePath, self._onStaticResLoaded, self)
	end

	local unitParentGO = self._unit:getParentGO()
	local emptyRoomGO = goutil.findChild(unitParentGO, kEmptyRoomGoName)

	if self._roomType == RoomType.Shelter and emptyRoomGO then
		goutil.setActive(emptyRoomGO, not hasRes)
	end
end

function M:_onStaticResLoaded()
	self.roomGo = nil

	if self._resLoadType == RoomResLoadType.ChangePos then
		local roomGO
		local goList = {}

		GameObjectUtils.FindChildRecursivelyBySceneName(self._resSceneName, 1, self._resRootName, goList)

		for _, go in pairs(goList) do
			if go.name == self._resRootName then
				roomGO = go

				break
			end
		end

		self.roomGo = roomGO

		if roomGO then
			self:_adjustRoomGoPos()
		end
	end

	self:_executeLoadedRes()
end

function M:_adjustRoomGoPos()
	local unitParentGO = self._unit:getParentGO()
	local posX, posY, posZ = Astral.TransformUtil.GetPos(unitParentGO.transform, 0, 0, 0)
	local offset = self._initPosOffset

	if offset then
		posX, posY, posZ = self._unit:getWorldPosByOffset(offset.x, offset.y, offset.z)
	end

	Astral.TransformUtil.SetPos(self.roomGo.transform, posX, posY, posZ)

	local rotaX, rotaY, rotaZ = Astral.TransformUtil.GetLocalRotation(unitParentGO.transform, 0, 0, 0)

	Astral.TransformUtil.SetLocalRotation(self.roomGo.transform, 0, 0, rotaZ)
end

function M:_loadResDynamic()
	if not self.roomGo and not string.nilorempty(self._originResPathStr) then
		local roomMgr = SceneMgr.instance:getCurScene().roomMgr

		if roomMgr:getRoomResource(self._resScenePath) then
			self:_addRoomGo()
		else
			HouseDispatcher:addEventListener(HouseEventType.ON_ROOM_SCENE_RESLOADED, self._onRoomSceneResloaded, self)
			roomMgr:loadRoomRes(self._resScenePath, self._resSceneName, self._resRootName)
		end
	end
end

function M:_addRoomGo()
	local roomMgr = SceneMgr.instance:getCurScene().roomMgr

	self.roomGo = roomMgr:getRoomCloneGo(self._resScenePath)

	goutil.addChildToParent(self.roomGo, self._unit.go)
	Astral.TransformUtil.SetLocalPos(self.roomGo.transform, 0, 0, 0)
	Astral.TransformUtil.SetLocalRotation(self.roomGo.transform, 0, 0, 0)
	goutil.setActive(self.roomGo, true)

	self._currResPath = self._resScenePath

	self:_executeLoadedRes()
end

function M:_executeLoadedRes()
	self._hasLoadedRes = true

	self._unit:hasLoadedRoomRes()
	self._unit:dispatchInnerEvent(UnitActionType.HouseRoomResLoaded)
	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_ROOM_RES_HAS_LOADED, self._roomId)
end

function M:unloadRes()
	self._isUnloading = false

	if self._isResStatic then
		self:_unloadResStatic()
	else
		self:_unloadResDynamic()
	end

	self._hasLoadedRes = false
end

function M:_unloadResStatic()
	self.roomGo = nil

	if self._resLoader then
		if self._resLoader:getUrl() then
			self._unit:startUnloadRoomRes()
		end

		self._resLoader:clear()
	end
end

function M:_unloadResDynamic()
	if self.roomGo then
		self._unit:startUnloadRoomRes()

		local roomMgr = SceneMgr.instance:getCurScene().roomMgr

		roomMgr:releaseRoomGo(self._resScenePath)
		goutil.destroy(self.roomGo)

		self.roomGo = nil
		self._currResPath = false
	end
end

function M:_startLoadRes()
	self._isUnloading = false

	self._unloadResTimer:stop()
	self:loadRes()
end

function M:_startUnloadRes()
	if self._isUnloading or not self._hasLoadedRes then
		return
	end

	self._unloadResTimer:restart(UNLOAD_INTERVAL, false)

	self._isUnloading = true
end

function M:_startShowRoom()
	if not self._isShowing then
		self._unit:enterRoom(not string.nilorempty(self._originResPathStr))
	end

	self._isShowing = true

	self:_startLoadRes()
end

function M:_endShowRoom()
	if self._isShowing then
		self._unit:exitRoom(not string.nilorempty(self._originResPathStr))
	end

	self._isShowing = false

	self:_startUnloadRes()
end

function M:getCurrResPath()
	if self._isResStatic then
		return self._resLoader:getUrl()
	else
		return self._currResPath
	end
end

function M:hasLoadedRes()
	if self:getCurrResPath() then
		return self._hasLoadedRes
	end

	return true
end

function M:refreshRoomStatus()
	if ContainmentModel.instance:hasLoadAgentData() and (self._roomType == RoomType.Shelter or self._roomType == RoomType.Living) then
		local openType = self._unit.model:getOpenType()
		local unitParentGO = self._unit:getParentGO()
		local unOpenGO = goutil.findChild(unitParentGO, kUnOpenGoName)

		goutil.setActive(unOpenGO, openType == RoomOpenTyp.UnOpen)

		local lockGO = goutil.findChild(unitParentGO, kLockGoName)

		goutil.setActive(lockGO, openType == RoomOpenTyp.OpenLock)

		local inactiveGO = goutil.findChild(unitParentGO, kInactiveGoName)

		goutil.setActive(inactiveGO, openType == RoomOpenTyp.OpenUnActive)
		self._unit.materialSetter:refreshActiveStatus()
	end
end

function M:getEmptyGO()
	if self._roomType == RoomType.Shelter then
		local unitParentGO = self._unit:getParentGO()

		return goutil.findChild(unitParentGO, kEmptyRoomGoName)
	end
end

function M:_tryReloadRes()
	self._unit.model:refreshRoomType()
	self:setResData(false)

	if self:getCurrResPath() ~= self._resScenePath then
		self:unloadRes()
		self:_onCameraRefresh(nil, self._lastRingType, self._lastCameraAngle)
	end
end

function M:_onCameraRefresh(e, ringType, camContrastAngle)
	if self._forceLoadRes then
		self:_startLoadRes()
	elseif self._roomCO and ringType == self._ringType then
		camContrastAngle = MathUtil.normalizeAngle(camContrastAngle)

		local minAngle = self._roomCO.angle - self._roomCO.deltaAngleToLoad
		local maxAngle = self._roomCO.angle + self._roomCO.deltaAngleToLoad

		if minAngle >= 0 and maxAngle <= 360 then
			if minAngle <= camContrastAngle and camContrastAngle <= maxAngle then
				self:_startShowRoom()
			else
				self:_endShowRoom()
			end
		else
			if minAngle < 0 then
				minAngle = minAngle + 360
			elseif maxAngle > 360 then
				maxAngle = maxAngle - 360
			end

			if minAngle <= camContrastAngle and camContrastAngle <= 360 or camContrastAngle >= 0 and camContrastAngle <= maxAngle then
				self:_startShowRoom()
			else
				self:_endShowRoom()
			end
		end
	else
		self:_endShowRoom()
	end

	self._lastRingType = ringType
	self._lastCameraAngle = camContrastAngle
end

function M:_onRoomSceneResloaded(e, path)
	if self._resScenePath == path and not self.roomGo then
		HouseDispatcher:removeEventListener(HouseEventType.ON_ROOM_SCENE_RESLOADED, self._onRoomSceneResloaded, self)
		self:_addRoomGo()
	end
end

function M:_onProtomerInfoChange()
	self:refreshRoomStatus()
	self:_tryReloadRes()
end

function M:_onSetRoomResForceLoad(e, roomId, forceLoad, needUnloadRes)
	if self._roomId == roomId then
		self._forceLoadRes = forceLoad

		if forceLoad then
			self._unloadResTimer:stop()

			self._isUnloading = false

			self:_tryReloadRes()
		elseif not self._isShowing and needUnloadRes then
			self:_startUnloadRes()
		end
	end
end

function M:_onSupervisorInfoChange()
	self:refreshRoomStatus()
end

function M:_onLiveUnlockInfoRefresh()
	self:refreshRoomStatus()
end

function M:_onLiveZoneActive()
	self:refreshRoomStatus()
end

return M
