_class("UIAircraftController", UIController)
UIAircraftController = UIAircraftController

function UIAircraftController:OnShow(uiParams)
  AirLog("UIAircraftController OnShow Start")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIAircraft)
  self.guideFingerOffset = Vector3(0, 300, 0)
  self.fingerShow = false
  self.sceneRes = uiParams[1]
  self._module = self:GetModule(AircraftModule)
  self:Init(uiParams)
  UIBgmHelper.PlyAircraftBgm()
  if self._main ~= nil then
    self.active = true
  end
  self:RefrshEasyEntryBtns()
  AirLog("UIAircraftController OnShow Done")
end

function UIAircraftController:RefrshEasyEntryBtns()
  local makeState = self._module:GetRoomStatus(AirRoomType.SmeltRoom)
  local lock = not makeState or makeState < SpaceState.SpaceStateFull
  self._btnMake:SetActive(not lock)
  local sendState = self._module:GetRoomStatus(AirRoomType.DispatchRoom)
  local lock = not sendState or sendState < SpaceState.SpaceStateFull
  self._btnSend:SetActive(not lock)
  if not lock then
    self:RefreshEasyBtnsRed()
  end
end

function UIAircraftController:RefreshEasyBtnsRed()
  local redCount = self:CalcDispachRoomRedCount()
  self._sendRed:SetActive(0 < redCount)
  if 0 < redCount then
    self._txtSendRedNum:SetText(redCount)
  end
end

function UIAircraftController:CalcDispachRoomRedCount()
  local room = self._module:GetRoomWithType(AirRoomType.DispatchRoom)
  if not room then
    return 0
  end
  local dispatchCount = room:GetDispatchCount()
  local dispatchTeamCount = room:GetDispatchTeamCount()
  local roomCfg = room:GetRoomConfig()
  local lessTeamCount = roomCfg.TeamMax - dispatchTeamCount
  local lessPetCount = math.modf(table.count(room:GetDispatchPetList()) / 5 + 0.05)
  local showNumber = dispatchCount
  if lessTeamCount < showNumber then
    showNumber = lessTeamCount
  end
  if lessPetCount < showNumber then
    showNumber = lessPetCount
  end
  if room:HasCompleteTask() or 0 < showNumber then
    local addCount = room:GetCompleteCount()
    showNumber = showNumber + addCount
  end
  return showNumber
end

function UIAircraftController:Init(uiParams)
  AirLog("UIAircraftController Init Start")
  self._guideFingerRect = self:GetUIComponent("RectTransform", "guideFinger")
  self:ShowGuideFinger(false)
  self._fullGo = self:GetGameObject("Full")
  self._blackMask = self:GetGameObject("mask")
  self._btnDecorate = self:GetGameObject("BtnDecorate")
  self._randomStoryBlackMask = self:GetUIComponent("Image", "randomStoryBlackMask")
  self._topBarLoader = self:GetUIComponent("UISelectObjectPath", "TopBarLoader")
  self._enterInteractiveLoader = self:GetUIComponent("UISelectObjectPath", "EnterInteractiveRoot")
  self._interactiveLoader = self:GetUIComponent("UISelectObjectPath", "InteractiveRoot")
  self._roomUILoader = self:GetUIComponent("UISelectObjectPath", "RoomUI")
  self._giftBtn = self:GetGameObject("giftBtn")
  self._giftNumber = self:GetUIComponent("UILocalizationText", "giftNumber")
  self._giftFillAmount = self:GetUIComponent("Image", "giftFillAmount")
  self._petHeadIcon = self:GetUIComponent("RawImageLoader", "petHead")
  self._petNameTex = self:GetUIComponent("UILocalizationText", "petName")
  self._btnMake = self:GetGameObject("btnMake")
  self._btnSend = self:GetGameObject("btnSend")
  self._sendRed = self:GetGameObject("sendRed")
  self._easyBtns = self:GetGameObject("easyBtns")
  self._txtSendRedNum = self:GetUIComponent("UILocalizationText", "txtSendRedNum")
  self._uiRoot = self:GetGameObject("uianim")
  self._topBar = self._topBarLoader:SpawnObject("UIAircraftTopBarItem")
  self._topBar:SetData(true, function()
    self:OnBack()
  end, function()
    local param = "UIAircraftController"
    if self._roomUI and self._roomUI:IsClosed() == false then
      local data = self._roomUI:GetRoomData()
      if data then
        local roomType = data:GetRoomType()
        if roomType == AirRoomType.AisleRoom then
        elseif roomType == AirRoomType.CentralRoom then
          param = "UIAircraftCentralRoom"
        elseif roomType == AirRoomType.PowerRoom then
          param = "UIAircraftPowerRoom"
        elseif roomType == AirRoomType.MazeRoom then
          param = "UIAircraftMazeRoom"
        elseif roomType == AirRoomType.ResourceRoom then
          param = "UIAircraftResourceRoom"
        elseif roomType == AirRoomType.PrismRoom then
          param = "UIAircraftPrismRoom"
        elseif roomType == AirRoomType.TowerRoom then
          param = "UIAircraftTowerRoom"
        elseif roomType == AirRoomType.EvilRoom then
        elseif roomType == AirRoomType.PurifyRoom then
        elseif roomType == AirRoomType.SmeltRoom then
          param = "UIAircraftSmeltRoom"
        elseif roomType == AirRoomType.DispatchRoom then
          param = "UIDispatchDetailController"
        elseif roomType == AirRoomType.TacticRoom then
          param = "UIAircraftTactic"
        end
      end
    end
    self:ShowDialog("UIHelpController", param)
  end, true, false)
  self._enterInteractiveWidget = nil
  self._interactiveWidget = nil
  self.curRoomWidget = nil
  self._roomUI = nil
  self:registEvent()
  self:InitDataUpdater()
  self._main = self._module:GetClientMain()
  self._input = self._main:Input()
  local stick = self:InitJoyStick()
  local focusGo = self:GetGameObject("Focus")
  local focusText = self:GetUIComponent("UILocalizationText", "FocusText")
  focusGo:SetActive(false)
  
  local function focusStart()
    focusGo:SetActive(true)
  end
  
  local function focusing(t)
    focusText.text = string.format("%.1f", Mathf.Lerp(1, 10, 1 - t))
  end
  
  local function focusEnd()
    focusGo:SetActive(false)
  end
  
  self._main:SetJoyStick(stick, focusStart, focusing, focusEnd)
  local navMenuPool = self:GetUIComponent("UISelectObjectPath", "navMenu")
  self._navMenu = navMenuPool:SpawnObject("UIAirNavMenu")
  self._navMenuGo = self:GetGameObject("navMenu")
  self._navMenu:SetData(self._main, function(room, cb)
    self:FocusRoom(room, cb)
  end, function(airPet)
    self:FocusPet(airPet)
  end)
  Log.notice("[Aircraft] 风船Loading结束，显示UI")
  if GuideHelper.GuideInProgress() then
    self._main:MoveCameraToFar()
  elseif uiParams[2] then
    local paramType = uiParams[2]
    if paramType == OpenAircraftParamType.Spaceid then
      local param = uiParams[3]
      if param and param ~= 0 then
        self:SetGotoSpaceId(param, uiParams[4])
      end
    elseif paramType == OpenAircraftParamType.Petid then
      local focusPetTempId = uiParams[3]
      if focusPetTempId then
        local pet = self._main:GetPetByTmpID(focusPetTempId)
        if pet then
          self._main:FocusPet(pet, nil, function()
          end)
        else
          Log.error("no find pet in aircraft petid:", focusPetTempId)
        end
      end
    end
  end
  self._btnDecorate:SetActive(self._module:IsDecorateUnLocked())
  AirLog("UIAircraftController Init Done")
end

function UIAircraftController:registEvent()
  self:AttachEvent(GameEventType.AircraftRefreshMainUI, self.RefreshMainUI)
  self:AttachEvent(GameEventType.AircraftRefreshRoomUI, self.RefreshOneRoomUI)
  self:AttachEvent(GameEventType.AircraftRequestDataAndRefreshMainUI, self.RequestAndRefreshMainUI)
  self:AttachEvent(GameEventType.AircraftSettledPetChanged, self.OnCurrentRoomPetChanged)
  self:AttachEvent(GameEventType.SwitchToInteractiveView, self.SwitchToInteractiveView)
  self:AttachEvent(GameEventType.AircraftLeaveAircraft, self.CloseAircraft)
  self:AttachEvent(GameEventType.AircraftRefreshTopbar, self.RefreshTopBar)
  self:AttachEvent(GameEventType.PetDataChangeEvent, self.PetDataChangeEvent)
  self:AttachEvent(GameEventType.AircraftJumpOutTo, self.JumpOutTo)
  self:AttachEvent(GameEventType.AircraftShowRoomUI, self.ReqAndShowRoomUI)
  self:AttachEvent(GameEventType.AircraftOnPetClick, self.RefreshClickPet)
  self:AttachEvent(GameEventType.ForceRemoveInteractivePets, self.ForceRemoveInteractivePets)
  self:AttachEvent(GameEventType.AircraftCleanSpace, self.ShowSpcaceClean)
  self:AttachEvent(GameEventType.AircraftBuildRoom, self.BuildRoom)
  self:AttachEvent(GameEventType.AircraftSpeedUp, self.BuildOrUpgradeSpeedup)
  self:AttachEvent(GameEventType.AircraftChangeGiftSending, self.ChangeGiftSending)
  self:AttachEvent(GameEventType.AircraftOnSendGiftSuccess, self.AircraftOnSendGiftSuccess)
  self:AttachEvent(GameEventType.SendGiftRandomStory, self.SendGiftRandomStory)
  self:AttachEvent(GameEventType.AirStartOneRandomEvent, self.StartOneRandomEvent)
  self:AttachEvent(GameEventType.AircraftUILock, self.AircraftUILock)
  self:AttachEvent(GameEventType.AircraftTryStopClickAction, self.TryStopClickAction)
  self:AttachEvent(GameEventType.CloseSendGiftBtn, self.CloseSendGiftBtn)
  self:AttachEvent(GameEventType.OpenSendGiftDiaLog, self.OpenSendGiftDiaLog)
  self:AttachEvent(GameEventType.RandomStoryStartOrEnd, self.RandomStoryStartOrEnd)
  self:AttachEvent(GameEventType.AircraftPlayDoorAnim, self.PlayDoorAnim)
  self:AttachEvent(GameEventType.AircraftOpenRoom, self.AircraftOpenRoom)
  self:AttachEvent(GameEventType.AircraftMainMoveCameraToNavMenu, self.AircraftMainMoveCameraToNavMenu)
  self:AttachEvent(GameEventType.SetCameraToNavMenuPos, self.SetCameraToNavMenuPos)
  self:AttachEvent(GameEventType.RefreshNavMenuData, self.RefreshNavMenuData)
  self:AttachEvent(GameEventType.AircraftTacticRefreshTapeList, self.RefreshNavMenuData)
  self:AttachEvent(GameEventType.SetAircraftMainUI, self.SetMainUIActive)
  self:AttachEvent(GameEventType.AircraftDeletePet, self.AircraftDeletePet)
  self:AttachEvent(GameEventType.AircraftPushPetQueue, self.AircraftPushPetQueue)
  self:AttachEvent(GameEventType.UIAirNavMenuActive, self.UIAirNavMenuActive)
  self:AttachEvent(GameEventType.AircraftEnterDecorateMode, self.DoDerorate)
  self:AttachEvent(GameEventType.AircraftRefreshDecorateArea, self.RefreshDecorateArea)
  self:AttachEvent(GameEventType.AircraftTryRefreshRoomUI, self.TryRefreshRoomUI)
  self:AttachEvent(GameEventType.AircraftLeaveToBattle, self.LeaveToBattle)
end

function UIAircraftController:AircraftDeletePet(templateId)
  self._main:DeletePet(templateId)
end

function UIAircraftController:AircraftPushPetQueue(templateId)
  self._main:PushInQueue(templateId)
end

function UIAircraftController:InitJoyStick()
  local eventListener = self:GetUIComponent("UIEventTriggerListener", "joyStick")
  local image = self:GetUIComponent("Image", "Viewport")
  local content = self:GetUIComponent("RectTransform", "Content")
  local resetBtn = self:GetGameObject("ResetButton")
  local atlas = self:GetAsset("UIAircraftMainUI.spriteatlas", LoadType.SpriteAtlas)
  local normal = atlas:GetSprite("wind_tongyong_btn4")
  local drag = atlas:GetSprite("wind_tongyong_btn5")
  return UIAircraftJoyStick:New(eventListener, image, normal, drag, content, resetBtn)
end

function UIAircraftController:CloseSendGiftBtn()
  self._giftBtn:SetActive(false)
end

function UIAircraftController:SendGiftRandomStory(storyid)
  self._main:SendGiftRandomStory(storyid)
end

function UIAircraftController:SetMainUIActive(active)
  self._uiRoot:SetActive(active)
  if active then
    if self:CheckAirNavMenuCanActive() then
      self:UIAirNavMenuActive(true)
    end
  else
    self:UIAirNavMenuActive(false)
  end
end

function UIAircraftController:OnHide()
  self.sceneRes:Dispose()
  GameGlobal.Timer():CancelEvent(self.d_dataUpdater)
  self.d_dataUpdater = nil
end

function UIAircraftController:AircraftUILock(lock, lockName)
  if lock then
    self:Lock(lockName)
  else
    self:UnLock(lockName)
  end
end

function UIAircraftController:JumpOutTo(func)
  self:CloseAircraft()
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI", func)
end

function UIAircraftController:LeaveAircraft()
  self:CloseAircraft()
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI")
end

function UIAircraftController:LeaveToBattle()
  AirLog("进局析构风船逻辑")
  self:CloseAircraft()
  self._main:Dispose()
  self._main = nil
  self._module:SetClientMain(nil)
  self._module:PushLeaveAircraft()
end

function UIAircraftController:OnUpdate(deltaTimeMS)
  if not self.active then
    return
  end
  self._main:Update(deltaTimeMS)
  if self._interactiveWidget ~= nil and self._interactiveWidget:GetGameObject().activeInHierarchy then
    self._interactiveWidget:Update(deltaTimeMS)
  end
  if self.fingerShow then
    local petTrans = self:GetPetTransform()
    if petTrans then
      local pos = self:ConvertPos(petTrans)
      self._guideFingerRect.anchoredPosition = pos
    end
  end
  if self._navMenu then
    self._navMenu:Update(deltaTimeMS)
  end
end

function UIAircraftController:ConvertPos(petTrans)
  local camera = self._main:GetMainCamera()
  local screenPos = camera:WorldToScreenPoint(petTrans.position) + self.guideFingerOffset
  local sw = ResolutionManager.ScreenWidth()
  local rw = ResolutionManager.RealWidth()
  local factor = rw / sw
  local sx, sy = screenPos.x * factor, screenPos.y * factor
  screenPos = Vector2(sx, sy)
  return screenPos
end

function UIAircraftController:ShowGuideFinger(show)
  if self.isShowFinger ~= nil and self.isShowFinger == show then
    return
  end
  self.isShowFinger = show
  self._guideFingerRect.gameObject:SetActive(self.isShowFinger)
  if self.isShowFinger == false then
    self.petKey = nil
  end
end

function UIAircraftController:ShowPetSelectedUI(room, targetPet)
  if self._enterInteractiveWidget == nil then
    self._enterInteractiveWidget = self._enterInteractiveLoader:SpawnObject("UIAircraftRoomEnterInteractiveItem")
  end
  self._enterInteractiveWidget:Refresh(self, room, targetPet)
  self._enterInteractiveWidget:GetGameObject():SetActive(true)
end

function UIAircraftController:ShowInteractiveUI(room, targetPet)
  if self._interactiveWidget == nil then
    self._interactiveWidget = self._interactiveLoader:SpawnObject("UIAircraftRoomInteractiveItem")
  end
  self._interactiveWidget:Refresh(room, targetPet)
  self._interactiveWidget:GetGameObject():SetActive(true)
  self:CheckGuideFinger(targetPet)
  self.fingerShow = true
end

function UIAircraftController:SwitchToInteractiveView(room, targetPet)
  local topBarGo = self:GetGameObject("TopBarLoader")
  if topBarGo then
    topBarGo:SetActive(false)
  end
  local centerRoomGo = self:GetGameObject("RoomUI")
  if centerRoomGo then
    centerRoomGo:SetActive(false)
  end
end

function UIAircraftController:InteractiveViewSwitchToRoomView(room, targetPet)
  self.fingerShow = false
  self.isShowFinger = false
  self._guideFingerRect.gameObject:SetActive(false)
end

function UIAircraftController:InteractiveViewSwitchToRoomViewComplete()
  local topBarGo = self:GetGameObject("TopBarLoader")
  if topBarGo then
    topBarGo:SetActive(true)
  end
  local centerRoomGo = self:GetGameObject("RoomUI")
  if centerRoomGo then
    centerRoomGo:SetActive(true)
  end
end

function UIAircraftController:CloseAircraft()
  if not self.active then
    Log.fatal("already close aircraft")
    return
  end
  self.active = false
  self:DetachAllEvents()
end

function UIAircraftController:OnBack()
  if self._main:TryBack() then
    self:LeaveAircraft()
  end
end

function UIAircraftController:ReqAndShowRoomUI(spaceID)
  if spaceID == nil then
    if self._roomUI and not self._roomUI:IsClosed() then
      self._roomUI:Close()
      if self:CheckAirNavMenuCanActive() then
        self:UIAirNavMenuActive(true)
      end
      self._blackMask:SetActive(false)
      if self._module:IsDecorateUnLocked() then
        self._btnDecorate:SetActive(true)
      end
    end
    return
  end
  GameGlobal.TaskManager():StartTask(self.ReqData, self, function()
    if self.active then
      local navMenuTempData = self:GetNavMenuData()
      self:ShowRoomUI(spaceID, true, navMenuTempData)
      if navMenuTempData ~= nil then
        self:SetNavMenuData(nil)
      end
    end
  end)
end

function UIAircraftController:SetNavMenuData(data)
  self._navMenuTempData = data
end

function UIAircraftController:GetNavMenuData()
  return self._navMenuTempData
end

function UIAircraftController:SelectAndFocusRoom(spaceid)
  self._main:GotoSpace(spaceid, true)
  self._main:GotoSpace(spaceid, true)
end

function UIAircraftController:SelectRoom(spaceid)
  self._main:GotoSpace(spaceid, false)
end

function UIAircraftController:RefreshClickPet(pstid)
  if not pstid then
    self._giftBtn:SetActive(false)
    return
  end
  local petModule = self:GetModule(PetModule)
  self._clickPet = petModule:GetPet(pstid)
  if self._clickPet then
    self._giftBtn:SetActive(true)
    local realLevel = self._clickPet:GetPetAffinityLevel()
    local realExp = self._clickPet:GetPetAffinityExp()
    local realMaxExp = self._clickPet:GetPetAffinityMaxExp(realLevel)
    local maxAffinityMaxLevel = self._clickPet:GetPetAffinityMaxLevel()
    local curExp = realExp - Cfg.cfg_pet_affinity_exp[realLevel].NeedAffintyExp
    local percent = curExp / realMaxExp
    if realLevel >= maxAffinityMaxLevel then
      percent = 1
    end
    local value = percent
    self._giftFillAmount.fillAmount = value
    self._petHeadIcon:LoadImage(self._clickPet:GetPetHead(PetSkinEffectPath.HEAD_AIRCRAFT_INTERACT))
    self._petNameTex:SetText(StringTable.Get(self._clickPet:GetPetName()))
    local number = realLevel
    self._giftNumber:SetText(number)
  else
    self._giftBtn:SetActive(false)
  end
end

function UIAircraftController:giftBtnOnClick()
  self:ChangeGiftSending(true)
  self:OpenSendGiftDiaLog()
end

function UIAircraftController:OpenSendGiftDiaLog()
  self:ShowDialog("UIAircraftSendGiftController", self._clickPet)
end

function UIAircraftController:ChangeGiftSending(state)
  self._fullGo:SetActive(not state)
  self._main:ChangeGiftSending(state)
end

function UIAircraftController:AircraftOnSendGiftSuccess(lvup, love)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGiveGift)
  self._main:AircraftOnSendGiftSuccess(lvup, love)
  if self._clickPet then
    local realLevel = self._clickPet:GetPetAffinityLevel()
    local realExp = self._clickPet:GetPetAffinityExp()
    local realMaxExp = self._clickPet:GetPetAffinityMaxExp(realLevel)
    local maxAffinityMaxLevel = self._clickPet:GetPetAffinityMaxLevel()
    local curExp = realExp - Cfg.cfg_pet_affinity_exp[realLevel].NeedAffintyExp
    local percent = curExp / realMaxExp
    if realLevel >= maxAffinityMaxLevel then
      percent = 1
    end
    local value = percent
    self._giftFillAmount.fillAmount = value
    local number = realLevel
    self._giftNumber:SetText(number)
  end
end

function UIAircraftController:ReqData(TT, callBack)
  self:Lock(self:GetName())
  local ack = self._module:AircraftUpdate(TT)
  if ack:GetSucc() then
    callBack()
  else
    ToastManager.ShowToast(self._module:GetErrorMsg(ack:GetResult()))
  end
  self:UnLock(self:GetName())
end

function UIAircraftController:RequestAndRefreshMainUI()
  Log.notice("Request aircraft data")
  GameGlobal.TaskManager():StartTask(self.ReqData, self, function()
    if self.active then
      self:RefreshMainUI()
    end
  end)
end

function UIAircraftController:RefreshMainUI()
  Log.notice("Refresh aircraft main ui")
  self._main:RefreshScene()
  self:RefreshNavMenuData()
  self:RefrshEasyEntryBtns()
end

function UIAircraftController:RefreshOneRoomUI(_spaceId)
  self._main:RefreshRoom3DUI(_spaceId)
end

function UIAircraftController:ShowRoomUI(spaceID, _closeInfoWindow, navMenuTempData)
  local logicRoomData = self._module:GetRoom(spaceID)
  if logicRoomData == nil then
    return
  end
  if self._roomUI == nil then
    self._roomUI = self._roomUILoader:SpawnObject("UIAircraftRoomItem")
  end
  self._roomUI:Close()
  self._roomUI:Refresh(logicRoomData, _closeInfoWindow)
  self:UIAirNavMenuActive(false)
  self._blackMask:SetActive(true)
  self._btnDecorate:SetActive(false)
  self._easyBtns:SetActive(false)
  if navMenuTempData ~= nil then
    self:Lock("UIAircraftController:ShowRoomUI")
    GameGlobal.Timer():AddEvent(440, function()
      self:UnLock("UIAircraftController:ShowRoomUI")
      if navMenuTempData ~= nil then
        if navMenuTempData == 1 then
          self._roomUI:OpenEnterBuild()
        elseif navMenuTempData == 2 then
          self._roomUI:OpenLvUp()
        end
      end
    end)
  end
end

function UIAircraftController:PetDataChangeEvent()
  self:CheckGuideFinger()
end

function UIAircraftController:CheckGuideFinger(targetPet)
end

function UIAircraftController:GetPetTransform()
end

function UIAircraftController:OnCurrentRoomPetChanged()
  local spaceID = self._roomUI:SpaceID()
  self._main:OnSpacePetChanged(spaceID)
  if self._roomUI then
    local data = self._module:GetRoom(spaceID)
    if data then
      self._roomUI:Refresh(data, false)
    end
    self:UIAirNavMenuActive(false)
    self._blackMask:SetActive(true)
    self._btnDecorate:SetActive(false)
  end
end

function UIAircraftController:SetTopBarActive(active)
  self._topBar:GetGameObject():SetActive(active)
end

function UIAircraftController:RefreshTopBar()
  self._topBar:RefreshAllMsg()
end

function UIAircraftController:ShowSpcaceClean(_spaceId)
  if self._roomUI and not self._roomUI:IsClosed() then
    self._roomUI:Close()
    if self:CheckAirNavMenuCanActive() then
      self:UIAirNavMenuActive(true)
    end
    self._blackMask:SetActive(false)
    if self._module:IsDecorateUnLocked() then
      self._btnDecorate:SetActive(true)
    end
  end
  self:StartTask(self.RequestCleanSpace, self, _spaceId)
end

function UIAircraftController:RequestCleanSpace(TT, spaceID)
  self:Lock(self:GetName())
  local _module = self._module
  local roomType = _module:GetBuildType(spaceID)[1]
  if roomType == AirRoomType.AisleRoom then
    Log.notice("[Aircraft] 建造过道，先请求清理")
    local cleanRes, msg = _module:RequestCleanSpace(TT, spaceID)
    if not cleanRes:GetSucc() then
      ToastManager.ShowToast(_module:GetErrorMsg(cleanRes:GetResult()))
      self:UnLock(self:GetName())
      return
    end
    Log.notice("[Aircraft] 建造过道，清理成功，请求建造")
    local roomCfg = Cfg.cfg_aircraft_room({RoomType = roomType, Level = 1})
    local roomID = roomCfg[1].ID
    local buildRes = _module:RequestBuildRoom(TT, spaceID, roomID)
    if not buildRes:GetSucc() then
      ToastManager.ShowToast(_module:GetErrorMsg(buildRes:GetResult()))
      self:UnLock(self:GetName())
      return
    end
    Log.notice("[Aircraft] 建造过道成功，刷新UI")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRequestDataAndRefreshMainUI)
    local showDialog = false
    if #msg.asset > 0 then
      for _, value in ipairs(msg.asset) do
        if 0 < value.count then
          showDialog = true
        end
      end
    end
    if showDialog then
      self:ShowDialog("UIGetItemController", msg.asset)
    end
    ToastManager.ShowToast(StringTable.Get("str_aircraft_clean_success"))
  else
    Log.notice("[Aircraft] 清理房间，ID: ", spaceID)
    local cleanRes, msg = _module:RequestCleanSpace(TT, spaceID)
    if not cleanRes:GetSucc() then
      ToastManager.ShowToast(_module:GetErrorMsg(cleanRes:GetResult()))
      self:UnLock(self:GetName())
      return
    end
    Log.notice("[Aircraft]  清理房间成功，ID: ", spaceID)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRequestDataAndRefreshMainUI)
    local showDialog = false
    if #msg.asset > 0 then
      for _, value in ipairs(msg.asset) do
        if 0 < value.count then
          showDialog = true
        end
      end
    end
    if showDialog then
      self:ShowDialog("UIGetItemController", msg.asset)
    end
    ToastManager.ShowToast(StringTable.Get("str_aircraft_clean_success"))
  end
  self:UnLock(self:GetName())
end

function UIAircraftController:InitDataUpdater()
  local d_curFireFly = math.floor(self._module:GetFirefly())
  local d_atom = GameGlobal.GetModule(RoleModule):GetAtom()
  self.d_dataUpdater = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    local roleModule = GameGlobal.GetModule(RoleModule)
    local airModule = GameGlobal.GetModule(AircraftModule)
    if roleModule == nil or airModule == nil or airModule:GetAircraftInfo() == nil then
      return
    end
    local curFire = math.floor(airModule:GetFirefly())
    if curFire ~= d_curFireFly then
      d_curFireFly = curFire
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftOnFireFlyChanged)
    end
    if airModule:GetSmeltRoom() then
      local count = roleModule:GetAtom()
      if count ~= d_atom then
        d_atom = count
        GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftOnAtomChanged)
      end
    end
  end)
end

function UIAircraftController:RandomStoryStartOrEnd(look, timeLength)
  if look then
    self._randomStoryBlackMask.gameObject:SetActive(true)
    self._randomStoryBlackMask:DOColor(Color(0, 0, 0, 1), timeLength * 0.001)
  else
    self._randomStoryBlackMask.color = Color(0, 0, 0, 0)
    self._randomStoryBlackMask.gameObject:SetActive(false)
  end
end

function UIAircraftController:StartOneRandomEvent(storyid)
  self._main:StartOneRandomEvent(storyid)
end

function UIAircraftController:BuildRoom(_spaceId)
  if self._roomUI and not self._roomUI:IsClosed() then
    self._roomUI:Close()
    if self:CheckAirNavMenuCanActive() then
      self:UIAirNavMenuActive(true)
    end
    self._blackMask:SetActive(false)
    if self._module:IsDecorateUnLocked() then
      self._btnDecorate:SetActive(true)
    end
  end
  self:ShowDialog("UIAircraftBuildRoomController", _spaceId)
end

function UIAircraftController:BuildOrUpgradeSpeedup(spaceID, option)
  if self._roomUI and not self._roomUI:IsClosed() then
    self._roomUI:Close()
    if self:CheckAirNavMenuCanActive() then
      self:UIAirNavMenuActive(true)
    end
    self._blackMask:SetActive(false)
    if self._module:IsDecorateUnLocked() then
      self._btnDecorate:SetActive(true)
    end
  end
  self:ShowDialog("UIAircraftFireflySpeedupController", spaceID, option)
end

function UIAircraftController:FocusRoom(room, cb)
  self._main:FocusRoom(room, cb)
end

function UIAircraftController:FocusPet(airPet)
  self._main:FocusPet(airPet)
end

function UIAircraftController:SetGotoSpaceId(spaceId, param)
  self._main:SetGotoSpaceId(spaceId, param)
end

function UIAircraftController:GetFireIcon()
  return self._topBar and self._topBar.fireFlyItem:GetGameObject()
end

function UIAircraftController:GetStarIcon()
  return self._topBar and self._topBar.energyItem:GetGameObject()
end

function UIAircraftController:GetRoomLeftBottom()
  return self._roomUI and self._roomUI:GetRoomInfoGameobject()
end

function UIAircraftController:GetRoomInfoBtnFacility()
  return self._roomUI and self._roomUI._roomInfo and self._roomUI._roomInfo:GetGameObject("ButtonFacility")
end

function UIAircraftController:GetRoomInfoBtnSettle()
  return self._roomUI and self._roomUI._roomInfo and self._roomUI._roomInfo:GetGameObject("ButtonSettle")
end

function UIAircraftController:GetRoomInfoAddCell(index)
  return self._roomUI and self._roomUI._roomInfo and self._roomUI._roomInfo:GetItem(index)
end

function UIAircraftController:GetRoomInfoBtnLevelUp()
  return self._roomUI and self._roomUI._roomInfo and self._roomUI._roomInfo:GetGameObject("ButtonLevelUp")
end

function UIAircraftController:ForceRemoveInteractivePets(pstidList)
  self._main:ForceRemoveInteractivePets(pstidList)
end

function UIAircraftController:TryStopClickAction()
  self._main:StopInteraction()
end

function UIAircraftController:AircraftOpenRoom(type, spaceid, param)
  if type == OpenAircraftParamType.Spaceid then
    self:SetGotoSpaceId(spaceid, param)
  end
end

function UIAircraftController:PlayDoorAnim(operate, spaceID)
  local anim = AirAnimRoomOperate:New(self._main, operate, spaceID, nil)
  anim:Play()
  self._main:RefreshAreaSurfacesBySpaceID(spaceID)
end

function UIAircraftController:AircraftMainMoveCameraToNavMenu(cb, movetime)
  self._main:MoveToNavMenuPos(cb, movetime)
end

function UIAircraftController:GetCurrentCameraPos()
  return self._main:GetCurrentCameraPos()
end

function UIAircraftController:GetNavMenuTargetCameraPos()
  return self._main:GetNavMenuTargetCameraPos()
end

function UIAircraftController:SetCameraToNavMenuPos()
  self._main:SetCameraToNavMenuPos()
end

function UIAircraftController:RefreshNavMenuData()
  self._navMenu:RefreshData()
  self:RefreshEasyBtnsRed()
end

function UIAircraftController:GetAirCamera3D()
  return self._main:GetMainCamera()
end

function UIAircraftController:GetAirCamera2D()
  return GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
end

function UIAircraftController:AircraftMainGetStroyPets()
  return self._main:GetRandomStoryPets()
end

function UIAircraftController:AircraftMainGetAirPetByID(id)
  return self._main:GetPetByTmpID(id)
end

function UIAircraftController:ClearCurrentRoom()
  self._main:ClearCurrentRoom()
end

function UIAircraftController:UIAirNavMenuActive(active)
  if active == true then
    if self._roomUI and not self._roomUI:IsClosed() then
      return
    else
      self._navMenuGo:SetActive(true)
      self._navMenu:ResetIconPos()
      self._easyBtns:SetActive(true)
    end
  else
    self._navMenuGo:SetActive(false)
  end
end

function UIAircraftController:CheckAirNavMenuCanActive()
  return self._main:CheckAirNavMenuCanActive()
end

function UIAircraftController:BtnDecorateOnClick()
  self:DoDerorate(nil)
end

function UIAircraftController:BtnMakeOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIAircraftItemSmeltController")
end

function UIAircraftController:BtnSendOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIDispatchMapController", true)
end

function UIAircraftController:DoDerorate(spaceID)
  self._main:ChangeMode(AircraftMode.Decorate, spaceID)
end

function UIAircraftController:RefreshDecorateArea(space)
  self._main:RefreshAreaBySpace(space)
end

function UIAircraftController:TryRefreshRoomUI(spaceID, forceReq)
  if self._roomUI == nil then
    return
  end
  if self._roomUI:IsClosed() then
    return
  end
  if forceReq then
    GameGlobal.TaskManager():StartTask(self.ReqData, self, function()
      self:ShowRoomUI(spaceID, false, nil)
    end)
  else
    self:ShowRoomUI(spaceID, false, nil)
  end
end

local OpenAircraftParamType = {Spaceid = 1, Petid = 2}
_enum("OpenAircraftParamType", OpenAircraftParamType)

function UIAircraftController:GetBackBtn()
  return self._topBar.topButtonWidget:GetGameObject("ButtonBack")
end

function UIAircraftController:GetHomeBtn()
  return self._topBar.topButtonWidget:GetGameObject("ButtonThumb")
end

function UIAircraftController:GetRoomInfoDecorateBtn()
  if self._roomUI then
    return self._roomUI:GetDecorateBtn()
  else
    return nil
  end
end

_class("AircraftLevelUpPreCondition", Object)
AircraftLevelUpPreCondition = AircraftLevelUpPreCondition

function AircraftLevelUpPreCondition:Constructor(type, level, need, had)
  self.Type = type
  self.Level = level
  self.Need = need
  self.Had = had
end
