local ExplorationMapCtrl = class("ExplorationMapCtrl", ExplorationCtrlBase)
local UIEpYTrack = require("Game.Exploration.MapUI.UIEpYTrack")
local UIEpETrack = require("Game.Exploration.MapUI.UIEpETrack")
local UIEpSingleTrack = require("Game.Exploration.MapUI.UIEpSingleTrack")
local UIEpRoom = require("Game.Exploration.MapUI.UIEpRoom")
local UIEpStartRoom = require("Game.Exploration.MapUI.UIEpStartRoom")
local UIEpRoomInterface = require("Game.Exploration.MapUI.UIEpRoomInterface")
local UIEpPlayerPos = require("Game.Exploration.MapUI.UIEpPlayerPos")
local UIEpNightWarnLine = require("Game.Exploration.MapUI.UIEpNightWarnLine")
local CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")
local EpRoomEntity = require("Game.Exploration.Entity.EpRoomEntity")
local CS_GameObject = CS.UnityEngine.GameObject
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local RoomScale = 0.5
local RoomIntervalOffsetY = 100
local RoomIntervalOffsetX = 570
local BossRoomScale = RoomScale * 1.3
local RegionIntervalOffsetX = 800

function ExplorationMapCtrl:ctor(epCtrl)
  self.resloader = CS.ResLoader.Create()
  self.viewPosition = Vector3.New()
  self.mapRect = {
    minPoint = Vector2.New(),
    maxPoint = Vector2.New()
  }
  self.roomDic = {}
  self.nextRoomList = {}
  self.mapData = epCtrl.mapData
  self.dynplayer = ExplorationManager:GetDynPlayer()
  self.__refreshRoomVisible = BindCallback(self, self.RefreshRoomVisible)
  self.__onMapDataUpdate = BindCallback(self, self.OnMapDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEpMapDiff, self.__onMapDataUpdate)
  self.__onEpPlayerMoveComplete = BindCallback(self, self.OnPlayerMoveComplete)
  MsgCenter:AddListener(eMsgEventId.OnEpPlayerMoveComplete, self.__onEpPlayerMoveComplete)
  self.__OnEpPlayerFightPowerChang = BindCallback(self, self.OnEpPlayerFightPowerChang)
  MsgCenter:AddListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__OnEpPlayerFightPowerChang)
  self.__onEpOpStateChanged = BindCallback(self, self.OnEpOpStateChanged)
  MsgCenter:AddListener(eMsgEventId.OnEpOpStateChanged, self.__onEpOpStateChanged)
  self.__onBuffChange = BindCallback(self, self.OnBuffChange)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__onBuffChange)
  self.__OnAVGPlay = BindCallback(self, self.OnAVGPlay)
  MsgCenter:AddListener(eMsgEventId.AVGPlayStart, self.__OnAVGPlay)
  self.__onAVGPlayEnd = BindCallback(self, self.OnAVGPlayend)
  MsgCenter:AddListener(eMsgEventId.AVGCtrlPlayEnd, self.__onAVGPlayEnd)
end

function ExplorationMapCtrl:GenMap(mapData, curRoomData)
  self.mapData = mapData
  self.roomRoot = CS_GameObject.Find("RoomMap").transform
  self.bind = {}
  UIUtil.LuaUIBindingTable(self.roomRoot, self.bind)
  self:__InitViewPosition(self.roomRoot.position)
  self.bind.moveTween.onComplete:AddListener(BindCallback(self, self.__OnMoveTweenComplete))
  self.bind.bgCanvas.worldCamera = self.bind.RoomCanvas.worldCamera
  local roomUIPrefabWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("EpRoom/UI_EpRoom"))
  local roomInterfacePrefabWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("EpRoom/UI_EpRoomInterface"))
  local bossWarnLinePrefabWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("EpRoom/UI_EpWarnLine"))
  local roomYTrackPrefabWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("EpRoom/UI_EpYTrack"))
  local playerPosPrefabWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("EpRoom/UI_EpPlayerPos"))
  local roomSingleTrackPrefabWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("EpRoom/UI_EpSingleTrack"))
  local crossLinePrefabWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("EpRoom/UI_EpCrossLine"))
  coroutine.yield(roomUIPrefabWait)
  local roomUIPrefab = roomUIPrefabWait.Result
  coroutine.yield(roomInterfacePrefabWait)
  local roomInterfacePrefab = roomInterfacePrefabWait.Result
  coroutine.yield(bossWarnLinePrefabWait)
  local bossWarnLinePrefab = bossWarnLinePrefabWait.Result
  coroutine.yield(roomYTrackPrefabWait)
  local roomYTrackPrefab = roomYTrackPrefabWait.Result
  coroutine.yield(playerPosPrefabWait)
  local playerPosPrefab = playerPosPrefabWait.Result
  coroutine.yield(roomSingleTrackPrefabWait)
  local roomSingleTrackPrefab = roomSingleTrackPrefabWait.Result
  coroutine.yield(crossLinePrefabWait)
  local crossLinePrefab = crossLinePrefabWait.Result
  self.roomDic = {}
  self.bossWarnLine = nil
  self.roomTrackDic = {}
  self.roomStateDic = {}
  self.autoPathDic = {}
  local scale = RoomScale
  local bossScale = BossRoomScale
  local offsetX = RoomIntervalOffsetX * scale
  local offsetY = RoomIntervalOffsetY * scale
  local regionOffsetX = RegionIntervalOffsetX * scale
  local centorYPos = mapData.centerPosY * 2 * offsetY
  self.hasViewRange = mapData:EpHasViewRange()
  if self.hasViewRange then
    self.bind.rectMask.enabled = true
    local epNightWarnLineWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("EpRoom/UI_EpNightWarnLine"))
    coroutine.yield(epNightWarnLineWait)
    local epNightWarnLine = epNightWarnLineWait.Result
    local epNightWarnLineObj = epNightWarnLine:Instantiate(self.bind.otherHolder)
    self.epNightWarnLine = UIEpNightWarnLine.New()
    self.epNightWarnLine:Init(epNightWarnLineObj)
    self.epNightWarnLine.transform.localScale = self.epNightWarnLine.transform.localScale * scale
    self.epNightWarnLine:AdjustFx(mapData)
  else
    self.bind.rectMask.enabled = false
  end
  self.__roomCenterYPos = centorYPos
  local roomSizeDelta = roomUIPrefab.transform.sizeDelta * scale
  self.__roomSizeDelta = roomSizeDelta
  local interfaceBind = {}
  UIUtil.LuaUIBindingTable(roomInterfacePrefab.transform, interfaceBind)
  local interfaceSize = interfaceBind.img_Left.transform.sizeDelta * scale
  self.__interfaceSize = interfaceSize
  local yTrackOffsetX = roomSizeDelta.x / 2 + interfaceSize.x
  local yTrackTrunkSizeX = (offsetX - interfaceSize.x * 2 - roomSizeDelta.x - offsetY) / scale
  self.__yTrackTrunkSizeX = yTrackTrunkSizeX
  local yTrackForkLength = offsetY * math.sqrt(2) / scale
  local singleTrackTrunkSizeX = (offsetX - yTrackOffsetX * 2) / scale / 2
  self.__singleTrackTrunkSizeX = singleTrackTrunkSizeX
  local bossTrackOffsetX = yTrackOffsetX / scale * bossScale
  local bossRoomExtraX = bossTrackOffsetX - yTrackOffsetX
  self:__GenStartRoom(scale, offsetY)
  local roomVisibleEvent = BindCallback(self, self.OnRoomVisible)
  local roomPosX = offsetX
  for i = 1, mapData.maxMapColNumber do
    local roomMapRow = mapData.roomMap[i]
    local mapColType = mapData:GetMapColType(i)
    for k2, room in pairs(roomMapRow) do
      local pos
      if mapColType.trackType == ExplorationEnum.eTrackLineType.NormalETrack or mapColType.trackType == ExplorationEnum.eTrackLineType.SingleTrack or mapColType.trackType == ExplorationEnum.eTrackLineType.EndTrack then
        pos = Vector3.New(roomPosX, centorYPos, 0)
      elseif room:IsMaxWidthCol() then
        pos = Vector3.New(roomPosX, room.y * offsetY * 2, 0)
      else
        pos = Vector3.New(roomPosX, room.y * offsetY * 2 + offsetY, 0)
      end
      local objScale = scale
      local isBossRoom = room:GetRoomType() == ExplorationEnum.eRoomType.boss
      if isBossRoom then
        objScale = bossScale
        pos.x = pos.x + bossRoomExtraX
        roomPosX = pos.x + bossRoomExtraX
      end
      local roomPos = Vector3.New(pos.x, pos.y, pos.z)
      local roomUIObj = roomUIPrefab:Instantiate(self.bind.roomHolder)
      roomUIObj.transform.localScale = roomUIObj.transform.localScale * objScale
      roomUIObj.transform.localPosition = roomPos
      local uiRoom = UIEpRoom.New()
      uiRoom:Init(roomUIObj)
      uiRoom:InitRoomUI(room, self.resloader)
      local roomEntity = EpRoomEntity.New()
      roomEntity:InitEpRoom(uiRoom, room, roomVisibleEvent)
      self.roomDic[room.position] = roomEntity
      local interfaceObj = roomInterfacePrefab:Instantiate(self.bind.interfaceHolder)
      interfaceObj.transform.localScale = interfaceObj.transform.localScale * objScale
      interfaceObj.transform.localPosition = roomPos
      local roomInterface = UIEpRoomInterface.New()
      roomInterface:Init(interfaceObj)
      roomInterface:InitRoomInterface(room)
      roomEntity:InitEpRoomInterface(roomInterface)
      if mapColType.trackType == ExplorationEnum.eTrackLineType.NormalYTrack then
        local trackPos = Vector3.New(roomPos.x + yTrackOffsetX, roomPos.y, roomPos.z)
        local roomTrackObj = roomYTrackPrefab:Instantiate(self.bind.yTrackHolder)
        roomTrackObj.transform.localScale = roomTrackObj.transform.localScale * scale
        roomTrackObj.transform.localPosition = trackPos
        local roomTrack = UIEpYTrack.New()
        roomTrack:Init(roomTrackObj)
        roomTrack:InitEpYTrack(room, yTrackTrunkSizeX, yTrackForkLength)
        self.roomTrackDic[room.position] = roomTrack
      end
      if mapColType.trackType == ExplorationEnum.eTrackLineType.SingleTrack then
        local singleTrackYOffset = yTrackOffsetX
        if isBossRoom then
          singleTrackYOffset = bossTrackOffsetX
        end
        local trackPos = Vector3.New(roomPos.x + singleTrackYOffset, roomPos.y, roomPos.z)
        local roomTrackObj = roomSingleTrackPrefab:Instantiate(self.bind.eTrackHolder)
        roomTrackObj.transform.localScale = roomTrackObj.transform.localScale * scale
        roomTrackObj.transform.localPosition = trackPos
        local roomTrack = UIEpSingleTrack.New()
        roomTrack:Init(roomTrackObj)
        roomTrack:InitEpSingleTrack(room, singleTrackTrunkSizeX)
        self.roomTrackDic[room.position] = roomTrack
      end
      if mapColType.trackType == ExplorationEnum.eTrackLineType.ReverseETrack and self.bossWarnLine == nil then
        local warningLinePos = Vector3.New(roomPos.x + regionOffsetX / 2, centorYPos, roomPos.z)
        local bossWarnLine = bossWarnLinePrefab:Instantiate(self.bind.otherHolder)
        bossWarnLine.transform.localPosition = warningLinePos
        bossWarnLine.transform.localScale = bossWarnLine.transform.localScale * scale
        self.bossWarnLine = bossWarnLine
      end
      roomEntity:UpdateRoomVisible()
    end
    if mapColType.trackType == ExplorationEnum.eTrackLineType.ReverseETrack then
      roomPosX = roomPosX + regionOffsetX
    else
      roomPosX = roomPosX + offsetX
    end
  end
  self:__GenMapSpecialETrack(scale, bossScale, roomSizeDelta, interfaceSize, offsetX, offsetY, regionOffsetX)
  self:__GenRoomCrossLine(crossLinePrefab, scale, centorYPos)
  self:__GenPlayerPosItem(playerPosPrefab, scale)
  coroutine.yield()
  self:RefreshMapShowState(ExplorationManager:GetDynPlayer():GetOperatorDetail(), curRoomData)
  local playerPower = self.epCtrl.dynPlayer:GetCacheFightPower()
  self.nextRoomList = curRoomData:GetNextRoom()
  for k, v in pairs(self.nextRoomList) do
    self:ShowFightingPower(v, playerPower)
  end
  if curRoomData:IsCrossRoom() then
    local colRoomDic = self.mapData:GetRoomsByX(curRoomData.x)
    for _, tmpRoom in pairs(colRoomDic) do
      if tmpRoom.y ~= curRoomData.y then
        self:ShowFightingPower(tmpRoom, playerPower)
      end
    end
  end
  self.lastRoomEntity = self.roomDic[curRoomData.position]
  if 0 < self.mapData:GetEpViewRange() then
    local needShowWarn = curRoomData.x >= self.mapData.depth
    local needShowMaskWarn = self.mapData:GetEpViewRange() + curRoomData.x >= self.mapData.depth
    self.bossWarnLine:SetActive(needShowWarn)
    self.epNightWarnLine:SetBossWarnLine(needShowMaskWarn)
    self:UpdateViewRangeLine()
  end
  if self.hasViewRange then
    self.bind.rectMask:SetGraphicsMat()
  end
  local isShowFixBack = false
  local backgroundOverride = ExplorationManager:GetEpBackgroudOverride()
  if not string.IsNullOrEmpty(backgroundOverride) then
    isShowFixBack = true
    local backGroundResPath = PathConsts:GetExplorationBgPath(backgroundOverride)
    self.resloader:LoadABAssetAsync(backGroundResPath, function(texture)
      self.bind.img_backGround.texture = texture
    end)
  end
  coroutine.yield()
  self:__InitExplorationCameraEffect()
end

function ExplorationMapCtrl:OnMapDataUpdate(epMap)
  for coord, roomType in pairs(epMap.data) do
    local roomData = self.mapData:GetRoomByCoord(coord)
    if roomData ~= nil and roomData:GetRoomType() ~= roomType then
      roomData:SetEpRoomType(roomType)
      local roomEntity = self.roomDic[roomData:GetRoomPosition()]
      if roomEntity ~= nil then
        local uiRoom = roomEntity:GetUIRoom()
        if not IsNull(uiRoom.gameObject) then
          local roomState = self.roomStateDic[roomData.position] or ExplorationEnum.eRoomTypeState.None
          local isAutoPath = self.autoPathDic[roomData.position]
          uiRoom:InitRoomUIMidway(roomData, roomState, false, isAutoPath)
        end
      end
    end
  end
  for coord, lineGraph in pairs(epMap.lineData) do
    local roomData = self.mapData:GetRoomByCoord(coord)
    if roomData ~= nil and roomData:GetRoomType() ~= lineGraph.cat then
      roomData:SetEpRoomType(lineGraph.cat)
      local roomEntity = self.roomDic[roomData:GetRoomPosition()]
      if roomEntity ~= nil then
        local uiRoom = roomEntity:GetUIRoom()
        if not IsNull(uiRoom.gameObject) then
          local roomState = self.roomStateDic[roomData.position] or ExplorationEnum.eRoomTypeState.None
          local isAutoPath = self.autoPathDic[roomData.position]
          uiRoom:InitRoomUIMidway(roomData, roomState, false, isAutoPath)
        end
      end
    end
  end
  if epMap.step ~= nil then
    self.mapData:UpdateTotalStep(epMap.step)
  end
end

function ExplorationMapCtrl:__GenStartRoom(scale, offsetY)
  local mapData = self.mapData
  local startRoomUIPrefab = self.resloader:LoadABAsset(PathConsts:GetUIPrefabPath("EpRoom/UI_EpStartRoom"))
  local startRoomData = mapData:GetStartRoom()
  local yPos = mapData.centerPosY * 2 * offsetY
  local pos = Vector3.New(0, yPos, 0)
  local startRoomUIObj = startRoomUIPrefab:Instantiate(self.bind.otherHolder)
  startRoomUIObj.transform.localPosition = pos
  startRoomUIObj.transform.localScale = startRoomUIObj.transform.localScale * scale
  local uiRoom = UIEpStartRoom.New()
  uiRoom:Init(startRoomUIObj)
  uiRoom:InitRoomUI(startRoomData, self.resloader)
  local roomEntity = EpRoomEntity.New()
  roomEntity:InitEpRoom(uiRoom, startRoomData, BindCallback(self, self.OnRoomVisible))
  self.roomDic[startRoomData.position] = roomEntity
end

function ExplorationMapCtrl:__GenRoomCrossLine(crossLinePrefab, scale)
  local roomCrossLine = crossLinePrefab:Instantiate(self.bind.bottomHolder)
  roomCrossLine.transform.localPosition = Vector3.zero
  roomCrossLine.transform.localScale = roomCrossLine.transform.localScale * scale
  self.roomCrossLine = roomCrossLine
end

function ExplorationMapCtrl:__GenPlayerPosItem(playerPosPrefab, scale)
  local playerObject = playerPosPrefab:Instantiate(self.bind.otherHolder)
  playerObject.transform.localScale = playerObject.transform.localScale * scale
  local playerPosItem = UIEpPlayerPos.New()
  playerPosItem:Init(playerObject)
  self.playerPosItem = playerPosItem
end

function ExplorationMapCtrl:__GenMapSpecialETrack(scale, bossScale, roomSizeDelta, interfaceSize, offsetX, offsetY, regionOffsetX)
  local mapData = self.mapData
  local bossInterfaceSize = interfaceSize / scale * bossScale
  local bossRoomSizeDelta = roomSizeDelta / scale * bossScale
  local normalRoomHalfSizeX = interfaceSize.x + roomSizeDelta.x / 2
  local bossRoomHalfSizeX = bossInterfaceSize.x + bossRoomSizeDelta.x / 2
  local roomETrackPrefabWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("EpRoom/UI_EpETrack"))
  coroutine.yield(roomETrackPrefabWait)
  local roomETrackPrefab = roomETrackPrefabWait.Result
  for i = 0, #mapData.mapColTypeList - 1 do
    local mapColType = mapData.mapColTypeList[i]
    if mapColType.trackType == ExplorationEnum.eTrackLineType.NormalETrack then
      local tmpRoomTrackObj = roomETrackPrefab:Instantiate(self.bind.eTrackHolder)
      local tmpRoomData = mapData:GetRoomByXY(i, 0)
      local tmpScale = scale
      local tmpRoomHalfSizeX = normalRoomHalfSizeX
      if tmpRoomData:GetRoomType() == ExplorationEnum.eRoomType.boss then
        tmpScale = bossScale
        tmpRoomHalfSizeX = bossRoomHalfSizeX
      end
      local tmpRoomEntity = self.roomDic[tmpRoomData.position]
      local tmpRoomUI = tmpRoomEntity:GetUIRoom()
      local roomPos = tmpRoomUI.transform.localPosition
      local tmpRoomSizeDelta = tmpRoomUI:GetRoomSize() * tmpScale
      local startTrackPos = Vector3.New(roomPos.x + tmpRoomSizeDelta.x / 2, roomPos.y, roomPos.z)
      tmpRoomTrackObj.transform.localScale = tmpRoomTrackObj.transform.localScale * tmpScale
      tmpRoomTrackObj.transform.localPosition = startTrackPos
      local trackLength = (offsetX - tmpRoomSizeDelta.x / 2 - tmpRoomHalfSizeX) / tmpScale
      local tmpRoomTrack = UIEpETrack.New()
      tmpRoomTrack:Init(tmpRoomTrackObj)
      tmpRoomTrack:InitRoomNormalETrack(tmpRoomData, self, trackLength, offsetY)
      self.roomTrackDic[tmpRoomData.position] = tmpRoomTrack
    elseif mapColType.trackType == ExplorationEnum.eTrackLineType.ReverseETrack then
      local tmpRoomTrackObj = roomETrackPrefab:Instantiate(self.bind.eTrackHolder)
      local tmpRoomData = mapData:GetRoomByXY(i + 1, 0)
      local tmpScale = scale
      local tmpRoomHalfSizeX = normalRoomHalfSizeX
      if tmpRoomData:GetRoomType() == ExplorationEnum.eRoomType.boss then
        tmpScale = bossScale
        tmpRoomHalfSizeX = bossRoomHalfSizeX
      end
      local tmpRoomEntity = self.roomDic[tmpRoomData.position]
      local tmpRoomUI = tmpRoomEntity:GetUIRoom()
      local roomPos = tmpRoomUI.transform.localPosition
      local tmpRoomSizeDelta = tmpRoomUI:GetRoomSize() * tmpScale
      local tmpTrackPos = Vector3.New(roomPos.x - tmpRoomHalfSizeX, roomPos.y, roomPos.z)
      tmpRoomTrackObj.transform.localScale = tmpRoomTrackObj.transform.localScale * scale
      tmpRoomTrackObj.transform.localPosition = tmpTrackPos
      local tmpCurRoomHalfSizeX = tmpRoomHalfSizeX
      if mapData:GetRoomByXY(i, 0) == ExplorationEnum.eRoomType.boss then
        tmpCurRoomHalfSizeX = bossRoomHalfSizeX
      end
      local trackLength = (regionOffsetX - normalRoomHalfSizeX - normalRoomHalfSizeX) / scale
      local tmpRoomTrack = UIEpETrack.New()
      tmpRoomTrack:Init(tmpRoomTrackObj)
      tmpRoomTrack.traceType = ExplorationEnum.eTrackLineType.ReverseETrack
      tmpRoomTrack:InitRoomReverseETrack(tmpRoomData, self, trackLength, offsetY)
      for k, room in pairs(mapData.roomMap[i]) do
        self.roomTrackDic[room.position] = tmpRoomTrack
      end
    end
  end
end

function ExplorationMapCtrl:RefreshRoomVisible(tmpRoomData)
  local roomEntity = self.roomDic[tmpRoomData.position]
  roomEntity:UpdateRoomVisible()
  self:RefreshRoomLineVisible(tmpRoomData)
end

function ExplorationMapCtrl:OnEpOpStateChanged(opDetail)
end

function ExplorationMapCtrl:OnBuffChange()
  local couldSelectAnyNextRoom = self.dynplayer:IsHaveSpecificTypeBuff(ExplorationEnum.eBuffLogicId.freeSelectRoom)
  if couldSelectAnyNextRoom then
    local curRoomData = self.epCtrl:GetCurrentRoomData(true)
    self:RefreshMapShowState(self.dynplayer:GetOperatorDetail(), curRoomData)
  end
end

function ExplorationMapCtrl:RefreshMapShowState(opDetail, curRoomData, withTween, tweenCallback)
  self.roomCrossLine:SetActive(false)
  local roomStateDic = {}
  local autoPathDic = {}
  local autoPathChanged = false
  for position, _ in pairs(opDetail.epFloorWalked) do
    roomStateDic[position] = ExplorationEnum.eRoomTypeState.Complete
  end
  if self.epCtrl.autoCtrl:IsEnableAutoMode() then
    local autoPath = self.epCtrl.autoCtrl:GetEpAutoPath()
    if autoPath ~= nil then
      for k, position in pairs(autoPath) do
        if roomStateDic[position] ~= ExplorationEnum.eRoomTypeState.Complete then
          autoPathDic[position] = true
        end
      end
    end
  end
  if table.count(autoPathDic) ~= table.count(self.autoPathDic) then
    autoPathChanged = true
  else
    for k, v in pairs(autoPathDic) do
      if v ~= self.autoPathDic[k] then
        autoPathChanged = true
        break
      end
    end
  end
  local curUIRoom = self:GetRoomUI(curRoomData.position)
  self:RecursionRoomData(curRoomData, roomStateDic)
  if opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over and opDetail.specialCat == 0 and opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_MonsterLvUpgrade then
    roomStateDic[curRoomData.position] = ExplorationEnum.eRoomTypeState.CurrentStay
    self.playerPosItem:SetPlayerPos(curUIRoom.transform.position)
    if withTween then
      self.playerPosItem:ShowPlayerPosLarge(true, true, tweenCallback)
    else
      self.playerPosItem:ShowPlayerPosLarge(true)
    end
    if curRoomData:IsCrossRoom() then
      local colRoomDic = self.mapData:GetRoomsByX(curRoomData.x)
      for _, tmpRoom in pairs(colRoomDic) do
        if tmpRoom.y ~= curRoomData.y and roomStateDic[tmpRoom.position] == nil then
          roomStateDic[tmpRoom.position] = ExplorationEnum.eRoomTypeState.None
        end
      end
    end
  else
    local trackItem = self:__GetRoomTrackItem(curRoomData)
    if trackItem ~= nil then
      local crossPos = trackItem:GetTrackCrossingPos()
      self.playerPosItem:SetPlayerPos(crossPos)
      if withTween then
        self.playerPosItem:ShowPlayerPosSmall(true, true, tweenCallback)
      else
        self.playerPosItem:ShowPlayerPosSmall(true)
      end
    else
      self.playerPosItem:SetPlayerPos(curUIRoom.transform.position)
      if withTween then
        self.playerPosItem:ShowPlayerPosLarge(true, true, tweenCallback)
      else
        self.playerPosItem:ShowPlayerPosLarge(true)
      end
    end
    local nextRoomList = curRoomData:GetNextRoom()
    for _, tmpNextRoom in pairs(nextRoomList) do
      roomStateDic[tmpNextRoom.position] = ExplorationEnum.eRoomTypeState.AbleChoose
    end
    if curRoomData:IsCrossRoom() then
      local colRoomDic = self.mapData:GetRoomsByX(curRoomData.x)
      local colHasRoom = false
      for _, tmpRoom in pairs(colRoomDic) do
        if tmpRoom.y ~= curRoomData.y and roomStateDic[tmpRoom.position] ~= ExplorationEnum.eRoomTypeState.Complete then
          roomStateDic[tmpRoom.position] = ExplorationEnum.eRoomTypeState.AbleChoose
          colHasRoom = true
        end
      end
      if colHasRoom then
        self.roomCrossLine:SetActive(true)
        local pos = self:GetRoomEntityLocalPos(curRoomData)
        pos.y = self.__roomCenterYPos
        self.roomCrossLine.transform.localPosition = pos
      end
    end
  end
  local unlimieChoose = self.epCtrl.dynPlayer:GetEpUnlimitChooseRoom()
  if unlimieChoose then
    for x = curRoomData.x + 1, self.mapData.depth do
      local colRoomDic = self.mapData:GetRoomsByX(x)
      for _, tmpRoom in pairs(colRoomDic) do
        local state = roomStateDic[tmpRoom.position]
        if state == nil or state == ExplorationEnum.eRoomTypeState.None then
          roomStateDic[tmpRoom.position] = ExplorationEnum.eRoomTypeState.AbleChoose
        end
      end
    end
  end
  if curRoomData:IsBossRoom() then
    self.playerPosItem.transform.localScale = Vector3.one * BossRoomScale
  end
  if withTween then
    self.epCtrl.sceneCtrl:RefreshBattleToMapLine()
  end
  for position, v in pairs(self.roomDic) do
    if roomStateDic[position] == nil then
      roomStateDic[position] = ExplorationEnum.eRoomTypeState.UnReachable
    elseif not v.roomData:IsCanMove() then
      roomStateDic[position] = ExplorationEnum.eRoomTypeState.CantMove
    end
  end
  for position, state in pairs(roomStateDic) do
    local isAutoPath = autoPathDic[position]
    if self.roomStateDic[position] ~= state or self.autoPathDic[position] ~= isAutoPath or autoPathChanged and isAutoPath then
      isAutoPath = isAutoPath or false
      local roomEntity = self:GetRoomEntity(position)
      roomEntity:GetUIRoom():ChangeUIState(state, withTween, isAutoPath)
      self:RefreshRoomInterfaceAndLine(roomEntity, state, roomStateDic, isAutoPath, autoPathDic)
    end
  end
  self.roomStateDic = roomStateDic
  self.autoPathDic = autoPathDic
end

function ExplorationMapCtrl:__GetRoomTrackItem(roomData)
  local trackItem = self.roomTrackDic[roomData.position]
  return trackItem
end

function ExplorationMapCtrl:PlayerPosItemMove2NextPos(callback)
  local function completeFunc()
    local curRoomData = self.epCtrl:GetCurrentRoomData(true)
    
    local opDetail = self.epCtrl.dynPlayer:GetOperatorDetail()
    self:RefreshMapShowState(opDetail, curRoomData, true, callback)
  end
  
  if self.playerPosItem:PlayerPosIsShowSmall() then
    self.playerPosItem:ShowPlayerPosSmall(false, true, completeFunc)
  elseif self.playerPosItem:PlayerPosIsShowLarge() then
    self.playerPosItem:ShowPlayerPosLarge(false, true, completeFunc)
  else
    completeFunc()
  end
end

function ExplorationMapCtrl:RefreshNightBattleView(curRoomData)
  if self.mapData:EpHasViewRange() then
    self.mapData:RefreshViewRrange(curRoomData.x, self.__refreshRoomVisible)
    if self.mapData:GetEpViewRange() + curRoomData.x >= self.mapData.depth then
      self.epNightWarnLine:SetBossWarnLine(true)
    end
    if curRoomData.x >= self.mapData.depth then
      self.bossWarnLine:SetActive(true)
    end
  end
end

function ExplorationMapCtrl:RefreshRoomInterfaceAndLine(roomEntity, state, roomStateDic, isAutoPath, autoPathDic)
  local roomInterface = roomEntity:GetRoomInterface()
  local lineFalseState = isAutoPath and ExplorationEnum.eTrackLineState.Auto or ExplorationEnum.eTrackLineState.Normal
  if state == ExplorationEnum.eRoomTypeState.Complete then
    if roomInterface ~= nil then
      roomInterface:SetAllInterfacePass(true, self.bind.pathPassColor)
    end
    self:__SetRoomLineLeftPass(roomEntity, ExplorationEnum.eTrackLineState.Pass, roomStateDic, autoPathDic)
    self:__SetRoomLineRightPass(roomEntity, ExplorationEnum.eTrackLineState.Pass, roomStateDic, autoPathDic)
  elseif state == ExplorationEnum.eRoomTypeState.CurrentStay then
    if roomInterface ~= nil then
      roomInterface:SetInterfaceLeftPass(true, self.bind.pathPassColor)
      roomInterface:SetInterfaceRightPass(false)
    end
    self:__SetRoomLineLeftPass(roomEntity, ExplorationEnum.eTrackLineState.Pass, roomStateDic, autoPathDic)
    self:__SetRoomLineRightPass(roomEntity, lineFalseState, roomStateDic, autoPathDic)
  else
    if roomInterface ~= nil then
      roomInterface:SetAllInterfacePass(false)
    end
    self:__SetRoomLineLeftPass(roomEntity, lineFalseState, roomStateDic, autoPathDic)
    self:__SetRoomLineRightPass(roomEntity, lineFalseState, roomStateDic, autoPathDic)
  end
  if roomInterface ~= nil then
    if state == ExplorationEnum.eRoomTypeState.UnReachable then
      roomInterface:SetRoomUIAlpha(ExplorationEnum.UnReachableAlpha)
    else
      roomInterface:SetRoomUIAlpha(1)
    end
  end
end

function ExplorationMapCtrl:RefreshRoomLineVisible(roomData)
  if roomData:IsEpSpecialRoom() then
    return
  end
  local roomType = roomData:GetRoomType()
  if roomType == ExplorationEnum.eRoomType.start then
    local trackItem = self.roomTrackDic[roomData.position]
    trackItem:SetTrunkLineActive()
    return
  end
  local trackItem = self.roomTrackDic[roomData.position]
  local colTrackType = self.mapData:GetMapColTrackType(roomData.x)
  if colTrackType == ExplorationEnum.eTrackLineType.ReverseETrack then
    local trackItem = self.roomTrackDic[roomData.position]
    trackItem:SetForkLineActive(roomData, self)
  elseif colTrackType == ExplorationEnum.eTrackLineType.NormalETrack then
    local trackItem = self.roomTrackDic[roomData.position]
    trackItem:SetTrunkLineActive()
  elseif colTrackType == ExplorationEnum.eTrackLineType.SingleTrack then
  elseif colTrackType == ExplorationEnum.eTrackLineType.NormalYTrack then
    local trackItem = self.roomTrackDic[roomData.position]
    if trackItem ~= nil then
      trackItem:SetTrunkLineActive()
    end
  end
  local lastColTrackType = self.mapData:GetMapColTrackType(roomData.x - 1)
  if lastColTrackType == ExplorationEnum.eTrackLineType.ReverseETrack then
    local lastRoom = self.mapData:GetOneRoomByX(roomData.x - 1)
    local trackItem = self.roomTrackDic[lastRoom.position]
    trackItem:SetTrunkLineActive()
  elseif lastColTrackType == ExplorationEnum.eTrackLineType.NormalETrack then
    local lastRoom = self.mapData:GetRoomByXY(roomData.x - 1, 0)
    local trackItem = self.roomTrackDic[lastRoom.position]
    trackItem:SetForkLineActive(roomData, self)
  elseif lastColTrackType == ExplorationEnum.eTrackLineType.SingleTrack then
    local lastRoom = self.mapData:GetRoomByXY(roomData.x - 1, 0)
    local trackItem = self.roomTrackDic[lastRoom.position]
    trackItem:SetTrunkLineActive(roomData)
  elseif lastColTrackType == ExplorationEnum.eTrackLineType.NormalYTrack then
    local lastRoomList = roomData:GetLastRoom()
    for _, tmpRoomData in pairs(lastRoomList) do
      local trackItem = self.roomTrackDic[tmpRoomData.position]
      if trackItem ~= nil then
        trackItem:SetForkLineActive(roomData, self)
      end
    end
  end
end

function ExplorationMapCtrl:__SetRoomLineLeftPass(roomEntity, lineState, roomStateDic, autoPathDic)
  local roomData = roomEntity:GetRoomData()
  local roomType = roomData:GetRoomType()
  if roomType == ExplorationEnum.eRoomType.start then
    return
  end
  local lastColTrackType = self.mapData:GetMapColTrackType(roomData.x - 1)
  if lastColTrackType == ExplorationEnum.eTrackLineType.ReverseETrack then
    local lastRoom = self.mapData:GetOneRoomByX(roomData.x - 1)
    local trackItem = self.roomTrackDic[lastRoom.position]
    trackItem:SetTrunkLinePass(lineState, self.bind.pathPassColor, self.bind.linePassHeight)
  elseif lastColTrackType == ExplorationEnum.eTrackLineType.NormalETrack then
    local lastRoom = self.mapData:GetRoomByXY(roomData.x - 1, 0)
    local trackItem = self.roomTrackDic[lastRoom.position]
    trackItem:SetForkLinePass(roomData, self, lineState, self.bind.pathPassColor, self.bind.linePassHeight)
  elseif lastColTrackType == ExplorationEnum.eTrackLineType.SingleTrack then
    local lastRoom = self.mapData:GetRoomByXY(roomData.x - 1, 0)
    local trackItem = self.roomTrackDic[lastRoom.position]
    trackItem:SetForkLinePass(roomData, self, lineState, self.bind.pathPassColor, self.bind.linePassHeight)
  elseif lastColTrackType == ExplorationEnum.eTrackLineType.NormalYTrack then
    local lastRoomList = roomData:GetLastRoom()
    for _, tmpRoomData in pairs(lastRoomList) do
      local trackItem = self.roomTrackDic[tmpRoomData.position]
      if trackItem ~= nil then
        if roomStateDic[tmpRoomData.position] == ExplorationEnum.eRoomTypeState.Complete and lineState == ExplorationEnum.eTrackLineState.Pass then
          trackItem:SetForkLinePass(roomData, self, lineState, self.bind.pathPassColor, self.bind.linePassHeight)
        elseif autoPathDic[tmpRoomData.position] and lineState == ExplorationEnum.eTrackLineState.Auto then
          trackItem:SetForkLinePass(roomData, self, lineState, self.bind.pathPassColor, self.bind.linePassHeight)
        else
          trackItem:SetForkLinePass(roomData, self, ExplorationEnum.eTrackLineState.Normal, self.bind.pathPassColor, self.bind.linePassHeight)
        end
      end
    end
  end
end

function ExplorationMapCtrl:__SetRoomLineRightPass(roomEntity, lineState, roomStateDic, autoPathDic)
  local roomData = roomEntity:GetRoomData()
  local roomType = roomData:GetRoomType()
  if roomData.x == self.mapData.maxMapColNumber then
    return
  end
  local colTrackType = self.mapData:GetMapColTrackType(roomData.x)
  if colTrackType == ExplorationEnum.eTrackLineType.ReverseETrack then
    local trackItem = self.roomTrackDic[roomData.position]
    trackItem:SetForkLinePass(roomData, self, lineState, self.bind.pathPassColor, self.bind.linePassHeight)
  elseif colTrackType == ExplorationEnum.eTrackLineType.NormalETrack then
    local trackItem = self.roomTrackDic[roomData.position]
    trackItem:SetTrunkLinePass(lineState, self.bind.pathPassColor, self.bind.linePassHeight)
  elseif colTrackType == ExplorationEnum.eTrackLineType.SingleTrack then
    local trackItem = self.roomTrackDic[roomData.position]
    trackItem:SetTrunkLinePass(lineState, self.bind.pathPassColor, self.bind.linePassHeight)
  elseif colTrackType == ExplorationEnum.eTrackLineType.NormalYTrack then
    local trackItem = self.roomTrackDic[roomData.position]
    if trackItem ~= nil then
      trackItem:SetTrunkLinePass(lineState, self.bind.pathPassColor, self.bind.linePassHeight)
    end
  end
end

function ExplorationMapCtrl:RecursionRoomData(curRoomData, roomStateDic)
  local nextRoomDic = curRoomData:GetNextRoom()
  if nextRoomDic == nil or #nextRoomDic == 0 then
    return
  end
  for _, roomData in pairs(nextRoomDic) do
    if roomStateDic[roomData.position] == nil then
      roomStateDic[roomData.position] = ExplorationEnum.eRoomTypeState.None
      self:RecursionRoomData(roomData, roomStateDic)
    end
  end
end

function ExplorationMapCtrl:GetTotalStep()
  return self.mapData:GetTotalStep()
end

function ExplorationMapCtrl:GetPlayerPosItem()
  return self.playerPosItem
end

function ExplorationMapCtrl:GetRoomUI(position)
  if self.roomDic == nil or self.roomDic[position] == nil then
    return nil
  end
  return self.roomDic[position]:GetUIRoom()
end

function ExplorationMapCtrl:GetRoomEntityPos(roomData)
  local roomEntity = self:GetRoomEntity(roomData.position)
  return roomEntity:GetRoomEntityPos()
end

function ExplorationMapCtrl:GetRoomEntityLocalPos(roomData)
  local roomEntity = self:GetRoomEntity(roomData.position)
  return roomEntity:GetRoomEntityLocalPos()
end

function ExplorationMapCtrl:GetRoomEntity(position)
  local roomEntity = self.roomDic[position]
  if roomEntity ~= nil then
    return roomEntity
  else
    error("Can't find roomEntity, position = " .. tostring(position))
  end
end

function ExplorationMapCtrl:GetRoomRoot()
  return self.roomRoot
end

function ExplorationMapCtrl:__InitViewPosition(position)
  self.viewPosition = position
  self.mapRect = {
    minPoint = Vector2.New(position.x, position.z),
    maxPoint = Vector2.New(position.x, position.z)
  }
end

function ExplorationMapCtrl:GetViewPosition()
  return self.viewPosition
end

function ExplorationMapCtrl:SetViewPosition(position, force)
  self.viewPosition = position
  if not force then
    local limit = self.bind.limitAreaOffset
    self.viewPosition.x = math.clamp(position.x, self.mapRect.minPoint.x - limit, self.mapRect.maxPoint.x + limit)
    self.viewPosition.z = math.clamp(position.z, self.mapRect.minPoint.y - limit, self.mapRect.maxPoint.y + limit)
  end
  return self:GetViewPosition()
end

function ExplorationMapCtrl:OffsetMapRect(offset, viewPos)
  self.mapRect.minPoint.x = offset.x + self.mapRect.minPoint.x
  self.mapRect.minPoint.y = offset.z + self.mapRect.minPoint.y
  self.mapRect.maxPoint.x = offset.x + self.mapRect.maxPoint.x
  self.mapRect.maxPoint.y = offset.z + self.mapRect.maxPoint.y
  self:__UpdateBackgroundSize()
  self:SetViewPosition(viewPos, true)
end

function ExplorationMapCtrl:OnPlayerMoveComplete(curRoomData)
end

function ExplorationMapCtrl:OnRoomVisible(roomEntity)
  local roomPos = roomEntity:GetRoomEntityPos()
  local minPoint = self.mapRect.minPoint
  local maxPoint = self.mapRect.maxPoint
  if roomPos.x < minPoint.x then
    minPoint.x = roomPos.x
  elseif roomPos.x > maxPoint.x then
    maxPoint.x = roomPos.x
  end
  if roomPos.z < minPoint.y then
    minPoint.y = roomPos.z
  elseif roomPos.z > maxPoint.y then
    maxPoint.y = roomPos.z
  end
  self:__UpdateBackgroundSize()
end

function ExplorationMapCtrl:UpdateViewRangeLine()
  if not self.hasViewRange then
    return
  end
  local fartestRoomX, fartestRoomEntity
  for _, roomEntity in pairs(self.roomDic) do
    if roomEntity.roomData:GetVisible() and roomEntity.roomData.x > (fartestRoomX or 0) then
      fartestRoomX = roomEntity.roomData.x
      fartestRoomEntity = roomEntity
    end
  end
  if fartestRoomEntity ~= nil then
    self:__UpdateViewRangeLine(fartestRoomEntity)
  end
end

function ExplorationMapCtrl:__UpdateViewRangeLine(roomEntity)
  if not self.hasViewRange then
    return
  end
  if roomEntity.roomData.x - 1 >= self.mapData.depth then
    self.bossWarnLine:SetActive(true)
  end
  local parentNodeOffset = self.bind.roomHolder.transform.localPosition.x
  local newShowRoomTrack = self:__GetRoomTrackItem(roomEntity.roomData)
  if newShowRoomTrack == nil then
    do
      self.epNightWarnLine:Hide()
      local roomSize = self.__roomSizeDelta.x
      self.__curNightFrontLine = roomEntity.uiRoom.transform.localPosition.x + parentNodeOffset + roomSize / 2
    end
  elseif newShowRoomTrack.traceType == ExplorationEnum.eTrackLineType.NormalYTrack then
    self.epNightWarnLine:Show()
    if newShowRoomTrack ~= nil and newShowRoomTrack.transform.localPosition.x > (self.__curNightFrontLine or 0) then
      local y_pos = newShowRoomTrack.transform.localPosition
      local newLocalpos = Vector3.New(y_pos.x + self.__yTrackTrunkSizeX, self.__roomCenterYPos, y_pos.z)
      self.epNightWarnLine.transform:DOLocalMove(newLocalpos, 1)
      self.__curNightFrontLine = newLocalpos.x
    end
  elseif newShowRoomTrack.traceType == ExplorationEnum.eTrackLineType.SingleTrack then
    self.epNightWarnLine:Show()
    if newShowRoomTrack ~= nil and newShowRoomTrack.transform.localPosition.x > (self.__curNightFrontLine or 0) then
      local y_pos = newShowRoomTrack.transform.localPosition
      local newLocalpos = Vector3.New(y_pos.x + self.__singleTrackTrunkSizeX, self.__roomCenterYPos, y_pos.z)
      self.epNightWarnLine.transform:DOLocalMove(newLocalpos, 1)
      self.__curNightFrontLine = newLocalpos.x
    end
  elseif newShowRoomTrack.traceType == ExplorationEnum.eTrackLineType.ReverseETrack then
    self.epNightWarnLine:Show()
    local y_pos = self.bossWarnLine.transform.localPosition
    local newLocalpos = Vector3.New(y_pos.x, self.__roomCenterYPos, y_pos.z)
    self.epNightWarnLine.transform:DOLocalMove(newLocalpos, 1)
    self.__curNightFrontLine = newLocalpos.x
  else
    self.epNightWarnLine:Hide()
    local roomSize = self.__roomSizeDelta.x
    self.__curNightFrontLine = roomEntity.uiRoom.transform.localPosition.x + parentNodeOffset + roomSize / 2
  end
  local maskTransForm = self.bind.rectMask.gameObject.transform
  local newSize = Vector2.New((self.__curNightFrontLine or 0) + parentNodeOffset - 50, maskTransForm.sizeDelta.y)
  maskTransForm:DOSizeDelta(newSize, 1)
  self.bind.rectMask:SetGraphicsMat()
end

function ExplorationMapCtrl:__UpdateBackgroundSize()
  local parent = self.bind.background.parent
  local minPoint = self.mapRect.minPoint
  local maxPoint = self.mapRect.maxPoint
  local localMinPoint = parent:InverseTransformPoint(Vector3.New(minPoint.x, 0, minPoint.y))
  local localMaxPoint = parent:InverseTransformPoint(Vector3.New(maxPoint.x, 0, maxPoint.y))
  local localSizeVector3 = localMaxPoint - localMinPoint
  localSizeVector3.x = math.abs(localSizeVector3.x)
  localSizeVector3.y = math.abs(localSizeVector3.y)
  local sizeX = localSizeVector3.x + self.bind.bgSizeExtra
  local sizeY = localSizeVector3.y + self.bind.bgSizeExtra
  local size = self.bind.background.sizeDelta
  if size.x ~= sizeX or size.y ~= sizeY then
    size.x = sizeX
    size.y = sizeY
    self.bind.background.sizeDelta = size
  end
  local pos = self.bind.background.localPosition
  local newPos = localSizeVector3 / 2
  if pos.x ~= newPos.x or pos.y ~= newPos.y then
    newPos.z = pos.z
    self.bind.background.localPosition = newPos
  end
end

function ExplorationMapCtrl:OnEpPlayerFightPowerChang()
  local curRoom = self.epCtrl:GetCurrentRoomData(true)
  local playerPower = self.epCtrl.dynPlayer:GetCacheFightPower()
  local nextRooms = curRoom:GetNextRoom()
  for k, v in pairs(nextRooms) do
    self:ShowFightingPower(v, playerPower)
  end
end

function ExplorationMapCtrl:ShowFightingPower(roomData, playerPower)
  local roomUI = self:GetRoomUI(roomData.position)
  local monsterList = roomData:GetMonsterList()
  if roomData:IsBattleRoom() and roomUI ~= nil and monsterList ~= nil and 0 < #monsterList then
    local power = roomData:GetTotalFightingPower()
    roomUI:RefreshBattleFightingPower(power, playerPower)
  end
end

function ExplorationMapCtrl:EpMapTween(targetPos, completeFunc)
  self.moveTweenCompleteFunc = completeFunc
  self.bind.moveTween.tween:ChangeStartValue(self.roomRoot.localPosition)
  self.bind.moveTween.tween:ChangeEndValue(targetPos)
  self.bind.moveTween:DORestart()
  self.bind.canvasGroup.alpha = 1
  self.bind.canvasGroup.interactable = false
  self.bind.fadeTween:DORestartById("fade")
end

function ExplorationMapCtrl:__OnMoveTweenComplete()
  if self.moveTweenCompleteFunc ~= nil then
    self.moveTweenCompleteFunc()
  end
end

function ExplorationMapCtrl:PauseEpMapTween()
  self.bind.moveTween:DOPause()
  self.bind.fadeTween:DOPause()
end

function ExplorationMapCtrl:EpMapFadeTweenBack()
  self.bind.canvasGroup.alpha = 0
  self.bind.canvasGroup.interactable = true
  self.bind.fadeTween:DORestartById("show")
  self:__InitExplorationCameraEffect()
end

function ExplorationMapCtrl:HideMapCavas()
  if not IsNull(self.bind.canvasGroup) then
    self.bind.canvasGroup.alpha = 0
    self.bind.canvasGroup.interactable = false
  end
  self:__CloseExplorationCameraEffect()
end

function ExplorationMapCtrl:HideMapCavasWithoutBg()
  if not IsNull(self.bind.roomCanvas) then
    self.bind.roomCanvas.alpha = 0
  end
  self:__CloseExplorationCameraEffect()
end

function ExplorationMapCtrl:__InitExplorationCameraEffect()
  if self.sceen_camera_effect_id ~= nil then
    return
  end
  if not ExplorationManager:IsInExploration() then
    return
  end
  local floorId = ExplorationManager.floorId
  if floorId == nil then
    return
  end
  local explorationConfig = ConfigData.exploration[floorId]
  if explorationConfig == nil then
    error("explorationConfig is nil !! check ExplorationManager.floorId" .. tostring(ExplorationManager.floorId))
    return
  end
  local sceen_camera_effect_id = explorationConfig.sceen_camera_effect_id
  if sceen_camera_effect_id == 0 then
    return
  end
  if explorationConfig.effective_range ~= 1 then
    return
  end
  if CameraEffectUtil.CameraEffectFunction[sceen_camera_effect_id] == nil then
    return
  end
  self.sceen_camera_effect_id = sceen_camera_effect_id
  CameraEffectUtil.CameraEffectFunction[sceen_camera_effect_id]()
end

function ExplorationMapCtrl:OnAVGPlay()
  print("OnAVGPlay")
  self:__CloseExplorationCameraEffect()
end

function ExplorationMapCtrl:OnAVGPlayend()
  print("OnAVGPlayend")
  self:__InitExplorationCameraEffect()
end

function ExplorationMapCtrl:__CloseExplorationCameraEffect()
  if self.sceen_camera_effect_id ~= nil and CameraEffectUtil.CloseCameraEffectFunction[self.sceen_camera_effect_id] ~= nil then
    CameraEffectUtil.CloseCameraEffectFunction[self.sceen_camera_effect_id]()
    self.sceen_camera_effect_id = nil
  end
end

function ExplorationMapCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnEpMapDiff, self.__onMapDataUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerMoveComplete, self.__onEpPlayerMoveComplete)
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__OnEpPlayerFightPowerChang)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStateChanged, self.__onEpOpStateChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__onBuffChange)
  MsgCenter:RemoveListener(eMsgEventId.AVGPlayStart, self.__OnAVGPlay)
  MsgCenter:RemoveListener(eMsgEventId.AVGCtrlPlayEnd, self.__onAVGPlayEnd)
  if self.hasViewRange then
    if self.epNightWarnLine.transform ~= nil then
      self.epNightWarnLine.transform:DOKill()
    end
    if self.bind.rectMask ~= nil then
      self.bind.rectMask.gameObject.transform:DOKill()
    end
  end
  for k, v in pairs(self.roomDic) do
    v:OnDelete()
  end
  if self.playerPosItem ~= nil then
    self.playerPosItem:Delete()
    self.playerPosItem = nil
  end
  self:__CloseExplorationCameraEffect()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return ExplorationMapCtrl
