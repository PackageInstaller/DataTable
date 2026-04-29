_class("AircraftMain", Object)
AircraftMain = AircraftMain

function AircraftMain:Constructor()
  self._logoutCallback = GameHelper:GetInstance():CreateCallback(self.logOut, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.BeforeRelogin, self._logoutCallback)
  self._gridCfgName = "cfg_aircraft_grids"
  AircraftGrids = Cfg[self._gridCfgName]()
  self._mode = AircraftMode.Normal
  self._Initholders = {}
  self._initActions = {}
  self._inputManager = AircraftInputManager:New(self)
  self._cameraManager = AircraftCameraManager:New(self)
  self._sceneManager = AircraftSceneManager:New(self)
  self._decorateMng = AircraftDecorateManager:New(self)
  self._interactivePoolManager = AircraftInteractivePoolManager:New(self)
  self._petManager = AircraftPetManager:New(self)
  self._clickMng = AircraftClickManager:New(self)
  self._scheduleMng = AircraftScheduleManager:New(self)
  self._socialMng = AircraftSocialManager:New(self)
  self._randomActionMng = AircraftRandomActionManager:New(self)
  self._wisperMng = AircraftWhisperManager:New(self)
  self._randomStoryMng = AircraftRandomStoryManager:New(self)
  self._presentMng = AircraftPresentManager:New(self)
  self._visitingMng = AircraftVisitingManager:New(self)
  self._workingMng = AircraftWorkingManager:New(self)
  self._serializer = AircraftSerializer:New(self)
  self._elevator = AircraftElevator:New(self)
  self._stairs = AircraftStairs:New(self)
  self._naviManager = AircraftNaviManager:New(self)
  AirLog("AircraftMain Constructor Done")
end

function AircraftMain:Init()
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._time = math.ceil(timeModule:GetServerTime())
  self._inputManager:Init()
  self._cameraManager:Init()
  self._sceneManager:Init()
  self._decorateMng:Init()
  self._interactivePoolManager:Init()
  self._petManager:Init()
  self._randomStoryMng:Init()
  self._presentMng:Init()
  self._visitingMng:Init()
  self._workingMng:Init()
  self._clickMng:Init()
  self._scheduleMng:Init()
  self._socialMng:Init()
  self._randomActionMng:Init()
  self._wisperMng:Init()
  self._elevator:Init()
  self._stairs:Init()
  self._naviManager:Init()
  self._serializer:Init()
  self._petManager:ForceShowPetAfterInit()
  for holder, points in pairs(self._Initholders) do
    for _, point in ipairs(points) do
      holder:ReleasePoint(point)
    end
  end
  self._Initholders = nil
  if self._initActions then
    for _, action in ipairs(self._initActions) do
      local pet = action.pet
      pet:StartMainAction(action.action)
    end
    self._initActions = nil
  end
  AirLog("AircraftMain Init Done")
end

function AircraftMain:Update(deltaTimeMS)
  self._time = math.ceil(self._time + deltaTimeMS)
  self._inputManager:Update(deltaTimeMS)
  if self._mode == AircraftMode.Normal then
    self._cameraManager:Update(deltaTimeMS)
    self._sceneManager:Update(deltaTimeMS)
    self._randomStoryMng:Update(deltaTimeMS)
    self._workingMng:Update(deltaTimeMS)
    self._clickMng:Update(deltaTimeMS)
    self._scheduleMng:Update(deltaTimeMS)
    self._socialMng:Update(deltaTimeMS)
    self._randomActionMng:Update(deltaTimeMS)
    self._wisperMng:Update(deltaTimeMS)
    self._petManager:Update(deltaTimeMS)
    self._interactivePoolManager:Update(deltaTimeMS)
    self._serializer:Update(deltaTimeMS)
    self._elevator:Update(deltaTimeMS)
    self._stairs:Update(deltaTimeMS)
    self._naviManager:Update(deltaTimeMS)
  elseif self._mode == AircraftMode.Decorate then
    self._decorateMng:Update(deltaTimeMS)
  end
end

function AircraftMain:logOut()
  AirLog("风船内掉线，析构逻辑")
  self:Dispose()
  local module = GameGlobal.GetModule(AircraftModule)
  module:SetClientMain(nil)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
end

function AircraftMain:Dispose()
  if self._mode == AircraftMode.Normal then
    self._stairs:Dispose()
    self._elevator:Dispose()
    self._serializer:Dispose()
    self._wisperMng:Dispose()
    self._presentMng:Dispose()
    self._visitingMng:Dispose()
    self._randomActionMng:Dispose()
    self._socialMng:Dispose()
    self._scheduleMng:Dispose()
    self._clickMng:Dispose()
    self._workingMng:Dispose()
    self._randomStoryMng:Dispose()
    self._petManager:Dispose()
    self._interactivePoolManager:Dispose()
    self._decorateMng:Dispose()
    self._sceneManager:Dispose()
    self._cameraManager:Dispose()
    self._inputManager:Dispose()
    self._naviManager:Dispose()
  elseif self._mode == AircraftMode.Decorate then
    self._serializer:Dispose()
    self._scheduleMng:Dispose()
    self._decorateMng:Dispose()
    self._sceneManager:Dispose()
    self._cameraManager:Dispose()
    self._inputManager:Dispose()
  end
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.BeforeRelogin, self._logoutCallback)
  AircraftGrids = nil
  CfgClear(self._gridCfgName)
end

function AircraftMain:ChangeMode(mode, param)
  if self._mode == mode then
    return
  end
  if mode == AircraftMode.Normal then
    self._interactivePoolManager = AircraftInteractivePoolManager:New(self)
    self._petManager = AircraftPetManager:New(self)
    self._randomStoryMng = AircraftRandomStoryManager:New(self)
    self._presentMng = AircraftPresentManager:New(self)
    self._visitingMng = AircraftVisitingManager:New(self)
    self._workingMng = AircraftWorkingManager:New(self)
    self._clickMng = AircraftClickManager:New(self)
    self._socialMng = AircraftSocialManager:New(self)
    self._randomActionMng = AircraftRandomActionManager:New(self)
    self._wisperMng = AircraftWhisperManager:New(self)
    self._elevator = AircraftElevator:New(self)
    self._stairs = AircraftStairs:New(self)
    self._naviManager = AircraftNaviManager:New(self)
    self._interactivePoolManager:Init()
    self._petManager:Init()
    self._randomStoryMng:Init()
    self._presentMng:Init()
    self._visitingMng:Init()
    self._workingMng:Init()
    self._clickMng:Init()
    self._scheduleMng:Reset()
    self._socialMng:Init()
    self._randomActionMng:Init()
    self._wisperMng:Init()
    self._elevator:Init()
    self._stairs:Init()
    self._naviManager:Init()
    self._serializer:Reset()
    self._scheduleMng:ReSchedule()
    self._petManager:ForceShowPetAfterInit()
    if self._Initholders then
      for holder, points in pairs(self._Initholders) do
        for _, point in ipairs(points) do
          holder:ReleasePoint(point)
        end
      end
      self._Initholders = nil
    end
    if self._initActions then
      for _, action in ipairs(self._initActions) do
        local pet = action.pet
        pet:StartMainAction(action.action)
      end
      self._initActions = nil
    end
    self._cameraManager:Check3DUI()
    self._sceneManager:OnStopDecorate()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAircraftMainUI, true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftOnAmbientChanged)
  elseif mode == AircraftMode.Decorate then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CloseSendGiftBtn)
    self._stairs:Dispose()
    self._elevator:Dispose()
    self._workingMng:Dispose()
    self._visitingMng:Dispose()
    self._presentMng:Dispose()
    self._wisperMng:Dispose()
    self._randomActionMng:Dispose()
    self._socialMng:Dispose()
    self._clickMng:Dispose()
    self._randomStoryMng:Dispose()
    self._petManager:Dispose()
    self._interactivePoolManager:Dispose()
    self._naviManager:Dispose()
    self._sceneManager:OnStartDecorate()
    self._cameraManager:ResetFov()
    self._decorateMng:Open(param)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAircraftMainUI, false)
  end
  self._mode = mode
end

function AircraftMain:Time()
  return self._time
end

function AircraftMain:GetInitPos(holder)
  local point = holder:PopPoint()
  if self._Initholders == nil then
    self._Initholders = {}
  end
  local t = self._Initholders[holder]
  if self._Initholders[holder] == nil then
    t = {}
    self._Initholders[holder] = t
  end
  t[#t + 1] = point
  return point:Pos()
end

function AircraftMain:StartInitAction(pet, action, index)
  if self._initActions == nil then
    self._initActions = {}
  end
  self._initActions[#self._initActions + 1] = {
    pet = pet,
    action = action,
    idx = index
  }
end

function AircraftMain:IsRestPet(id)
  return not self:IsWorkingPet(id) and not self:IsRandomStoryPet(id) and not self:IsDispatchPet(id) and not self:IsGiftPet(id) and not self:IsVisitPet(id)
end

function AircraftMain:ResetPet()
  self._scheduleMng:ReSchedule()
end

function AircraftMain:GetScheduleQueue()
  return self._scheduleMng:GetQueue()
end

function AircraftMain:SetQueueAndInit(q)
  self._scheduleMng:SetQueueAndInitPets(q)
end

function AircraftMain:GetPetByTmpID(tmpID)
  return self._petManager:GetPet(tmpID)
end

function AircraftMain:GetPets(filter, includeVisitPet)
  return self._petManager:GetPets(filter, includeVisitPet)
end

function AircraftMain:GetVisitPet(visitPetTemplateID)
  return self._petManager:GetVisitPet(visitPetTemplateID)
end

function AircraftMain:DestroyPet(pet)
  self._petManager:RemovePet(pet:TemplateID())
end

function AircraftMain:AddPet(tmpID)
  return self._petManager:AddPet(tmpID)
end

function AircraftMain:AddVisitPet(pet)
  return self._petManager:AddVisitPet(pet)
end

function AircraftMain:RemoveRestPet(tempID)
  AirLog("星灵离开休闲区：", tempID)
  local pet = self._petManager:GetPet(tempID)
  if pet:GetBelongArea() then
    local room = self:GetRoomByArea(pet:GetBelongArea())
    if room then
      room:PetOut(tempID)
    end
  end
  if pet:GetWanderingArea() then
    local room = self:GetRoomByArea(pet:GetWanderingArea())
    if room then
      room:PetLeaveWandering(tempID)
    end
  end
  self._elevator:TryRemovePet(pet)
  self._petManager:RemovePet(tempID)
  self._scheduleMng:Enqueue(tempID)
  self._naviManager:TryRemovePet(pet)
end

function AircraftMain:GetPetByCollider(collider)
  return self._petManager:GetPetByCollider(collider)
end

function AircraftMain:GetRoomBySpaceID(id)
  return self._sceneManager:GetRoomBySpaceID(id)
end

function AircraftMain:GetRoomGoSpaceID(id)
  return self._sceneManager:GetRoomGoSpaceID(id)
end

function AircraftMain:GetDoorBySpaceID(id)
  return self._sceneManager:GetDoorBySpaceID(id)
end

function AircraftMain:SetOneRoomUIActive(spaceID, active)
  self._sceneManager:SetOneRoomUIActive(spaceID, active)
end

function AircraftMain:RefreshRestRoom(spaceID)
  self._sceneManager:RefreshRoom(spaceID)
end

function AircraftMain:Set3DUIActive(active)
  self._sceneManager:Set3DUIActive(active)
end

function AircraftMain:RefreshScene()
  self._sceneManager:RefreshSpaces()
end

function AircraftMain:RefreshRoom3DUI(spaceID)
  self._sceneManager:RefreshOneRoomUI(spaceID)
end

function AircraftMain:OnClickRoom(results)
  self._sceneManager:ClickSpace(results)
end

function AircraftMain:OnClickPet(pet, petpoint)
  self._clickMng:OnClickPet(pet, petpoint)
end

function AircraftMain:GetAllBoards()
  return self._sceneManager:GetBoards()
end

function AircraftMain:GetPointHolder(area)
  return self._sceneManager:GetPointHolderByArea(area)
end

function AircraftMain:GetRoomTable()
  return self._sceneManager:GetRoomTable()
end

function AircraftMain:GetGatherPointHolder(area)
  return self._sceneManager:GetGatherPointHolderByArea(area)
end

function AircraftMain:GetRandomStoryPointHolder(area)
  return self._sceneManager:GetRandomStoryPointHolderByArea(area)
end

function AircraftMain:EnterAreaToWandering(pet, area)
  self._sceneManager:PetEnterAreaWandering(pet, area)
end

function AircraftMain:CanWanderingInArea(area)
  return not self._sceneManager:AreaIsFull(area)
end

function AircraftMain:GetAllRestRoom()
  return self._sceneManager:GetAllRestRoom()
end

function AircraftMain:AllRestRoomFull()
  local rooms = self._sceneManager:GetAllRestRoom()
  for _, room in ipairs(rooms) do
    if not room:IsBelongPetFull() then
      return false
    end
  end
  return true
end

function AircraftMain:GetInteractionRoot()
  return self._sceneManager:GetInteractionRoot()
end

function AircraftMain:GetInteractionPos()
  return self._sceneManager:GetInteractionPos()
end

function AircraftMain:GetInteractionText()
  return self._sceneManager:GetInteractionText()
end

function AircraftMain:GetRoomByArea(area)
  return self._sceneManager:GetRoomByArea(area)
end

function AircraftMain:LookRandomStoryCameraAnimStart(look, timeLength)
  self._cameraManager:LookRandomStoryCameraAnimStart(look, timeLength)
end

function AircraftMain:SelectSpace(spaceId, focus)
  self._sceneManager:SelectRoom(spaceId, focus)
end

function AircraftMain:ExitPosition()
  return self._sceneManager:ExitPointPos()
end

function AircraftMain:StartWorkingAction(pet)
  self._workingMng:StartWorking(pet)
end

function AircraftMain:PetStartWork(petID, spaceID)
  if self:IsGiftPet(petID) then
    AirLog("星灵正在送礼，不执行入住:", petID)
    return
  end
  AirLog("星灵入住，星灵id：", petID, "空间id：", spaceID)
  local pet = self:GetPetByTmpID(petID)
  if pet then
    self._elevator:TryRemovePet(pet)
    self._stairs:TryRemovePet(pet)
    self._socialMng:StopSocialByPet(pet)
  end
  self._workingMng:PetEnterSpaceToWork(petID, spaceID)
  self._scheduleMng:TryRemoveInQueue(petID)
end

function AircraftMain:PetStopWork(petID, spaceID)
  if self:IsGiftPet(petID) then
    AirLog("送礼星灵，不取消入住:", petID)
    return
  end
  if self:IsRandomStoryPet(petID) then
    return
  end
  local pet = self:GetPetByTmpID(petID)
  if pet then
    self._socialMng:OnPetDestroy(pet)
    self._elevator:TryRemovePet(pet)
    self._stairs:TryRemovePet(pet)
    self._naviManager:TryRemovePet(pet)
  end
  self._petManager:RemovePet(petID)
  self._scheduleMng:Enqueue(petID)
end

function AircraftMain:OnSpacePetChanged(spaceID)
  self._workingMng:OnSpacePetChanged(spaceID)
end

function AircraftMain:IsWorkingPet(petID)
  local pet = self._petManager:GetPet(petID)
  return pet and pet:IsWorkingPet()
end

function AircraftMain:RandomActionForPet(pet)
  self._randomActionMng:RandomActionForPet(pet)
end

function AircraftMain:RandomInitActionForPet(pet)
  self._randomActionMng:RandomInitActionForPet(pet)
end

function AircraftMain:Input()
  return self._inputManager
end

function AircraftMain:GetStoryIDByPetID(petid)
  return self._randomStoryMng:GetStoryIDByPetID(petid)
end

function AircraftMain:TriggerRandomStory(storyid, rewards, affinity)
  self._randomStoryMng:TriggerRandomStory(storyid, rewards, affinity)
end

function AircraftMain:AcceptPresent(pet)
  self._presentMng:AcceptPresent(pet)
end

function AircraftMain:AcceptVisitingPresent(pet)
  self._visitingMng:AcceptVisitingPresent(pet)
end

function AircraftMain:OnAcceptPresentEnd(petTemplateID)
  self._presentMng:OnAcceptPresentEnd(petTemplateID)
end

function AircraftMain:IsRandomStoryPet(petID)
  local pet = self._petManager:GetPet(petID)
  if pet and (pet:GetState() == AirPetState.RandomEvent or pet:GetState() == AirPetState.RandomEventWith) then
    return true
  end
  return false
end

function AircraftMain:IsGiftPet(petTemplateID)
  local pet = self._petManager:GetPet(petTemplateID)
  return pet and pet:IsGiftPet()
end

function AircraftMain:HasVisitGift(petTemplateID)
  local vPet = self._petManager:GetVisitPet(petTemplateID)
  return vPet and vPet:HasVisitGift()
end

function AircraftMain:IsVisitPet(petTemplateID)
  local vPet = self._petManager:GetVisitPet(petTemplateID)
  return vPet and vPet:IsVisitPet()
end

function AircraftMain:StartOneRandomEvent(storyid, noMove)
  self._randomStoryMng:StartOneRandomEvent(storyid, noMove)
end

function AircraftMain:RemoveOneRandomEvent(storyid)
  self._randomStoryMng:RemoveOneRandomEvent(storyid)
end

function AircraftMain:OnPetFinishStory(petID, storyType, storyID)
  AirLog("星灵结束一个随机剧情:", petID)
  local pet = self:GetPetByTmpID(petID)
  if not pet then
    Log.fatal("[AircraftMain] 星灵不在风船中，不能结束随机事件：", petID)
  end
  if storyType == EStoryTriggerType.UnlockRoom then
    local roomCfg = Cfg.cfg_aircraft_amusement_room({StoryEventId = storyID})[1]
    local roomID = Cfg.cfg_aircraft_room[roomCfg.ID].NextLevelID
    local module = GameGlobal.GetModule(AircraftModule)
    local room = module:GetRoomById(roomID)
    if not room then
      Log.exception("[AircraftMain] 找不到解锁的房间，剧情id：", storyID, "，房间ID：", roomID)
    end
    local spaceID = room:SpaceId()
    AirLog("剧情解锁房间，星灵id:", petID, "，storyID：", storyID, "，roomID:", roomCfg.ID, "，下一级roomid:", roomID, "，空间id：", spaceID)
    local anim = AirAnimRoomUnlock:New(self, spaceID, nil, false)
    anim:Play()
  end
  if pet:IsWorkingPet() then
    AirLog("随机剧情后，星灵走回工作房间:", pet:TemplateID(), "，空间:", pet:GetSpace())
    local action = AirActionMoveToWork:New(self, pet)
    pet:StartMainAction(action)
  elseif storyType == EStoryTriggerType.EnterAircraft then
    AirLog("随机剧情后，星灵走向出口:", pet:TemplateID())
    local action = AirActionMoveToLeave:New(pet, self)
    pet:StartMainAction(action)
  else
    self:RandomActionForPet(pet)
  end
end

function AircraftMain:CheckPetInRandomStory(pet)
  self._randomStoryMng:CheckPetInRandomStory(pet)
end

function AircraftMain:GetStoryPetByNeedPet(needpet)
  return self._randomStoryMng:GetStoryPetByNeedPet(needpet)
end

function AircraftMain:OnPetNaviBlocked(pet, moveAction)
  self._naviManager:OnPetBlocked(pet, moveAction)
end

function AircraftMain:ChangeGiftSending(state)
  self._clickMng:ChangeGiftSending(state)
end

function AircraftMain:AircraftOnSendGiftSuccess(lvup, love)
  self._clickMng:AircraftOnSendGiftSuccess(lvup, love)
end

function AircraftMain:StopInteraction()
  self._clickMng:StopInteraction()
end

function AircraftMain:GetMainCameraXZ()
  local x, z = self._cameraManager:GetPosXZ()
  return x, z
end

function AircraftMain:ForceRemoveInteractivePets(pstidList)
  self._clickMng:ForceRemoveInteractivePets(pstidList)
end

function AircraftMain:SendGiftRandomStory(storyid)
  self._clickMng:SendGiftRandomStory(storyid)
end

function AircraftMain:TryStopBlockHandler(pet)
  self._naviManager:TryRemovePet(pet)
end

function AircraftMain:FocusRoom(room, callBack, time)
  self._cameraManager:FocusRoom(room, callBack, time)
end

function AircraftMain:FocusRoomToAnimate(room, callBack, time)
  self._cameraManager:AnimFocusRoom(room, callBack, time)
end

function AircraftMain:FocusPet(pet, offset, callback, diyTime)
  if offset then
    self._cameraManager:FocusPet(pet:WorldPosition() + offset, callback, diyTime)
  else
    self._cameraManager:FocusPet(pet:WorldPosition(), callback, diyTime)
  end
end

function AircraftMain:MoveCameraToFar(callback)
  self._cameraManager:MoveToFarest(callback)
end

function AircraftMain:MoveToNavMenuPos(callback, movetime)
  self._cameraManager:MoveToNavMenuPos(callback, movetime)
end

function AircraftMain:GetCurrentCameraPos()
  return self._cameraManager:GetCurrentCameraPos()
end

function AircraftMain:GetNavMenuTargetCameraPos()
  return self._cameraManager:GetNavMenuTargetCameraPos()
end

function AircraftMain:MoveToPosNotTime(tpos, cb)
  self._cameraManager:MoveToPosNotTime(tpos, cb)
end

function AircraftMain:GetMainCamera()
  return self._cameraManager:GetCamera()
end

function AircraftMain:SetCameraToNavMenuPos()
  self._cameraManager:SetCameraToNavMenuPos()
end

function AircraftMain:GetFarPoint()
  return self._cameraManager:GetFarPoint()
end

function AircraftMain:GetDecorateViewPoint()
  return self._cameraManager:GetDecorateViewPoint()
end

function AircraftMain:ResetMainCamera()
  self._cameraManager:Reset()
end

function AircraftMain:CameraFocusPoint()
  return self._cameraManager:FocusPoint()
end

function AircraftMain:SetHudCameraActive(active)
  self._cameraManager:SetHudCameraActive(active)
end

function AircraftMain:NoticeSocialDecodeFinish()
  if self._socialMng then
    self._socialMng:DecodeFinish()
  end
end

function AircraftMain:StopSocialByPet(pet)
  self._socialMng:StopSocialByPet(pet)
end

function AircraftMain:GetSocialPetGroup(pet)
  return self._socialMng:GetSocialGroupPets(pet)
end

function AircraftMain:GotoSpace(spaceId, focus)
  self._sceneManager:SelectRoom(spaceId, focus)
end

function AircraftMain:GetBtnGuide(spaceId)
  return self._sceneManager:GetBtnGuide(spaceId)
end

function AircraftMain:SetGotoSpaceId(spaceId, param)
  self._sceneManager:SetGotoSpaceId(spaceId, param)
end

function AircraftMain:GuideGotoSpace(spaceId)
  self._sceneManager:GuideGotoSpace(spaceId)
end

function AircraftMain:TryBack()
  self._sceneManager:ClearCurrentRoom()
  return self._cameraManager:TryBack()
end

function AircraftMain:ClearCurrentRoom()
  self._sceneManager:ClearCurrentRoom()
end

function AircraftMain:SetJoyStick(stick, onStart, focus, onEnd)
  self._cameraManager:SetJoyStick(stick, onStart, focus, onEnd)
end

function AircraftMain:SetClickTexActive(active)
  self._interactivePoolManager:SetClickTexActive(active)
end

function AircraftMain:DequeueTexItem()
  return self._interactivePoolManager:DequeueTexItem()
end

function AircraftMain:EnqueueTexItem(item)
  self._interactivePoolManager:EnqueueTexItem(item)
end

function AircraftMain:Elevator()
  return self._elevator
end

function AircraftMain:GetStairTarget(floor)
  return self._stairs:GetMoveTarget(floor)
end

function AircraftMain:GetStairExit(floor)
  return self._stairs:GetStairExit(floor)
end

function AircraftMain:OnPetArriveStair(pet)
  self._stairs:OnPetArrive(pet)
end

function AircraftMain:GetRandomStoryTriggerCount()
  return self._randomStoryMng:GetRandomStoryTriggerCount()
end

function AircraftMain:GetRandomStoryPets()
  return self._randomStoryMng:GetRandomStoryPets()
end

function AircraftMain:CheckAirNavMenuCanActive()
  return self._cameraManager:CheckAirNavMenuCanActive()
end

function AircraftMain:GetFurniture(type)
  return self._decorateMng:GetFurnitureByType(type)
end

function AircraftMain:GetFurnitureByID(id)
  return self._decorateMng:GetFurnitureByID(id)
end

function AircraftMain:GetFurnitureByKey(key)
  return self._decorateMng:GetFurnitureByKey(key)
end

function AircraftMain:RefreshAreaBySpace(spaceID)
  self._decorateMng:RefreshArea(spaceID)
end

function AircraftMain:RefreshAreaSurfacesBySpaceID(spaceID)
  self._decorateMng:RefreshAreaSurfaces(spaceID)
end

function AircraftMain:GetFurnituresBySpace(spaceID)
  return self._decorateMng:GetFurnitureBySpaceID(spaceID)
end

function AircraftMain:OnFurnituresDestroy(furInsIDs)
  for _, insId in pairs(furInsIDs) do
    self._socialMng:StopSocialByFurniture(insId)
    local pets = self._petManager:GetPets(function(p)
      local pet = p
      if pet:GetOccupyFurniture() == insId then
        return true
      end
    end)
    for _, pet in ipairs(pets) do
      self._randomActionMng:RandomActionForPet(pet)
      self._naviManager:TryRemovePet(pet)
    end
  end
end

function AircraftMain:GetFurnituresByArea(area)
  return self._decorateMng:GetFurnituresByArea(area)
end

function AircraftMain:DeletePet(petID)
  AirLog("删除星灵：", petID)
  local pet = self:GetPetByTmpID(petID)
  if pet then
    local petState = pet:GetState()
    if petState == AirPetState.RandomEvent or petState == AirPetState.RandomEventWith or pet:IsGiftPet() then
      return
    end
    self._elevator:TryRemovePet(pet)
    self._stairs:TryRemovePet(pet)
    self._socialMng:OnPetDestroy(pet)
    self._naviManager:TryRemovePet(pet)
    self._petManager:RemovePet(petID)
  end
  self._scheduleMng:TryRemoveInQueue(petID)
end

function AircraftMain:PushInQueue(id)
  AirLog("星灵加入队列", id)
  self._scheduleMng:PushInQueue(id)
end

function AircraftMain:IsDispatchPet(id)
  local aircraftModule = GameGlobal.GetModule(AircraftModule)
  return aircraftModule:IsPetDispatch(id)
end

function AircraftMain:SetCamNearbyState(state)
  self._socialMng:SetCamNearbyState(state)
end

function AircraftMain:GetCamNearbyState()
  return self._socialMng:GetCamNearbyState()
end

function AircraftMain:ChangeInteractiveTimeOut(timeOut)
  self._clickMng:ChangeInteractiveTimeOut(timeOut)
end

function AircraftMain:GetRoomCanBuildForNav(spaceid)
  return self._sceneManager:GetRoomCanBuildForNav(spaceid)
end

function AircraftMain:AcceptAllPresent(pets, visitPets, callback)
  self._visitingMng:AcceptAllPresent(pets, visitPets, callback)
end
