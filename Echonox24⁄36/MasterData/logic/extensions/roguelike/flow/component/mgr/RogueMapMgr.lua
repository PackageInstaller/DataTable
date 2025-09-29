-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RogueMapMgr.lua

module("logic.extensions.roguelike.flow.component.mgr.RogueMapMgr", package.seeall)

local M = class("RogueMapMgr", IRogueFlowComp)
local kMoveSpeed = 25
local kColliderPath = GameUrl.getScenePrefabUrl("common_npc_props/npc_shaizi/prefab/judge_colliders")
local kUrl_Line = ResName.Line_line
local kUrl_Line_Y = ResName.Line_line_y
local kUrl_Point = ResName.Line_point
local kUrl_Point_Break = ResName.Line_noentry
local kUrl_Plane_Empty = GameUrl.getScenePrefabUrl("common_npc_props/npc_shaizi/prefab/plane_empty")
local kPlatePaths = {
	1,
	111,
	112,
	113,
	114,
	121,
	122,
	211,
	212,
	221,
	222,
	231,
	232,
	233,
	234,
	311,
	312,
	313,
	314,
	321,
	322,
	323,
	324,
	331,
	332,
	333,
	334,
	341,
	342,
	343,
	344,
	351,
	352,
	353,
	354,
	411,
	412,
	413,
	414,
	421,
	422,
	423,
	424,
	431,
	432,
	433,
	434,
	441,
	442,
	443,
	444,
	451,
	452,
	453,
	454,
	511,
	611,
	612,
	613,
	614,
	621,
	622,
	623,
	624,
	711,
	712,
	721,
	722,
	723,
	724,
	731,
	732,
	733,
	734
}
local kPlatePathPrefix = "common_npc_props/npc_shaizi/prefab/shape/%s"

function M:onInit()
	UnitSpineDir.Up = 2
	UnitSpineDir.Down = 3
	self._idx2Unit = false
	self._judgeGrids = {}
	self._mapRole = RogueMapGenerator.createMapRole()

	local roleRoot = RogueMapGenerator.getRoleRoot()

	goutil.setActive(roleRoot, true)

	self._resDict = {}
	self._resLoader = MultiResLoader.New()

	local resPaths = {}

	table.insert(resPaths, kColliderPath)
	table.insert(resPaths, kUrl_Line)
	table.insert(resPaths, kUrl_Line_Y)
	table.insert(resPaths, kUrl_Point)
	table.insert(resPaths, kUrl_Point_Break)
	table.insert(resPaths, kUrl_Plane_Empty)

	for k, v in pairs(kPlatePaths) do
		table.insert(resPaths, GameUrl.getScenePrefabUrl(string.format(kPlatePathPrefix, v)))
	end

	self._resPaths = resPaths

	local resLoader = self._resLoader

	resLoader:setResPaths(resPaths)
	resLoader:load(self._onAllResLoaded, self._onResLoaded, self)
end

function M:getMapRole()
	return self._mapRole
end

function M:_onAllResLoaded(loader)
	self._resLoader:clear()
end

function M:_onResLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end
end

function M:getRes(resPath)
	return self._resDict[resPath]
end

function M:getAsset(resPath)
	return self:getRes(resPath):GetAsset(nil, nil)
end

function M:getLineIns()
	return goutil.clone(self:getAsset(kUrl_Line))
end

function M:getLineYIns()
	return goutil.clone(self:getAsset(kUrl_Line_Y))
end

function M:getPointIns()
	return goutil.clone(self:getAsset(kUrl_Point))
end

function M:getPlateIns(shapeId)
	return goutil.clone(self:getAsset(GameUrl.getScenePrefabUrl(string.format(kPlatePathPrefix, shapeId))))
end

function M:getPointBreakIns()
	return goutil.clone(self:getAsset(kUrl_Point_Break))
end

function M:getPlaneEmptyIns()
	return goutil.clone(self:getAsset(kUrl_Plane_Empty))
end

function M:getMapInst(idx)
	local path = self._resPaths[idx] or self._resPaths[1]

	self._diceInst = self:getAsset(path)

	return self._diceInst
end

function M:onStart()
	self._idx2Unit = {}
	self._idx2Unit2 = {}
	self._model = self.flow.model or false
	self._lineMaps = {}
end

function M:onClear()
	for _, unit in pairs(self._idx2Unit) do
		unit.mapItem:removeFollowGo()
		RogueMapGenerator.destroyUnit(unit)
	end

	for _, unit in pairs(self._idx2Unit2) do
		unit.mapItem:removeFollowGo()
		RogueMapGenerator.destroyUnit(unit)
	end

	self._idx2Unit = {}
	self._idx2Unit2 = {}
	self._isEnteredFirstScene = false
	self._model = false

	if self._mapRole then
		self._mapRole:destroy()

		self._mapRole = nil
	end

	self._lineMaps = {}

	self:_onAniFinish()
	removetimer(self._onAniFinish, self)
	removetimer(self._onGenerateGridEnd, self)

	local mapRoot = RogueMapGenerator.getMapsRoot()
	local mapRoot2 = RogueMapGenerator.getMapsRoot2()

	goutil.setActive(mapRoot, true)
	goutil.setActive(mapRoot2, true)
	self:destroyEmptyBlock()
end

function M:setRoleSpine()
	local index = 1
	local roleMos = RogueMgr.instance:getModel():getAllRoleMos()
	local isFirst = false

	for i = 1, #roleMos do
		if not roleMos[i].roleProp:getIsDeath() and not isFirst then
			index = i
			isFirst = true
		end
	end

	local roleId = RogueMgr.instance:getModel():getRoleMoByIndex(index):getRoleId()
	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)
	local modelId = characterCO.modelId
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	self._mapRole.meshModel:setBody(GameUrl.getRoguelikeMeshModelUrl(modelCO.rogueResName))
	RoguelikeUtil.instance:destroySelectRoles()
end

function M:createMapItemUnit(idx)
	local unit = RogueMapGenerator.createMapUnit(idx)

	return unit
end

function M:createMapItemUnit2(idx)
	local unit = RogueMapGenerator.createSecondMapUnit(idx)

	return unit
end

function M:setActive(isActive)
	local mapRoot = RogueMapGenerator.getMapsRoot()
	local mapRoot2 = RogueMapGenerator.getMapsRoot2()
	local roleRoot = RogueMapGenerator.getRoleRoot()

	if not goutil.isNil(mapRoot) then
		goutil.setActive(mapRoot, isActive)
	end

	if not goutil.isNil(mapRoot2) then
		goutil.setActive(mapRoot2, isActive and self._isSecondMap)
	end
end

function M:switchToSecondScene(isIn)
	local mapRoot = RogueMapGenerator.getMapsRoot()
	local mapRoot2 = RogueMapGenerator.getMapsRoot2()
	local roleRoot = RogueMapGenerator.getRoleRoot()

	if self._isSecondMap then
		for k, v in pairs(self._idx2Unit or {}) do
			v.mapItem:resetActiveObject()
		end
	else
		for k, v in pairs(self._idx2Unit2 or {}) do
			v.mapItem:resetActiveObject()
		end
	end

	if not goutil.isNil(mapRoot) then
		goutil.setActive(mapRoot, not isIn)
	end

	if not goutil.isNil(mapRoot2) then
		goutil.setActive(mapRoot2, isIn)
	end
end

function M:setFlowUnitPrefab(prefab)
	self._flowUnitPrefab = prefab
end

function M:getFilterLine(mo)
	local lineDir = mo:getLineDir()
	local temp = {}

	function checkInResult(id1, id2)
		for k, v in pairs(self._lineMaps) do
			if v[1] == id1 and v[2] == id2 or v[2] == id1 and v[1] == id2 then
				return true
			end
		end

		table.insert(self._lineMaps, {
			id1,
			id2
		})

		return false
	end

	for k, v in pairs(lineDir) do
		if not checkInResult(mo:getCoordinateStr(), v:getCoordinateStr()) then
			temp[k] = RoguelikeUtil.instance:getIsInCutRoom(v:getCoordinate()) and RoguelikeUtil.instance:getIsInCutRoom(mo:getCoordinate()) and -1 or 1

			if temp[k] == -1 then
				temp[k + 4] = -1
			end

			if not mo:getIsClear() or not v:getIsClear() then
				temp[k] = -1
			end
		end
	end

	return temp
end

function M:updateSecondMapInfo(presentor, isOnEnter)
	local allRoomMos = RoguelikeModel.instance:getRoom2MOs() or {}
	local hadCurRoom = false
	local firstRoomIndex = false
	local firstItem

	for i = 1, #allRoomMos do
		local mo = allRoomMos[i]

		if mo:getRoomType() == RoguelikeExtension_pb.RoomType.INIT then
			RoguelikeTempParam.ROOM_START_COORDINATE = mo:getCoordinate()
		end
	end

	self._lineMaps = {}

	for k, v in pairs(self._idx2Unit2 or {}) do
		v.mapItem:resetActiveObject()
	end

	for i = 1, #allRoomMos do
		local mo = allRoomMos[i]
		local data = {}

		data.index = i

		local temp = i

		data.coordinate = mo:getCoordinate()
		data.coordinateStr = mo:getCoordinateStr()
		data.icon = mo:getRoomIcon(i)
		data.name = mo:getTypeName()
		data.state = mo:getRoomState(i)
		data.visible = mo:getIsVisible()
		data.isFinish = mo:getIsFinish()
		data.isClear = mo:getIsClear()
		data.plateCo = mo:getShapeCo()
		data.mapId = mo:getMapId()
		data.sceneCode = mo:getSceneCode()
		data.sceneType = mo:getSceneType()
		data.cellInfo = mo:getCellInfo()
		data.lineDir = self:getFilterLine(mo)
		data.offset = 0
		data.mo = mo

		local unit = self:getUnit2(i)

		if not unit then
			unit = self:createMapItemUnit2(i)

			self:addUnit2(i, unit)
		end

		data.isCurRoom = i == RoguelikeModel.instance:getCurRoom2Index()

		unit.mapItem:updateData(data)

		if mo:getRoomType() == RoguelikeExtension_pb.RoomType.INIT then
			firstRoomIndex = i
			firstItem = unit
		end

		if i == RoguelikeModel.instance:getCurRoom2Index() then
			self._curIndex = i

			self:_setSpinePosition(unit, isOnEnter)

			hadCurRoom = true
			self._isSecondMap = true
		end
	end

	if not hadCurRoom then
		if not firstItem then
			return
		end

		self._curIndex = firstRoomIndex

		self:_setSpinePosition(firstItem, isOnEnter)
	end
end

function M:setMapUIActive(isActive)
	local allRoomMos = RoguelikeModel.instance:getRoomMOs(true)

	for i = 1, #allRoomMos do
		local unit = self:getUnit(i)

		if unit then
			unit.mapItem:setUiActive(isActive)
		end
	end
end

function M:updateMapInfo(isEnter)
	if self._curMapId ~= RoguelikeModel.instance:getCurMapId() and not RoguelikeModel.instance:getShowAllMap() then
		self:clearMapItems()

		if self._curMapId ~= nil then
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MAP_NAME)
		end
	end

	self._curMapId = RoguelikeModel.instance:getCurMapId()

	local allRoomMos = RoguelikeModel.instance:getRoomMOs(true)
	local hadCurRoom = false
	local firstRoomIndex = false
	local firstItem

	if not allRoomMos then
		return
	end

	self._lineMaps = {}

	for i = 1, #allRoomMos do
		local mo = allRoomMos[i]

		if mo:getRoomType() == RoguelikeExtension_pb.RoomType.INIT then
			RoguelikeTempParam.ROOM_START_COORDINATE = mo:getCoordinate()
		end
	end

	for i = 1, #allRoomMos do
		local mo = allRoomMos[i]
		local data = {}

		data.index = i

		local temp = i

		data.coordinate = mo:getCoordinate()
		data.coordinateStr = mo:getCoordinateStr()
		data.icon = mo:getRoomIcon(i)
		data.name = mo:getTypeName()
		data.state = mo:getRoomState(i)
		data.visible = mo:getIsVisible()
		data.isFinish = mo:getIsFinish()
		data.isClear = mo:getIsClear()
		data.plateCo = mo:getShapeCo()
		data.mapId = mo:getMapId()
		data.sceneCode = mo:getSceneCode()
		data.sceneType = mo:getSceneType()
		data.lineDir = self:getFilterLine(mo)
		data.cellInfo = mo:getCellInfo()
		data.offset = 0
		data.mo = mo

		local unit = self:getUnit(i)

		if not unit then
			unit = self:createMapItemUnit(i)

			self:addUnit(i, unit)
		end

		data.isCurRoom = i == RoguelikeModel.instance:getCurRoomIndex()

		unit.mapItem:updateData(data)

		if mo:getRoomType() == RoguelikeExtension_pb.RoomType.INIT then
			firstRoomIndex = i
			firstItem = unit
		end

		if i == RoguelikeModel.instance:getCurRoomIndex() then
			self._curIndex = i

			self:_setSpinePosition(unit, isEnter)

			hadCurRoom = true
			self._isEnteredFirstScene = true
			self._isSecondMap = false
		end
	end

	if not hadCurRoom and not self._isEnteredFirstScene then
		self._curIndex = firstRoomIndex

		self:_setSpinePosition(firstItem, isEnter)
	end
end

function M:setUIFollowGos(items, isClear)
	for idx, item in ipairs(items) do
		local unit = self:getUnit(idx)

		if unit then
			if isClear then
				unit.mapItem:removeFollowGo()
			else
				unit.mapItem:setFollowGo(item:getGo())
			end
		end
	end
end

function M:setUI2FollowGos(items, isClear)
	for idx, item in ipairs(items) do
		local unit = self:getUnit2(idx)

		if unit then
			if isClear then
				unit.mapItem:removeFollowGo()
			else
				unit.mapItem:setFollowGo(item:getGo())
			end
		end
	end
end

function M:clearMapItems()
	for _, unit in pairs(self._idx2Unit) do
		RogueMapGenerator.destroyUnit(unit)
	end

	self._idx2Unit = {}

	for _, unit in pairs(self._idx2Unit2) do
		RogueMapGenerator.destroyUnit(unit)
	end

	self._idx2Unit2 = {}
end

function M:setMapItemClickCallback(callback)
	self._onMapItemClickCallback = callback
end

function M:onMapItemClick(idx)
	if self._onMapItemClickCallback then
		self._onMapItemClickCallback(idx)
	end
end

function M:getAllUnits()
	return self._idx2Unit
end

function M:getUnit(idx)
	return self._idx2Unit[idx]
end

function M:getUnit2(idx)
	return self._idx2Unit2[idx]
end

function M:addUnit(idx, unit)
	self._idx2Unit[idx] = unit
end

function M:addUnit2(idx, unit)
	self._idx2Unit2[idx] = unit
end

function M:removeUnit(idx)
	self._idx2Unit[idx] = nil
end

function M:_setSpinePosition(unit, isEnter)
	self:_stopTween()

	self._isSpineMoving = false

	self._mapRole.meshModel:play(UnitAnimState.Idle, true)

	local go = unit and unit.go or nil
	local isInSecondRoom = RoguelikeModel.instance:getIsInSecondRoom()
	local curMapId = isInSecondRoom and RoguelikeModel.instance:getCurSecondMapId() or RoguelikeModel.instance:getCurMapId()
	local curScriptId = RoguelikeModel.instance:getCurScriptId()
	local curCoordinate = unit and unit.mapItem:getCoordinateStr() or nil

	if go == nil then
		local _unit = self._isSecondMap and self._idx2Unit2[self._curMoveIndexs[#self._curMoveIndexs]] or self._idx2Unit[self._curMoveIndexs[#self._curMoveIndexs]]

		go = _unit.go
		curCoordinate = _unit.mapItem:getCoordinateStr()
	end

	local posX = Astral.TransformUtil.GetLocalPosX(go.transform)

	Astral.TransformUtil.SetLocalPosX(self._mapRole.go.transform, posX)

	local posY = Astral.TransformUtil.GetLocalPosY(go.transform)

	Astral.TransformUtil.SetLocalPosY(self._mapRole.go.transform, 0)

	local posZ = Astral.TransformUtil.GetLocalPosZ(go.transform)

	Astral.TransformUtil.SetLocalPosZ(self._mapRole.go.transform, posZ)

	if self._lastCoordinate ~= curCoordinate then
		self._lastCoordinate = curCoordinate

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_GUIDE_INFO, GuideEnum.GuideRoguelikeTriggerType.Coordinate, curScriptId, curMapId, curCoordinate)
	end

	local pos = go.transform.position
	local left = -1000

	if not isEnter or RoguelikeController.instance:getIsSelectRoleScene() then
		VirtualCameraMgr.instance:setDampingX(1)
		VirtualCameraMgr.instance:setDampingZ(1)

		local minX = left > pos.x and left or pos.x

		minX = self._isSecondMap and pos.x or minX

		VirtualCameraMgr.instance:doFollowPosition(minX, RoguelikeConst.MAP_ROLE_OFFSET_Y2, pos.z - RoguelikeConst.MAP_ROLE_OFFSET_Z, 0.5)
		RoguelikeController.instance:setIsSelectRoleScene(false)
	else
		VirtualCameraMgr.instance:setDampingX(0)
		VirtualCameraMgr.instance:setDampingZ(0)

		local minX = left > pos.x and left or pos.x

		minX = isInSecondRoom and pos.x or minX

		VirtualCameraMgr.instance:forceSetFollowPosition(minX, RoguelikeConst.MAP_ROLE_OFFSET_Y2, pos.z - RoguelikeConst.MAP_ROLE_OFFSET_Z)
		RoguelikeModel.instance:updateCameraFollowConfiner()
	end
end

function M:_moveToNextNode(isIgnorePlot)
	if self._curMoveIndex > #self._curMoveIndexs then
		self:_endMoveAndShow()

		return false
	end

	self:_stopTween()

	local spinePosX, spinePosY, spinePosZ = Astral.TransformUtil.GetLocalPos(self._mapRole.go.transform, 0, 0, 0)
	local go

	if self._isSecondMap then
		go = self._idx2Unit2[self._curMoveIndexs[self._curMoveIndex]].go
	else
		go = self._idx2Unit[self._curMoveIndexs[self._curMoveIndex]].go
	end

	local targetPosX, targetPosY, targetPosZ = Astral.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)

	targetPosY = 0

	local dir = UnitSpineDir.Right

	if spinePosX < targetPosX then
		dir = UnitSpineDir.Right
	elseif targetPosX < spinePosX then
		dir = UnitSpineDir.Left
	elseif spinePosZ < targetPosZ then
		dir = UnitSpineDir.Up
	else
		dir = UnitSpineDir.Down
	end

	local changeRotationY

	if self._mapRole.meshModel:getDirection() ~= UnitSpineDir.Up and dir == UnitSpineDir.Up then
		changeRotationY = 180
	elseif self._mapRole.meshModel:getDirection() == UnitSpineDir.Up and dir ~= UnitSpineDir.Up then
		changeRotationY = 0
	end

	function execMove()
		local nextIndex = self._curMoveIndex
		local nextMapItem = self._isSecondMap and self._idx2Unit2[self._curMoveIndexs[nextIndex]] or self._idx2Unit[self._curMoveIndexs[nextIndex]]
		local isNeedShowPlot, plotId = nextMapItem.mapItem:getNeedShowPlot()

		if isNeedShowPlot and not isIgnorePlot and nextIndex == #self._curMoveIndexs then
			local tra = nextMapItem.go.transform
			local pos = tra.position
			local rolePos = self._mapRole.go.transform.position
			local dir = UnitSpineDir.Right

			if math.abs(rolePos.z - pos.z) < 0.1 then
				dir = rolePos.x < pos.x and UnitSpineDir.Right or UnitSpineDir.Left
			end

			local targetPos = dir == UnitSpineDir.Right and pos.x - RoguelikeConst.MAP_ITEM_SIZE * 0.5 or pos.x + RoguelikeConst.MAP_ITEM_SIZE * 0.5

			VirtualCameraMgr.instance:doFollowPosition(targetPos, RoguelikeConst.MAP_ROLE_OFFSET_Y2, pos.z - RoguelikeConst.MAP_ROLE_OFFSET_Z, 0.25)
			RoguePlotUtil.instance:playPlot(plotId, nextMapItem.mapItem, function()
				self:_moveToNextNode(true)
			end)

			return
		end

		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_chess_run_jump_hit)
		self._mapRole.meshModel:setDirection(dir)
		self._mapRole.meshModel:play(UnitAnimState.Walk, false, true)

		local distance = math.sqrt(math.pow(targetPosX - spinePosX, 2) + math.pow(targetPosZ - spinePosZ, 2))
		local sec = 0.25
		local targetPos = Vector3.New(targetPosX, 0, targetPosZ)

		self._curTween = DG.Tweening.DOTween.Sequence()

		self._curTween:Append(self._mapRole.go.transform:DOLocalMove(targetPos, sec, false):SetEase(DG.Tweening.Ease.Linear))
		self._curTween:AppendCallback(self._moveToNextNode, self)

		self._curMoveIndex = self._curMoveIndex + 1

		local polygon = VirtualCameraMgr.instance:getPolygonColliderPolygon()

		if polygon then
			polygon:ChangePointPos(0, -100, -100)
			polygon:ChangePointPos(1, 100, -100)
			polygon:ChangePointPos(2, 100, 100)
			polygon:ChangePointPos(3, -100, 100)
		end

		VirtualCameraMgr.instance:setDampingX(1)
		VirtualCameraMgr.instance:setDampingZ(1)

		local pos = targetPos

		VirtualCameraMgr.instance:doFollowPosition(pos.x, RoguelikeConst.MAP_ROLE_OFFSET_Y2, pos.z - RoguelikeConst.MAP_ROLE_OFFSET_Z, sec)
	end

	if changeRotationY ~= nil then
		self._mapRole.transform:doRotation(Vector3.New(0, changeRotationY, 0), 0.4):OnComplete(function()
			execMove()
		end, self)

		return
	end

	execMove()
end

function M:resetCameraPosition()
	local unit

	if self._isSecondMap then
		unit = self._idx2Unit2[RoguelikeModel.instance:getCurRoom2Index()]
	else
		unit = self._idx2Unit[RoguelikeModel.instance:getCurRoomIndex()]
	end

	if unit then
		local go = unit.go
		local pos = go.transform.position

		VirtualCameraMgr.instance:setDampingX(1)
		VirtualCameraMgr.instance:setDampingZ(1)

		local minX = pos.x

		VirtualCameraMgr.instance:doFollowPosition(minX, RoguelikeConst.MAP_ROLE_OFFSET_Y2, pos.z - RoguelikeConst.MAP_ROLE_OFFSET_Z, 0.5)
	else
		printError("没有当前位置", self._isSecondMap, RoguelikeModel.instance:getCurRoom2Index(), RoguelikeModel.instance:getCurRoomIndex())
	end
end

function M:_endMoveAndShow()
	self:_setSpinePosition()
	self:showMapRiseAni()
end

function M:showMapRiseAni()
	local unitMap

	if self._isSecondMap then
		unitMap = self._idx2Unit2[self._curMoveIndexs[#self._curMoveIndexs]]
	else
		unitMap = self._idx2Unit[self._curMoveIndexs[#self._curMoveIndexs]]
	end

	if unitMap ~= nil then
		unitMap.mapItem:showPlaneEmptyHideAni()
		unitMap.mapItem:setPointActive(false, false)
		unitMap.mapItem:showPlateAni(function()
			if self._mapItemClickCallback ~= nil then
				self._mapItemClickCallback()
			end
		end)
		print("显示地块动画")
	elseif self._mapItemClickCallback ~= nil then
		self._mapItemClickCallback()
	end
end

function M:_stopTween()
	if self._curTween then
		self._curTween:Kill()
	end
end

function M:_startMoveSpine()
	if self._isSpineMoving then
		return
	end

	self._isSpineMoving = true
	self._curMoveIndex = 2

	self:_moveToNextNode()

	local index = self._curMoveIndexs[1]
	local unit = self._isSecondMap and self:getUnit2(index) or self:getUnit(index)

	if unit then
		unit.mapItem:setPointActive(true, true)
	end
end

function M:moveToTarget(curIndex, curMoveIndexs, moveCallback, isSecondMap)
	self._curIndex = curIndex
	self._curMoveIndexs = curMoveIndexs
	self._isSecondMap = isSecondMap
	self._mapItemClickCallback = moveCallback

	self:_startMoveSpine()
end

function M:getCurMapUnits()
	local isInSecondRoom = RoguelikeModel.instance:getIsInSecondRoom()
	local idx2Unit = isInSecondRoom and self._idx2Unit2 or self._idx2Unit

	return idx2Unit
end

function M:showMapAnimation(isDown, aniCallback, _isInSecondRoom)
	self._aniCallback = aniCallback

	local isInSecondRoom = RoguelikeModel.instance:getIsInSecondRoom()

	if _isInSecondRoom ~= nil then
		isInSecondRoom = _isInSecondRoom
	end

	local idx2Unit = isInSecondRoom and self._idx2Unit2 or self._idx2Unit
	local timeIndexs = {
		1,
		2,
		3,
		4,
		5,
		6,
		5,
		4,
		3,
		2
	}

	if isDown then
		if isInSecondRoom then
			local mapParent = UnityEngine.GameObject.Find("roomScene")

			if mapParent then
				local animation = mapParent:GetComponent(ComponentType.Animation)

				if animation then
					local aniName = mapParent.transform.parent.parent.name .. "_xs"

					animation:Play(aniName)
				else
					local downPos = mapParent.transform.localPosition - Vector3.New(0, 100, 0)

					mapParent.transform:DOLocalMove(downPos, 0.3, false):SetEase(DG.Tweening.Ease.InSine)
				end
			else
				printError("次级地图板块和墙壁和光照统一放到roomScene节点下")
			end
		else
			local mapParent = UnityEngine.GameObject.Find("forance")

			if mapParent then
				local animation = mapParent:GetComponent(ComponentType.Animation)

				if animation then
					local aniName = mapParent.transform.parent.parent.name .. "_forance_xs"

					animation:Play(aniName)
				end
			end

			for k, v in pairs(idx2Unit) do
				local plateObj = v.mapItem:getPlateObj()

				v.mapItem:setLineActive(false)
				v.mapItem:setPlaneEmptyActive(false)

				if plateObj ~= nil and not goutil.isNil(plateObj) then
					local item = v.mapItem
					local idx = item:getPlateIndex() % 10

					idx = idx == 0 and 10 or idx

					local time = timeIndexs[idx]

					settimer(0.1 * time, function()
						item:playExitAni()
					end, self, false)
				end
			end
		end

		local mapId = isInSecondRoom and RoguelikeModel.instance:getCurSecondMapId() or RoguelikeModel.instance:getCurMapId()
		local sceneId = RoguelikeController.instance:getSceneId(mapId)
		local sceneCO = SceneConfig.instance:getSceneCO(sceneId)
		local data = TableUtil.strToTable(sceneCO and sceneCO.extraParam or "{exitTime = 1.45}")
		local aniTime = data ~= nil and data.exitTime or 1.45

		settimer(aniTime, self._onAniFinish, self, false)
	else
		if isInSecondRoom then
			local mapParent = UnityEngine.GameObject.Find("roomScene")

			if mapParent then
				local animation = mapParent:GetComponent(ComponentType.Animation)

				if animation then
					local aniName = mapParent.transform.parent.parent.name .. "_cx"

					animation:Play(aniName)
				else
					local downPos = mapParent.transform.localPosition

					if downPos.y == 0 then
						mapParent.transform.localPosition = Vector3.New(downPos.x, -40, downPos.z)
					end

					downPos.y = 0

					mapParent.transform:DOLocalMove(downPos, 0.3, false):SetEase(DG.Tweening.Ease.InSine)
				end
			else
				printError("次级地图板块和墙壁和光照统一放到roomScene节点下")
			end
		else
			local mapParent = UnityEngine.GameObject.Find("forance")

			if mapParent then
				local animation = mapParent:GetComponent(ComponentType.Animation)

				if animation then
					local aniName = mapParent.transform.parent.parent.name .. "_forance_cx"

					animation:Play(aniName)
				end
			end

			for k, v in pairs(idx2Unit) do
				local plateObj = v.mapItem:getPlateObj()

				v.mapItem:setLineActive(true)

				if plateObj ~= nil and not goutil.isNil(plateObj) and plateObj.activeInHierarchy then
					goutil.setActive(plateObj, false)

					local item = v.mapItem
					local idx = item:getPlateIndex() % 10

					idx = idx == 0 and 10 or idx

					local time = timeIndexs[idx]

					item:delayPlayEnterAni(0.1 * time)
				end
			end
		end

		settimer(1, self._onAniFinish, self, false)
	end
end

function M:_onAniFinish()
	if self._aniCallback then
		self._aniCallback()
	end
end

function M:getMapRolePos()
	local pos = self._mapRole.go.transform.position
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

	pos.x = pos.x - 2.5 * kMapItemSize
	pos.z = pos.z - 1.5 * kMapItemSize

	return pos
end

function M:getRealMapRolePos()
	local pos = self._mapRole.go.transform.position

	return pos
end

function M:generateJudgeGrids(callback)
	self._generateCallback = callback

	local pos = self._mapRole.go.transform.position

	if not self._goFightGrids or goutil.isNil(self._goFightGrids) then
		self._resLoader1 = MultiResLoader.New()

		local sceneId = RoguelikeController.instance:getSceneId()
		local sceneCO = SceneConfig.instance:getSceneCO(sceneId)
		local judgeSceneName = "judge_scene01"
		local path = GameUrl.getScenePrefabUrl("common_npc_props/npc_shaizi/prefab/" .. judgeSceneName)

		self._resLoader1:addResPath(path, true)
		self._resLoader1:load(false, self._onOneLoaded, self)
	else
		goutil.setActive(self._goFightGrids, true)

		self._goFightGrids.transform.position = Vector3.New(pos.x, -150, pos.z)

		self._goFightGrids.transform:DOLocalMove(pos, 0.2, false):SetEase(DG.Tweening.Ease.InSine)
		settimer(0.2, self._onGenerateGridEnd, self, false)
	end
end

function M:_onOneLoaded(res)
	if res.IsSuccess then
		self._goFightGrids = goutil.clone(res:GetAsset(nil, nil))
	else
		printError("加载判定场景失败")
	end

	self._resLoader1:clear()

	local pos = self._mapRole.go.transform.position

	if self._goFightGrids and not goutil.isNil(self._goFightGrids) then
		goutil.setActive(self._goFightGrids, true)

		self._goFightGrids.transform.position = Vector3.New(pos.x, -150, pos.z)

		self._goFightGrids.transform:DOLocalMove(pos, 0.2, false):SetEase(DG.Tweening.Ease.InSine)
	end

	settimer(0.2, self._onGenerateGridEnd, self, false)
end

function M:_onGenerateGridEnd()
	if self._generateCallback then
		self._generateCallback()
	end
end

function M:clearJudgeGrids()
	if self._goFightGrids and not goutil.isNil(self._goFightGrids) then
		local pos = self._goFightGrids.transform.position

		self._goFightGrids.transform.position = Vector3.New(pos.x, -150, pos.z)

		goutil.setActive(self._goFightGrids, false)
	end

	if not goutil.isNil(self._colliderIns) then
		goutil.destroy(self._colliderIns)
	end
end

function M:generateColliders()
	local pos = self._mapRole.go.transform.position
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local inst = goutil.clone(self:getAsset(kColliderPath))
	local oriPos = pos + Vector3.New(0, 0, 0)

	inst.transform.position = oriPos
	self._colliderIns = inst
end

function M:getJudgeColliderGo()
	return self._colliderIns
end

function M:createEmptyBlock(pos)
	if not goutil.isNil(self._planeEmpty) then
		return self._planeEmpty
	end

	local root = RogueMapGenerator.getRoleRoot()

	self._planeEmpty = self:getPlaneEmptyIns()

	self._planeEmpty.transform:SetParent(root.transform, false)

	self._planeEmpty.transform.localPosition = Vector3.New(0, 0, 0)
	self._planeEmptyAni = self._planeEmpty:GetComponent(ComponentType.Animator)
	self._planeEmpty.transform.position = pos

	return self._planeEmpty
end

function M:destroyEmptyBlock()
	if self._planeEmpty then
		goutil.destroy(self._planeEmpty)

		self._planeEmpty = nil
	end
end

return M
