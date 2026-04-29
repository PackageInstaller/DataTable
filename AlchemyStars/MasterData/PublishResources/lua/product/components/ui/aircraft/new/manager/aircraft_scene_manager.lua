_class("AircraftSceneManager", Object)
AircraftSceneManager = AircraftSceneManager

function AircraftSceneManager:Constructor(main)
  self._main = main
  self._input = self._main:Input()
  self._aircraftModule = GameGlobal.GetModule(AircraftModule)
  self.roomTable = {}
  self._restRoomTable = {}
  self.uiTable = {}
  self.roomGoTable = {}
  self.roomUIRoot = nil
  self.roomUICamera = nil
  self.pressSliderView = nil
  self.pressSlider = nil
  self.sliderRequest = nil
  self._clickRoom = nil
  self._leavePoint = UnityEngine.GameObject.Find("LogicRoot").transform:Find("Exit").position
end

function AircraftSceneManager:Init()
  local sceneRoot = UnityEngine.GameObject.Find("LogicRoot")
  self.rootReq = ResourceManager:GetInstance():SyncLoadAsset("AircraftRoot.prefab", LoadType.GameObject)
  self.root = self.rootReq.Obj
  self.root.transform:SetParent(sceneRoot.transform, true)
  self.root:SetActive(true)
  self.root.transform.position = Vector3(0, 0, 0)
  local uiCamera = UnityEngine.GameObject.Find("UICamera"):GetComponent("Camera")
  local talkCanvas = self.root.transform:Find("AircraftTalkCanvas").gameObject:GetComponent("Canvas")
  talkCanvas.worldCamera = uiCamera
  self.roomUIRoot = self.root.transform:Find("RoomUI/RoomUICanvas")
  self.roomUICamera = self.root.transform:Find("RoomUI/RoomUICamera"):GetComponent("Camera")
  self.doors = {}
  local doorParent = UnityEngine.GameObject.Find("door")
  if doorParent then
    for i = 0, doorParent.transform.childCount - 1 do
      local hasDoor = Cfg.cfg_aircraft_space[i + 1].Mat
      if hasDoor then
        local doorTrans = doorParent.transform:GetChild(i)
        self.doors[i + 1] = AircraftSpaceDoor:New(i + 1, doorTrans)
      end
    end
  end
  local roomParent = UnityEngine.GameObject.Find("fj")
  if roomParent then
    for i = 0, roomParent.transform.childCount - 1 do
      self.roomGoTable[i + 1] = roomParent.transform:GetChild(i).gameObject
    end
  end
  self.canvasRoot = UnityEngine.GameObject.Find("Aircraft3DUICanvas").transform
  self.uiScale = 0.03
  self:RefreshSpaces()
  self._boards = {}
  local root = UnityEngine.GameObject.Find("BoardNavMeshRoot").transform
  local oversize = root:Find("oversize")
  for i = 1, 4 do
    local navi = root:GetChild(i - 1)
    local os = oversize:GetChild(i - 1)
    self._boards[i] = AircraftBoard:New(navi.gameObject, i, os)
  end
  self._showRoomUI = false
  AirLog("AircraftSceneManager Init Done")
end

function AircraftSceneManager:GetRoomTable()
  return self.roomTable
end

function AircraftSceneManager:GetInteractionRoot()
  return self._interactionTextRoot
end

function AircraftSceneManager:GetInteractionPos()
  return self._interactionPos
end

function AircraftSceneManager:GetInteractionText()
  return self._interactionText
end

function AircraftSceneManager:Dispose()
  if self.sliderRequest then
    self.sliderRequest:Dispose()
  end
  if self.roomTable then
    for _, room in pairs(self.roomTable) do
      room:Dispose()
    end
  end
  if self.doors then
    for _, door in pairs(self.doors) do
      door:Dispose()
    end
  end
  if self.uiTable then
    for _, ui in pairs(self.uiTable) do
      ui:OnDestroy()
    end
  end
end

function AircraftSceneManager:GetRoomBySpaceID(id)
  return self.roomTable[id]
end

function AircraftSceneManager:GetRoomGoSpaceID(id)
  return self.roomGoTable[id]
end

function AircraftSceneManager:RefreshSpaces()
  for i = 1, #self.roomGoTable do
    if Cfg.cfg_aircraft_space[i].BuildType[1] ~= AirRoomType.EmptySpace then
      local roomData = self._aircraftModule:GetRoom(i)
      if not roomData or self.roomTable[i] then
      else
        local floor = Cfg.cfg_aircraft_space[i].Floor
        local room = AircraftRoom:New(self.roomGoTable[i], roomData, floor)
        self.roomTable[i] = room
        local area = room:Area()
        if area then
          if self._restRoomTable[area] then
            Log.exception("[AircraftScene] 娱乐区房间区域类型冲突：", area)
            return
          end
          self._restRoomTable[area] = room
        end
      end
      if self.uiTable[i] then
        self:RefreshUI(i)
      else
        self.uiTable[i] = self:CreateUI(i)
      end
    end
  end
end

function AircraftSceneManager:RefreshRoom(spaceID)
  local logicData = self._aircraftModule:GetRoom(spaceID)
  local room = self.roomTable[spaceID]
  if self._aircraftModule:IsAmusementRoom(room:LogicRoomType()) then
    local state = self.uiTable[spaceID]:GetState()
    AirLog("刷新娱乐区房间：", spaceID, "，当前状态：", state, "，等级：", logicData:Level())
    if state == AirUIState.RestAreaRoom and logicData:Level() > 1 then
      local floor = room:Floor()
      local area = room:Area()
      room:Dispose()
      local newRoom = AircraftRoom:New(self.roomGoTable[spaceID], logicData, floor)
      self.roomTable[spaceID] = newRoom
      local pets = self._main:GetPets(function(p)
        local pet = p
        if pet:GetWanderingArea() == area or pet:GetMovingTargetArea() == area then
          return true
        else
          return false
        end
      end)
      for _, pet in ipairs(pets) do
        self._main:RandomActionForPet(pet)
      end
    end
  end
end

function AircraftSceneManager:GetBoards()
  return self._boards
end

function AircraftSceneManager:GetPointHolderByArea(area)
  if area == AirRestAreaType.Board3 then
    return self:GetBoard3():PointHolder()
  elseif area == AirRestAreaType.Board4 then
    return self:GetBoard4():PointHolder()
  else
    local room = self:GetRoomByArea(area)
    if room == nil then
      Log.exception("###room is nil ! id --> ", area)
    end
    return self:GetRoomByArea(area):GetPointHolder()
  end
end

function AircraftSceneManager:GetGatherPointHolderByArea(area)
  if area == AirRestAreaType.Board3 then
    return self:GetBoard3():GatherPointHolder()
  elseif area == AirRestAreaType.Board4 then
    return self:GetBoard4():GatherPointHolder()
  else
    return self:GetRoomByArea(area):GetGatherPointHolder()
  end
end

function AircraftSceneManager:GetRandomStoryPointHolderByArea(area)
  if area == AirRestAreaType.Board3 then
    return self:GetBoard3():RandomStoryPointHolder()
  elseif area == AirRestAreaType.Board4 then
    return self:GetBoard4():RandomStoryPointHolder()
  else
    return self:GetRoomByArea(area):GetRandomStoryPointHolder()
  end
end

function AircraftSceneManager:AreaIsFull(area)
  if area == AirRestAreaType.Board3 or area == AirRestAreaType.Board4 then
    return false
  else
    if self:GetRoomByArea(area) == nil then
      Log.exception("[AircraftScene] 区域类型错误：", area)
    end
    return self:GetRoomByArea(area):IsWanderingPetFull()
  end
end

function AircraftSceneManager:PetEnterAreaWandering(pet, area)
  local id = pet:TemplateID()
  pet:SetWanderingArea(area)
  if area == AirRestAreaType.Board3 or area == AirRestAreaType.Board4 then
  else
    self:GetRoomByArea(area):PetEnterWandering(id)
  end
end

function AircraftSceneManager:GetAllRestRoom()
  return {
    self:GetRoomByArea(AirRestAreaType.RestRoom),
    self:GetRoomByArea(AirRestAreaType.CoffeeHouse),
    self:GetRoomByArea(AirRestAreaType.Bar),
    self:GetRoomByArea(AirRestAreaType.EntertainmentRoom)
  }
end

function AircraftSceneManager:ClickRoom(spaceId, room, state, focus, callback)
  if self._clickRoom == nil then
    self._clickRoom = spaceId
    self._focusRoom = nil
    self.uiTable[spaceId]:EnterRoom()
    if state == AirUIState.RoomIdle or state == AirUIState.RoomStopWork or state == AirUIState.RestAreaRoom or state == AirUIState.CanCollectAward or state == AirUIState.HaveNewTask or state == AirUIState.CollectAward or state == AirUIState.RestAreaRoomLock then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, spaceId)
      self._showRoomUI = true
    end
  elseif self._clickRoom == spaceId then
    if self._focusRoom == nil then
      if focus and room then
        self._focusRoom = spaceId
        AirLog("点击聚焦到房间：", spaceId)
        self._main:FocusRoom(self.roomTable[spaceId], callback)
        if not self._showRoomUI and state ~= AirUIState.RestAreaRoomLock then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, spaceId)
          self._showRoomUI = true
        end
      end
    elseif not self._showRoomUI and state ~= AirUIState.RestAreaRoomLock then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, spaceId)
      self._showRoomUI = true
    end
  else
    self.uiTable[self._clickRoom]:ExitRoom()
    self._clickRoom = spaceId
    self._focusRoom = nil
    self.uiTable[self._clickRoom]:EnterRoom()
    if state == AirUIState.RoomIdle or state == AirUIState.RoomStopWork or state == AirUIState.RestAreaRoom or state == AirUIState.CanCollectAward or state == AirUIState.HaveNewTask or state == AirUIState.CollectAward then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, spaceId)
      self._showRoomUI = true
    elseif state == AirUIState.RestAreaRoomLock then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, spaceId)
      self._showRoomUI = true
    end
  end
  self:_refresh3duiAlpha()
end

function AircraftSceneManager:_refresh3duiAlpha()
  for _, ui in pairs(self.uiTable) do
    if ui:Selected() then
      ui:WholeShow()
    else
      ui:HalfShow()
    end
  end
end

function AircraftSceneManager:_showAll3Dui()
  for _, ui in pairs(self.uiTable) do
    ui:WholeShow()
  end
end

function AircraftSceneManager:CreateUI(spaceID)
  local state = self:GetUIState(spaceID)
  local roomGo = self.roomGoTable[spaceID]
  local roomData = self._aircraftModule:GetRoom(spaceID)
  local box = roomGo:GetComponent(typeof(UnityEngine.BoxCollider))
  local pos = roomGo.transform.position + box.center - roomGo.transform.forward * (box.size.z / 2)
  local size = box.size
  local req = ResourceManager:GetInstance():SyncLoadAsset("RoomUIBase.prefab", LoadType.GameObject)
  req.Obj.transform:SetParent(self.canvasRoot)
  req.Obj.transform.position = pos
  req.Obj.transform.localScale = Vector3(1, 1, 1)
  req.Obj:SetActive(true)
  local rect = req.Obj:GetComponent(typeof(UnityEngine.RectTransform))
  rect.sizeDelta = Vector2(size.x / self.uiScale, size.y / self.uiScale)
  rect.eulerAngles = roomGo.transform.eulerAngles
  local room = AircraftRoom3DUI:New(req, roomGo)
  room:Show(roomData, state, spaceID)
  return room
end

function AircraftSceneManager:RefreshUI(spaceID)
  local roomData = self._aircraftModule:GetRoom(spaceID)
  local state = self:GetUIState(spaceID)
  self.uiTable[spaceID]:Refresh(roomData, state)
end

function AircraftSceneManager:RefreshOneRoomUI(spaceId)
  local roomData = self._aircraftModule:GetRoom(spaceId)
  local state = self:GetUIState(spaceId)
  self.uiTable[spaceId]:Refresh(roomData, state)
end

function AircraftSceneManager:Update(deltaTimeMS)
  local drag = self._input:GetDrag()
  local zoom = self._input:GetScale()
  if drag or zoom then
    self:ClearCurrentRoom()
  end
  if drag then
    self._main:StopInteraction()
  end
end

function AircraftSceneManager:ClearCurrentRoom()
  if self._clickRoom then
    self.uiTable[self._clickRoom]:ExitRoom()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, nil)
    self._showRoomUI = false
    self._clickRoom = nil
    self._focusRoom = nil
    self:_showAll3Dui()
  elseif self._focusRoom then
    self.uiTable[self._focusRoom]:ExitRoom()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, nil)
    self._showRoomUI = false
    self._clickRoom = nil
    self._focusRoom = nil
    self:_showAll3Dui()
  end
end

function AircraftSceneManager:TryCollectAwardInRoom(spaceID)
  local id = spaceID
  if id ~= nil and 1 <= id then
    local roomType = self._aircraftModule:GetRoom(id):GetRoomType()
    local count = 0
    if roomType == AirRoomType.MazeRoom then
      count = math.floor(self._aircraftModule:GetLightStorage())
    elseif roomType == AirRoomType.TowerRoom then
      count = math.floor(self._aircraftModule:GetHeartAmberCount())
    elseif roomType == AirRoomType.PrismRoom then
      count = math.floor(self._aircraftModule:GetPhysicStorage())
    end
    if 1 <= count then
      GameGlobal.TaskManager():StartTask(function(TT)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "RequestCollectAsset")
        local result, msg = self._aircraftModule:RequestCollectAsset(TT, id)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "RequestCollectAsset")
        if result:GetSucc() then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftTryRefreshRoomUI, id)
          self:RefreshOneRoomUI(id)
          GameGlobal.UIStateManager():ShowDialog("UIGetItemController", msg.asset)
        else
          ToastManager.ShowToast(self._aircraftModule:GetErrorMsg(result:GetResult()))
        end
      end)
      return true
    end
  end
  return false
end

function AircraftSceneManager:SelectRoom(id, focus, param)
  if not self.uiTable[id] then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  local room = self.roomTable[id]
  local state = self.uiTable[id]:GetState()
  if state == AirUIState.AisleNotOpen then
  elseif state == AirUIState.AisleUnbuild then
    Log.exception("[Aircraft] 严重错误，过道没有未建造状态")
  elseif state == AirUIState.AisleUnclean then
    self:ClickRoom(id, room, state, focus)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftCleanSpace, id)
  elseif state == AirUIState.Aisle then
  elseif state == AirUIState.SpaceNotOpen then
    GameGlobal.UIStateManager():ShowDialog("UIAircraftRoomUnLockTipsController", id)
  elseif state == AirUIState.SpaceUnbuild then
    self:ClickRoom(id, room, state, focus)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftBuildRoom, id)
  elseif state == AirUIState.SpaceUnclean then
    self:ClickRoom(id, room, state, focus)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftBuildRoom, id)
  elseif state == AirUIState.RoomBuilding then
    self:ClickRoom(id, room, state, focus)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSpeedUp, id, AircraftRoomOperation.BuildSpeedUp)
  elseif state == AirUIState.RoomIdle or state == AirUIState.CanCollectAward or state == AirUIState.HaveNewTask then
    self:ClickRoom(id, room, state, focus)
  elseif state == AirUIState.RoomStopWork then
    self:ClickRoom(id, room, state, focus)
  elseif state == AirUIState.RoomUpgrading then
    self:ClickRoom(id, room, state, focus)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSpeedUp, id, AircraftRoomOperation.UpgradeSpeedUp)
  elseif state == AirUIState.EvilClearing then
    ToastManager.ShowToast(StringTable.Get("str_toast_manager_evil_spirits_in_purification"))
  elseif state == AirUIState.EvilClearEnd then
    ToastManager.ShowToast(StringTable.Get("str_toast_manager_evil_spirits_in_purification_complete"))
  elseif state == AirUIState.SpaceCleaning then
    self:ClickRoom(id, room, state, focus)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSpeedUp, id, AircraftRoomOperation.CleanSpeedUp)
  elseif state == AirUIState.RoomDegrading then
    self:ClickRoom(id, room, state, focus)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSpeedUp, id, AircraftRoomOperation.DegradeSpeedUp)
  elseif state == AirUIState.RestAreaRoom then
    self:ClickRoom(id, room, state, focus)
  elseif state == AirUIState.RestAreaRoomLock then
    self:ClickRoom(id, room, state, focus)
  elseif state == AirUIState.RoomTearing then
    self:ClickRoom(id, room, state, focus)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSpeedUp, id, AircraftRoomOperation.DegradeSpeedUp)
  elseif state == AirUIState.CollectAward then
    self:ClickRoom(id, room, state, focus)
  end
end

function AircraftSceneManager:ClickSpace(results)
  local clickPet, clickRoom, awardObject, clickSmelt, petpoint, clickTactic
  for i = 1, #results do
    local collider = results[i].collider
    local pet = self._main:GetPetByCollider(collider)
    if pet then
      petpoint = results[i].point
      clickPet = pet
      break
    end
  end
  if not clickPet then
    for i = 1, #results do
      local name = results[i].transform.name
      if name == "smelt" then
        clickSmelt = true
      end
    end
  end
  if not clickPet then
    for i = 1, #results do
      local name = results[i].transform.name
      if name == "tactic" then
        clickTactic = true
      end
    end
  end
  local clickBookShelf = false
  if not clickPet then
    for i = 1, #results do
      local name = results[i].transform.name
      if name == "BookShelf" then
        clickBookShelf = true
      end
    end
  end
  local clicDispatchTaskMap = false
  if not clickPet then
    for i = 1, #results do
      local name = results[i].transform.name
      if name == "DispatchTaskMap" then
        clicDispatchTaskMap = true
      end
    end
  end
  local clickAward = false
  if not clickPet then
    for i = 1, #results do
      local name = results[i].transform.name
      if name == "award" then
        clickAward = true
      end
    end
  end
  local id = 0
  for _, hit in ipairs(results) do
    local go = hit.transform.gameObject
    local _id = table.ikey(self.roomGoTable, go)
    if _id ~= nil and 0 < _id then
      id = _id
      break
    end
  end
  if 0 < id then
    clickRoom = id
    local ui = self.uiTable[id]
    if ui then
      for _, hit in ipairs(results) do
        local go = hit.transform.gameObject
        if ui:IsAwardObject(go) then
          awardObject = go
          break
        end
      end
    else
      clickRoom = nil
    end
  end
  local triggerGuide = false
  if clickRoom then
    local ui = self.uiTable[clickRoom]
    if ui then
      local state = ui:GetState()
      if state == AirUIState.RoomIdle or state == AirUIState.RestAreaRoom then
        local guideModule = GameGlobal.GetModule(GuideModule)
        if not guideModule:GuideInProgress() then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideRoomEnter, clickRoom, function(guide)
            triggerGuide = guide
          end)
        end
      end
    end
  end
  local focus = true
  local select = false
  local selectPet = false
  if triggerGuide then
    focus = true
    self._main:StopInteraction()
    self:SelectRoom(id, focus)
    self:SelectRoom(id, focus)
    AirLog("点击到触发新手引导的房间:", id)
    return
  elseif clickRoom and not awardObject and not clickPet then
    select = true
    focus = true
    selectPet = false
    self._main:StopInteraction()
    AirLog("只点击到房间，spaceID:", clickRoom)
  elseif not clickRoom and not awardObject and clickPet then
    select = false
    focus = false
    selectPet = true
    AirLog("只点击到星灵：", clickPet:TemplateID())
  elseif clickRoom and awardObject and not clickPet then
    select = true
    focus = true
    selectPet = false
    local state = self.uiTable[id]:GetState()
    if state ~= AirUIState.CollectAward then
      self:TryCollectAwardInRoom(id)
    end
    self._main:StopInteraction()
    AirLog("点击到房间和房间内的奖励，spaceID：", clickRoom)
  elseif clickRoom and not awardObject and clickPet then
    selectPet = true
    local state = self.uiTable[id]:GetState()
    if state < AirUIState.SpaceUnbuild then
      select = false
      focus = false
    else
      select = true
      focus = false
    end
    AirLog("点击到房间和星灵，spaceID:", clickRoom, "，petID:", clickPet:TemplateID())
  elseif clickRoom and awardObject and clickPet then
    selectPet = true
    local state = self.uiTable[id]:GetState()
    if state ~= AirUIState.CollectAward and self:TryCollectAwardInRoom(id) then
      selectPet = false
    end
    if state < AirUIState.SpaceUnbuild then
      select = false
    else
      select = true
    end
    focus = not selectPet
    AirLog("点击到房间、星灵和奖励，spaceID:", clickRoom, "，petID:", clickPet:TemplateID())
  elseif not clickRoom and not awardObject and not clickPet then
    self:ClearCurrentRoom()
    return
  else
    Log.exception("[AircraftScene] 点击结果错误：room", clickRoom, ", award:", awardObject, ", pet:", clickPet)
  end
  if selectPet then
    self._main:OnClickPet(clickPet, petpoint)
  elseif clickSmelt then
    GameGlobal.UIStateManager():ShowDialog("UIAircraftItemSmeltController")
  elseif clickTactic then
    GameGlobal.UIStateManager():ShowDialog("UIAircraftTactic")
  elseif clickBookShelf then
    GameGlobal.UIStateManager():ShowDialog("UIBookController")
  elseif clicDispatchTaskMap then
    GameGlobal.UIStateManager():ShowDialog("UIDispatchMapController")
  elseif clickAward then
    local state = self.uiTable[id]:GetState()
    if state == AirUIState.CollectAward then
      Log.debug("###[ClickAward] clickAward")
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "clickAward")
      GameGlobal.TaskManager():StartTask(function(TT)
        local result, msg = self._aircraftModule:RequestCollectAsset(TT, id)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "clickAward")
        if result:GetSucc() then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftTryRefreshRoomUI, id)
          self:RefreshOneRoomUI(id)
          GameGlobal.UIStateManager():ShowDialog("UIGetItemController", msg.asset)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshNavMenuData)
        else
          ToastManager.ShowToast(self._aircraftModule:GetErrorMsg(result:GetResult()))
        end
      end)
    end
  end
  if clickRoom == nil or not select then
    return
  end
  if selectPet then
    local id = clickPet:TemplateID()
    if not self._main:IsRandomStoryPet(id) and not self._main:IsGiftPet(id) and not self._main:HasVisitGift(id) then
      self:SelectRoom(id, focus)
    end
  else
    self:SelectRoom(id, focus)
  end
end

function AircraftSceneManager:GetUIState(_idx)
  local spaceData = self._aircraftModule:GetSpaceInfo(_idx)
  local buildType = Cfg.cfg_aircraft_space[_idx].BuildType[1]
  if spaceData == nil then
    if buildType == nil then
      Log.fatal("[aircraft] space idx error: ", _idx)
      return nil
    end
    if buildType == AirRoomType.AisleRoom then
      return AirUIState.AisleNotOpen
    else
      local unlockTime = Cfg.cfg_aircraft_space[_idx].UnlockTime
      if unlockTime then
        local now = GetSvrTimeNow()
        local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(unlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
        if now < time then
          return AirUIState.SpaceClosed
        end
      end
      return AirUIState.SpaceNotOpen
    end
  else
    local spaceState = spaceData.space_status
    local roomData = self._aircraftModule:GetRoom(_idx)
    local isAisle = buildType == AirRoomType.AisleRoom
    if isAisle then
      if spaceState == SpaceState.SpaceStateNeedClean then
        return AirUIState.AisleUnclean
      elseif spaceState == SpaceState.SpaceStateCleaning then
        Log.exception("[Aircraft] 严重错误，过道状态为清理中")
      elseif spaceState == SpaceState.SpaceStateEmpty then
        return AirUIState.AisleUnbuild
      elseif spaceState == SpaceState.SpaceStateFull then
        return AirUIState.Aisle
      else
        Log.fatal("[aircraft] space state error: ", "Idx: ", _idx, " SpaceState: ", spaceState)
        return nil
      end
    else
      local unlockTime = Cfg.cfg_aircraft_space[_idx].UnlockTime
      if unlockTime then
        local now = GetSvrTimeNow()
        local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(unlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
        if now < time then
          return AirUIState.SpaceClosed
        end
      end
      if buildType == AirRoomType.DispatchRoom then
        if roomData and roomData:HasCompleteTask() then
          return AirUIState.CanCollectAward
        end
        if roomData and roomData:HasNewTask() then
          return AirUIState.HaveNewTask
        end
      end
      if spaceState == SpaceState.SpaceStateNeedClean then
        return AirUIState.SpaceUnclean
      elseif spaceState == SpaceState.SpaceStateCleaning then
        return AirUIState.SpaceCleaning
      elseif spaceState == SpaceState.SpaceStateBuilding then
        return AirUIState.RoomBuilding
      elseif spaceState == SpaceState.SpaceStateEmpty then
        return AirUIState.SpaceUnbuild
      elseif spaceState == SpaceState.SpaceStateUpgrading then
        return AirUIState.RoomUpgrading
      elseif spaceState == SpaceState.SpaceStateDegrading then
        if 1 >= roomData:Level() then
          return AirUIState.RoomTearing
        else
          return AirUIState.RoomDegrading
        end
      elseif spaceState == SpaceState.SpaceStateFull then
        local roomType = roomData:GetRoomType()
        if roomType == AirRoomType.PurifyRoom then
          local purityState = roomData:PurifyStatus()
          if purityState == PurifyRoomStatus.EVIL_WITHOUT_PURIFY or purityState == PurifyRoomStatus.NO_EVIL then
            return AirUIState.RoomIdle
          elseif purityState == PurifyRoomStatus.PURIFING then
            return AirUIState.EvilClearing
          elseif purityState == PurifyRoomStatus.WAITING_COLLECT_AWARD then
            return AirUIState.EvilClearEnd
          else
            Log.fatal("[aircraft] purify room state error: state-->", purityState)
            return nil
          end
        elseif self._aircraftModule:IsAmusementRoom(roomType) then
          if 1 < roomData:Level() then
            return AirUIState.RestAreaRoom
          else
            return AirUIState.RestAreaRoomLock
          end
        elseif roomType == AirRoomType.MazeRoom or roomType == AirRoomType.PrismRoom or roomType == AirRoomType.TowerRoom then
          if roomData:CanCollectOutside() then
            return AirUIState.CollectAward
          else
            return AirUIState.RoomIdle
          end
        else
          return AirUIState.RoomIdle
        end
      else
        Log.fatal("[aircraft] space state error: ", "Idx: ", _idx, " state: ", spaceState)
        return nil
      end
    end
  end
end

function AircraftSceneManager:GetRoomCanBuildForNav(spaceid)
  local canBuild = false
  local spaceState = self.uiTable[spaceid]
  if spaceState then
    local state = spaceState:GetState()
    if state == AirUIState.SpaceUnbuild or state == AirUIState.SpaceUnclean then
      local cfg_space = Cfg.cfg_aircraft_space[spaceid]
      local roomType = cfg_space.BuildType[1]
      local cfg = Cfg.cfg_aircraft_room({RoomType = roomType, Level = 1})[1]
      if cfg then
        local powerEnough = true
        local needPower = cfg.NeedPower
        if needPower then
          local havePower = self._aircraftModule:GetPower()
          if needPower > havePower then
            powerEnough = false
          end
        end
        local matEnough = true
        local needMat = cfg.Need
        if needMat then
          for i = 1, #needMat do
            local needMatID = needMat[i][1]
            local needMatCount = needMat[i][2]
            local roleModule = GameGlobal.GetModule(RoleModule)
            local itemCount = roleModule:GetAssetCount(needMatID)
            if needMatCount > itemCount then
              matEnough = false
              break
            end
          end
        end
        if matEnough and powerEnough then
          canBuild = true
        end
      else
        Log.fatal("###[AircraftSceneManager] GetRoomCanBuildForNav Cfg.cfg_aircraft_room[spaceid] is nil ! id ->", spaceid)
      end
    end
  end
  return canBuild
end

function AircraftSceneManager:GetRoomSpace(spaceId)
  for index, room in ipairs(self.roomTable) do
    local _spaceId = room._roomLogicData._spaceid
    if _spaceId == spaceId then
      return room._roomGO, index
    end
  end
  return nil, -1
end

function AircraftSceneManager:GotoSpace(spaceId)
  AirLog("新手引导触发点击房间：", spaceId)
  local roomGO = self.roomGoTable[spaceId]
  if roomGO then
    self:ClickSpace({roomGO})
  end
end

function AircraftSceneManager:GetBtnGuide(spaceId)
  AirLog("新手引导获取3dui按钮")
  return self.uiTable[spaceId]:GetBtnGuide()
end

function AircraftSceneManager:Set3DUIActive(active)
  self.canvasRoot.gameObject:SetActive(active)
  for _, ui in pairs(self.uiTable) do
    ui:SetAwardUIActive(not active)
  end
end

function AircraftSceneManager:GetDoorBySpaceID(spaceId)
  return self.doors[spaceId]
end

function AircraftSceneManager:SetOneRoomUIActive(spaceID, active)
  self.uiTable[spaceID]:SetActive(active)
end

function AircraftSceneManager:GetRoomByArea(area)
  return self._restRoomTable[area]
end

function AircraftSceneManager:GetBoard3()
  return self._boards[3]
end

function AircraftSceneManager:GetBoard4()
  return self._boards[4]
end

function AircraftSceneManager:CurrentSelectSpaceID()
  return self._clickRoom
end

function AircraftSceneManager:ExitPointPos()
  return self._leavePoint
end

function AircraftSceneManager:SetGotoSpaceId(gotoSpaceId, param)
  AirLog("新手引导设置空间id：", gotoSpaceId)
  if gotoSpaceId and 0 < gotoSpaceId then
    self:SelectRoom(gotoSpaceId)
    self:SelectRoom(gotoSpaceId, true)
    if param then
      local airModule = GameGlobal.GetModule(AircraftModule)
      local space = airModule:GetSpaceInfo(gotoSpaceId)
      if not space then
        ToastManager.ShowToast("Space is nil !")
        return
      end
      if space.space_status == SpaceState.SpaceStateFull then
        local room = airModule:GetRoom(gotoSpaceId)
        if room then
          if room:GetRoomType() == AirRoomType.SmeltRoom then
            GameGlobal.UIStateManager():ShowDialog("UIAircraftItemSmeltController", param)
          elseif room:GetRoomType() == AirRoomType.TacticRoom then
            GameGlobal.UIStateManager():ShowDialog("UIAircraftTactic", param)
          end
        end
      else
        ToastManager.ShowToast("Room is UnLock !")
      end
    end
  end
end

function AircraftSceneManager:GuideGotoSpace(spaceId)
  AirLog("新手引导聚焦到房间：", spaceId)
  self._main:FocusRoom(self.roomTable[spaceId], function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, spaceId)
    local triggerGuide = false
    local guideModule = GameGlobal.GetModule(GuideModule)
    if not guideModule:GuideInProgress() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideRoomEnter, spaceId, function(guide)
        triggerGuide = guide
      end)
    end
  end)
end

function AircraftSceneManager:ClearBeforeDecorate()
  for _, room in pairs(self._restRoomTable) do
    room:ClearPets()
  end
  for _, room in pairs(self.roomTable) do
    room:ReleaseAllPoints()
  end
  for _, b in pairs(self._boards) do
    b:ReleaseAllPoints()
  end
end

function AircraftSceneManager:OnStartDecorate()
  self:ClearCurrentRoom()
  self:ClearBeforeDecorate()
  for _, room in pairs(self.roomTable) do
    room:OnStartDecorate()
  end
end

function AircraftSceneManager:OnStopDecorate()
  for _, room in pairs(self.roomTable) do
    room:OnStopDecorate()
  end
end
