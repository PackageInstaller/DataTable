-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/map/HouseMapRoom.lua

module("logic.extensions.house.view.map.HouseMapRoom", package.seeall)

local M = class("HouseMapRoom")
local RoomOpenTyp = HouseMainEnum.RoomOpenTyp

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGO = self._compContainer.gameObject

	self:buildUI()
	self:bindEvents()

	self._roomId = false
	self._viewComponent = false
end

function M:OnDestroy()
	self:unbindEvents()

	self._roomId = false
	self._clickRoom = false
	self._viewComponent = false
end

function M:buildUI()
	self._clickRoom = Astral.UIClickTrigger.Get(self._mainGO)
	self._goRoomSignRoot = goutil.findChild(self._mainGO, "room_map_sign1")
	self._imgRoomSign = goutil.findChildImageComponent(self._goRoomSignRoot, "imgSign")
	self._txtRoomIdx = goutil.findChildTextComponent(self._goRoomSignRoot, "imgSign/txtNum")
	self._goUnOpenRoot = goutil.findChild(self._mainGO, "room_map_sign2")
	self._goUnActive = goutil.findChild(self._goUnOpenRoot, "imgSign1")
	self._goUnOpen = goutil.findChild(self._goUnOpenRoot, "notOpen")
end

function M:bindEvents()
	self._clickRoom:AddClickListener(self._onClickRoom, self)
end

function M:unbindEvents()
	self._clickRoom:RemoveClickListener()
end

function M:setRoomId(roomId)
	self._roomId = roomId
end

function M:setViewComponent(viewComponent)
	self._viewComponent = viewComponent
end

function M:setSmallMode(isSmallMode)
	local mainRotaX, mainRotaY, mainRotaZ = Astral.TransformUtil.GetLocalRotation(self._mainGO.transform, 0, 0, 0)
	local signRota = isSmallMode and 0 or mainRotaZ * -1

	Astral.TransformUtil.SetLocalRotation(self._goRoomSignRoot.transform, 0, 0, signRota)
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function M:updateRoomStatus()
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, self._roomId)
	local roomType = roomCO.roomType
	local signIconName = HouseEnum.RoomType2SignRes[roomType]

	if signIconName then
		goutil.setActive(self._goRoomSignRoot, true)
		IconLoader.setSprite(self._imgRoomSign, IconType.DynSpriteAtlas_Room, signIconName)

		local idx = tostring(math.fmod(self._roomId, 10))
		local txtNum = roomType == HouseEnum.RoomType.Shelter and idx or ""

		self._txtRoomIdx.text = txtNum
	else
		goutil.setActive(self._goRoomSignRoot, false)
	end

	local state = HouseMainRoomModel.instance:getRoomOpenTyp(self._roomId)

	if state == RoomOpenTyp.UnOpen or state == RoomOpenTyp.OpenLock then
		goutil.setActive(self._goUnOpenRoot, true)
		goutil.setActive(self._goUnOpen, state == RoomOpenTyp.UnOpen)
		goutil.setActive(self._goUnActive, state == RoomOpenTyp.OpenLock)
	else
		goutil.setActive(self._goUnOpenRoot, false)
	end
end

function M:_jumpToRoom()
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()
	local navMO = HouseNavigationModel.instance:getMOByZoneId(self._roomId)

	if curSceneFlow and curSceneFlow.unitMgr and navMO then
		local leftPos = navMO:getLeftBorderPos()
		local rightPos = navMO:getRightBorderPos()
		local posX = (leftPos.x + rightPos.x) / 2
		local posY = (leftPos.y + rightPos.y) / 2
		local mainPlayer = curSceneFlow.unitMgr:getMainPlayer()
		local mainNavGO = mainPlayer.navMesh:getNavMeshGo()

		mainPlayer.navMesh:setNavMeshAgentStatus(false)
		mainPlayer.controller:clearElevatorData()
		Astral.TransformUtil.SetPos(mainNavGO.transform, posX, posY, -24)
		mainPlayer.navMesh:setNavMeshAgentStatus(true)
		mainPlayer.navMeshMover:setStopChangeAngle(false)
		mainPlayer.navMeshMover:setDirection(HouseEnum.UnitDirection.Forward)
		mainPlayer.controller:_updateMoveData()
		settimer(0, function()
			mainPlayer.controller:_updateMoveData()
			self._viewComponent:_onClickBtnClose()
		end, nil, false)
	end
end

function M:_onClickRoom()
	local contentStr = string.format(lang("tip_goto"), HouseMainUtil.getRoomName(self._roomId))
	local dialog = Dialog.showMessage(lang("tip_title"), contentStr)

	dialog:setConfirmListener(self._jumpToRoom, self)
end

return M
