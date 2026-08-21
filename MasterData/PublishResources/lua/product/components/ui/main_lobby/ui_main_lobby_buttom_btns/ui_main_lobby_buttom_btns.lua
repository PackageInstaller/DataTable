_class("UIMainLobbyButtomBtns", UICustomWidget)
UIMainLobbyButtomBtns = UIMainLobbyButtomBtns

function UIMainLobbyButtomBtns:OnShow()
  self._shopModule = GameGlobal.GetModule(ShopModule)
  local shopPool = self:GetUIComponent("UISelectObjectPath", "shop")
  self.shop = shopPool:SpawnObject("UIMainLobbyFinalShopBtn")
  self._backPackRedGO = self:GetGameObject("backpack_red")
  self._talePetModule = GameGlobal.GetModule(TalePetModule)
  self._questRed = self:GetGameObject("questRed")
  self:AttachEvent(GameEventType.QuestUpdate, self.QuestInfo)
  self:AttachEvent(GameEventType.OnAchievePointFinish, self.QuestInfo)
  self:AttachEvent(GameEventType.AircraftRedPoint, self.CheckAircraftRed)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.QuestInfo)
  self:AttachEvent(GameEventType.NoticeBackPackRed, self.CheckBackPackNew)
  self._aircraftAwardCountGo = self:GetGameObject("baseRed")
  self:AttachEvent(GameEventType.TalePetRedStatusChange, self.TalePetRedPointController)
  self:AttachEvent(GameEventType.TalePetInfoDataChange, self.ChangeTaleInfo)
  self.talePetRedPoint = self:GetGameObject("talePetRedPoint")
  self.canConvene = self:GetGameObject("canConvene")
  self.canConceneImg = self:GetUIComponent("RawImageLoader", "canConvene")
  self.canConceneRaw = self:GetUIComponent("RawImage", "canConvene")
  self.canConceneAnim = self:GetUIComponent("Animation", "canConvene")
  self._educationRedPoint = self:GetUIComponent("RectTransform", "educationRedPoint")
  self._btnEducation = self:GetUIComponent("UISelectObjectPath", "btnEducation")
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_TalePet)
  if isLock == false then
    local IsCanDo = self._talePetModule:IsCanDo()
    if IsCanDo then
      if self._showTaleUI then
        GameGlobal.Timer():CancelEvent(self._showTaleUI)
      end
      self._showTaleUI = GameGlobal.Timer():AddEvent(800, function()
        self:RefreshCanConvene()
      end)
    end
  end
  local s = self:GetUIComponent("UISelectObjectPath", "BtnTalePet")
  local talePetButtonFunction = s:SpawnObject("UIMainLobbyLockBtn")
  talePetButtonFunction:SetFunctionType(GameModuleID.MD_TalePet)
  self:SetDragEvent()
end

function UIMainLobbyButtomBtns:SetDragEvent()
  local TeamBtn = self:GetGameObject("TeamBtn")
  local QuestBtn = self:GetGameObject("QuestBtn")
  local BackpackBtn = self:GetGameObject("BackpackBtn")
  local BaseBtn = self:GetGameObject("BaseBtn")
  local BtnTalePet = self:GetGameObject("BtnTalePet")
  local BtnEducation = self:GetGameObject("btnEducation")
  local CloseBtn = self:GetGameObject("CloseImg")
  local OpenBtn = self:GetGameObject("OpenImg")
  self._closeImgCanG = self:GetUIComponent("CanvasGroup", "CloseImg")
  self._openImgCanG = self:GetUIComponent("CanvasGroup", "OpenImg")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._closeAnimName = "uieff_UIMainLobbyButtonBtns_close"
  self._openAnimName = "uieff_UIMainLobbyButtonBtns_open"
  self._enterAnimNameOpen = "uieff_UIMainLobbyButtonBtns_in"
  self._enterAnimNameClose = "uieff_UIMainLobbyButtonBtns_open_loop"
  self._dragDeltaWidth = 100
  self._dragDeltaHeight = 100
  self._isDrag = false
  self._isDragOpen = false
  self:AddUICustomEventListener(UICustomUIEventListener.Get(QuestBtn), UIEvent.BeginDrag, function(eventData)
    self:BeginDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(QuestBtn), UIEvent.EndDrag, function(eventData)
    self:EndDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(BackpackBtn), UIEvent.BeginDrag, function(eventData)
    self:BeginDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(BackpackBtn), UIEvent.EndDrag, function(eventData)
    self:EndDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(BaseBtn), UIEvent.BeginDrag, function(eventData)
    self:BeginDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(BaseBtn), UIEvent.EndDrag, function(eventData)
    self:EndDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(BtnTalePet), UIEvent.BeginDrag, function(eventData)
    self:BeginDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(BtnTalePet), UIEvent.EndDrag, function(eventData)
    self:EndDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(BtnEducation), UIEvent.BeginDrag, function(eventData)
    self:BeginDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(BtnEducation), UIEvent.EndDrag, function(eventData)
    self:EndDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(CloseBtn), UIEvent.BeginDrag, function(eventData)
    self:BeginDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(CloseBtn), UIEvent.EndDrag, function(eventData)
    self:EndDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(TeamBtn), UIEvent.BeginDrag, function(eventData)
    self:BeginDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(TeamBtn), UIEvent.EndDrag, function(eventData)
    self:EndDrag(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(OpenBtn), UIEvent.BeginDrag, function(eventData)
    self:BeginDragOpen(eventData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(OpenBtn), UIEvent.EndDrag, function(eventData)
    self:EndDragOpen(eventData)
  end)
end

function UIMainLobbyButtomBtns:BeginDragOpen(eventData)
  if eventData then
    self._beginDragOpenPos = eventData.position
    Log.debug("###[UIMainLobbyButtomBtns] self._beginDragOpenPos:", self._beginDragOpenPos.x)
    self._isDragOpen = true
  end
end

function UIMainLobbyButtomBtns:EndDragOpen(eventData)
  if self._isDragOpen then
    local endDragOpenPos = eventData.position
    Log.debug("###[UIMainLobbyButtomBtns] endDragOpenPos:", endDragOpenPos.x)
    local deltaX = endDragOpenPos - self._beginDragOpenPos
    Log.debug("###[UIMainLobbyButtomBtns] deltaX:", deltaX)
    if deltaX.x < -self._dragDeltaWidth and math.abs(deltaX.y) < self._dragDeltaHeight then
      Log.debug("###[UIMainLobbyButtomBtns] endDragOpen deltaX enough !")
      self:OpenBtns()
    else
      Log.debug("###[UIMainLobbyButtomBtns] endDragOpen deltaX not enough .")
    end
    self._isDragOpen = false
  end
end

function UIMainLobbyButtomBtns:OpenBtns()
  Log.debug("###[UIMainLobbyButtomBtns] open btns anim!")
  GameGlobal.GetUIModule(SignInModule):SetMainLobbyButtomCloseState(false)
  self:Lock("UIMainLobbyButtomBtns:OpenBtns")
  self._anim:Play(self._openAnimName)
  GameGlobal.Timer():AddEvent(583, function()
    self:UnLock("UIMainLobbyButtomBtns:OpenBtns")
  end)
  self._closeImgCanG.blocksRaycasts = true
  self._openImgCanG.blocksRaycasts = false
end

function UIMainLobbyButtomBtns:CloseBtns()
  Log.debug("###[UIMainLobbyButtomBtns] close btns anim !")
  GameGlobal.GetUIModule(SignInModule):SetMainLobbyButtomCloseState(true)
  self:Lock("UIMainLobbyButtomBtns:CloseBtns")
  self._anim:Play(self._closeAnimName)
  GameGlobal.Timer():AddEvent(583, function()
    self:UnLock("UIMainLobbyButtomBtns:CloseBtns")
  end)
  self._closeImgCanG.blocksRaycasts = false
  self._openImgCanG.blocksRaycasts = true
  self.canConvene:SetActive(false)
end

function UIMainLobbyButtomBtns:BeginDrag(eventData)
  if eventData then
    self._beginDragPos = eventData.position
    Log.debug("###[UIMainLobbyButtomBtns] self._beginDragPos:", self._beginDragPos.x)
    self._isDrag = true
  end
end

function UIMainLobbyButtomBtns:EndDrag(eventData)
  if self._isDrag then
    local endDragPos = eventData.position
    Log.debug("###[UIMainLobbyButtomBtns] endDragPos:", endDragPos.x)
    local deltaX = endDragPos - self._beginDragPos
    Log.debug("###[UIMainLobbyButtomBtns] deltaX:", deltaX)
    if deltaX.x > self._dragDeltaWidth and math.abs(deltaX.y) < self._dragDeltaHeight then
      Log.debug("###[UIMainLobbyButtomBtns] endDrag deltaX enough !")
      self:CloseBtns()
    else
      Log.debug("###[UIMainLobbyButtomBtns] endDrag deltaX not enough .")
    end
    self._isDrag = false
  end
end

function UIMainLobbyButtomBtns:ArrowBtnOnClick(go)
  self:OpenBtns()
end

function UIMainLobbyButtomBtns:SetData()
  self:_CheckQuestLock()
  self:QuestInfo()
  self:SetBase()
  self:CheckAircraftRed()
  self:_CheckEducation()
  AudioHelperController.RequestUISound(CriAudioIDConst.AircraftBtnClick)
  self:CheckBackPackNew()
  self:TalePetRedPointController()
  self.shop:FlushLockStatus()
  self:PlayEnterAnim()
end

function UIMainLobbyButtomBtns:PlayEnterAnim()
  local closeState = GameGlobal.GetUIModule(SignInModule):GetMainLobbyButtomCloseState()
  if closeState then
    self._closeImgCanG.blocksRaycasts = false
    self._openImgCanG.blocksRaycasts = true
    self._anim:Play(self._enterAnimNameClose)
  else
    self._closeImgCanG.blocksRaycasts = true
    self._openImgCanG.blocksRaycasts = false
    self._anim:Play(self._enterAnimNameOpen)
  end
end

function UIMainLobbyButtomBtns:OnHide()
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.AircraftBtnClick)
  if self.conveneDelay then
    GameGlobal.RealTimer():CancelEvent(self.conveneDelay)
    self.conveneDelay = nil
  end
  if self._showTaleUI then
    GameGlobal.Timer():CancelEvent(self._showTaleUI)
  end
end

function UIMainLobbyButtomBtns:BtnTalePetOnClick()
  self:Lock("UIMainLobbyButtomBtns:OnClickTale")
  GameGlobal.TaskManager():StartTask(self.OnClickTale, self)
end

function UIMainLobbyButtomBtns:OnClickTale(TT)
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_OLD_SEAL)
  local res = self._talePetModule:ReqTalePet(TT)
  if res:GetSucc() then
    local isFirstEnter = self._talePetModule:IsFirstEnter()
    if isFirstEnter == false then
      local res = self._talePetModule:ReqTaleFirst(TT, TaleFirstType.TFT_Enter)
      if res:GetSucc() then
        local storyId = self._talePetModule:GetEnterTalePetStoryIds()
        self:ShowDialog("UIStoryController", storyId, function()
          self:ShowDialog("UITalePetList")
          if GameGlobal.UIStateManager():IsShow("UIStoryController") then
            GameGlobal.UIStateManager():CloseDialog("UIStoryController")
          end
        end, false)
      else
        ToastManager.ShowToast(res:GetResult())
      end
    else
      local callState = self._talePetModule:SelectPetCfgId()
      if callState ~= 0 then
        self:ShowDialog("UITalePetMissionController", callState)
      else
        self:ShowDialog("UITalePetList")
      end
    end
  else
    ToastManager.ShowToast(res.m_result)
  end
  self:UnLock("UIMainLobbyButtomBtns:OnClickTale")
end

function UIMainLobbyButtomBtns:RefreshCanConvene()
  local list = {}
  self.canConvene:SetActive(false)
  local cfg = Cfg.cfg_tale_pet({})
  if cfg == nil then
    return
  end
  for key, value in pairs(cfg) do
    local info = self._talePetModule:GetPetInfo(value.ID)
    if info == nil then
      table.insert(list, value)
    end
  end
  if #list <= 0 then
    return
  end
  self.canConceneAnim:Stop()
  self.canConvene:SetActive(true)
  self.canConceneRaw.color = Color(1, 1, 1, 0)
  self.canConceneAnim:Play("uieff_UIMainLobbyButtomBtns_canConvene_in")
  local rand = math.random(1, #list)
  self.canConceneImg:LoadImage(list[rand].TurnIcon)
  if self.conveneDelay then
    GameGlobal.Timer():CancelEvent(self.conveneDelay)
  end
  self.conveneDelay = GameGlobal.Timer():AddEvent(5000, function()
    self.canConceneAnim:Stop()
    self.canConceneAnim:Play("uieff_UIMainLobbyButtomBtns_canConvene_out")
    self.conveneDelay = nil
  end)
end

function UIMainLobbyButtomBtns:ChangeTaleInfo()
  self.canConvene:SetActive(false)
  local IsCanDo = self._talePetModule:IsCanDo()
  if IsCanDo then
    self:RefreshCanConvene()
  end
  self:TalePetRedPointController()
end

function UIMainLobbyButtomBtns:TalePetRedPointController()
  local state1 = self._talePetModule:IsCanCall()
  local state2 = self._talePetModule:IsAllGetReward()
  local state3 = self._talePetModule:IsShowRewardRed()
  local state4 = self._talePetModule:IsShowTrailFinalLevelRed()
  local loginModule = GameGlobal.GetModule(LoginModule)
  local recordValue = LocalDB.GetInt("NewTalePet2" .. loginModule:GetRoleShowID(), 0)
  local state5 = recordValue <= 0
  if state1 or state2 or state3 or state4 or state5 then
    local unlock = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_TalePet)
    self.talePetRedPoint:SetActive(unlock)
  else
    self.talePetRedPoint:SetActive(false)
  end
end

function UIMainLobbyButtomBtns:CheckBackPackNew()
  local itemModule = self:GetModule(ItemModule)
  local hasNew = itemModule:HasNew()
  self._backPackRedGO:SetActive(hasNew)
end

function UIMainLobbyButtomBtns:BackpackBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_BackPackController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Item)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_STORE)
  self:ShowDialog("UIBackPackController")
end

function UIMainLobbyButtomBtns:TeamBtnOnClick(go)
  Log.fatal("UIMainLobbyFinal:TeamBtnOnClick Start:" .. UnityEngine.Time.realtimeSinceStartup)
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_Teams"
  }, true)
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_TEAM)
  GameGlobal.GetModule(MissionModule):TeamCtx():Init(TeamOpenerType.Main, 0)
  self:ShowDialog("UITeams")
end

function UIMainLobbyButtomBtns:CheckAircraftRed()
  local aircraftModule = self:GetModule(AircraftModule)
  local count = aircraftModule:GetCollectTypeCount()
  self._aircraftAwardCountGo:SetActive(0 < count)
end

function UIMainLobbyButtomBtns:BaseBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_AircraftBtn"
  }, true)
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.AircraftBtnClick)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Aircraft)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_AIRCRAFT)
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Enter, "fc_ui")
end

function UIMainLobbyButtomBtns:SetBase()
  local s = self:GetUIComponent("UISelectObjectPath", "BaseBtn")
  local baseButtonFunction = s:SpawnObject("UIMainLobbyLockBtn")
  baseButtonFunction:SetFunctionType(GameModuleID.MD_Aircraft)
end

function UIMainLobbyButtomBtns:_CheckQuestLock()
  local module = GameGlobal.GetModule(RoleModule)
  self._questUnLock = module:CheckModuleUnlock(GameModuleID.MD_QuestEntry)
  local s = self:GetUIComponent("UISelectObjectPath", "QuestBtn")
  local mailButtonFunction = s:SpawnObject("UIMainLobbyLockBtn")
  mailButtonFunction:SetFunctionType(GameModuleID.MD_QuestEntry)
end

function UIMainLobbyButtomBtns:QuestBtnOnClick()
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_QuestController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_QuestEntry)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_TASK)
  if self._questUnLock == false then
  else
    UIWidgetHelper.BlurHelperShot(self.uiOwner, "screenShot", self.uiOwner:GetName(), function(cache_rt)
      self._cache_rt = cache_rt
    end)
    self:ShowDialog("UIQuestController", nil, nil, function()
      return self._cache_rt
    end)
  end
end

function UIMainLobbyButtomBtns:CheckQuestRed()
  if self._questUnLock == false then
    self._questRed:SetActive(false)
  else
    local questModule = GameGlobal.GetModule(QuestModule)
    local questNumber = questModule:GetRedPointNum()
    if questNumber and 0 < questNumber then
      self._questRed:SetActive(true)
    else
      self._questRed:SetActive(false)
    end
  end
end

function UIMainLobbyButtomBtns:QuestInfo()
  self:CheckQuestRed()
end

function UIMainLobbyButtomBtns:_CheckEducation()
  local module = GameGlobal.GetModule(RoleModule)
  local isUnlock = module:CheckModuleUnlock(GameModuleID.MD_PROCUL)
  local module = GameGlobal.GetModule(PetModule)
  local hasRed = module:GetUIEducationData():HasRed()
  self._educationRedPoint.gameObject:SetActive(isUnlock and hasRed)
  local educationFunction = self._btnEducation:SpawnObject("UIMainLobbyLockBtn")
  educationFunction:SetFunctionType(GameModuleID.MD_PROCUL)
end

function UIMainLobbyButtomBtns:ChkEducationRed()
  local module = GameGlobal.GetModule(PetModule)
  local educationData = module:GetUIEducationData()
  educationData:SetRedDirty(true)
  educationData:TestCondition()
  self:_CheckEducation()
end

function UIMainLobbyButtomBtns:BtnEducationOnClick(go)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_PROCUL)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
  else
    self:ShowDialog("UIEducationMain")
  end
end
