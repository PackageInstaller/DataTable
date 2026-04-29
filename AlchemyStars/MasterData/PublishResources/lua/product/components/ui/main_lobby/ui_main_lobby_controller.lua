_class("UIMainLobbyController", UIController)
UIMainLobbyController = UIMainLobbyController

function UIMainLobbyController:LoadDataOnEnter(TT, res, uiParams)
  if GameSingle then
    self:SingleLoadDataOnEnter()
  else
    self:MultipleLoadDataOnEnter(TT, res, uiParams)
  end
end

function UIMainLobbyController:SingleLoadDataOnEnter()
  self:Task_InitMulitDress(TT)
end

function UIMainLobbyController:MultipleLoadDataOnEnter(TT, res, uiParams)
  self.mCampaign = self:GetModule(CampaignModule)
  self._latestCampObj = self.mCampaign:GetLatestCampaignObj(TT)
  self.grassData = self.mCampaign:GetGraveRobberData()
  self.grassData:RequestCampaign(TT)
  local roleModule = self:GetModule(RoleModule)
  if roleModule ~= nil then
    roleModule:GetRecoverData(TT, 0)
  end
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  local ret = talePetModule:RequestTrailLevelData(TT)
  local petModule = GameGlobal.GetModule(PetModule)
  petModule:ClearAllPetSortInfo()
  local seasonTaskModule = GameGlobal.GetModule(SeasonTaskModule)
  seasonTaskModule:ReqSeasonTaskInfoData(TT)
  self:LoadExtraEntryData(TT)
  self:LoadCenterData(TT)
  self:Task_InitMulitDress(TT)
  res:SetSucc(self:GetModule(LoginModule):IsLogin())
end

function UIMainLobbyController:Task_InitMulitDress(TT)
  self._signInModule = self:GetModule(SignInModule)
  local res, replay = self._signInModule:HandleGetMainDressUpReq(TT)
  if res:GetSucc() then
  end
end

function UIMainLobbyController:LoadCenterData(TT)
  self._centerEntryData = MainLobbyCenterData:New()
  self._centerEntryData:LoadCampaignData(TT)
end

function UIMainLobbyController:SetYearSign()
  local yearSign = self:GetUIComponent("UISelectObjectPath", "yearSign")
  if not yearSign then
    return
  end
  self._yearSign = yearSign:SpawnObject("UIMainLobbyYearSign")
  self._yearSign:SetData()
end

function UIMainLobbyController:SetCerebSign()
  local cerebSign = self:GetUIComponent("UISelectObjectPath", "cerebSign")
  if not cerebSign then
    return
  end
  self._cerebSign = cerebSign:SpawnObject("UIMainLobbyCerebSign")
  self._cerebSign:SetData()
end

function UIMainLobbyController:SetCenterEnter()
  local campaignCenter = self:GetUIComponent("UISelectObjectPath", "campaignCenter")
  self._campaignCenter = campaignCenter:SpawnObject("UIMainLobbyCampCenter")
  self._campaignCenter:SetData(self._centerEntryData)
end

function UIMainLobbyController:LoadExtraEntryData(TT)
  self._extraEntryData = MainLobbyExtraData:New()
  self._extraEntryData:LoadCampaignData(TT)
end

function UIMainLobbyController:SetCampaignSideEntrys()
  local extraEntry = self:GetUIComponent("UISelectObjectPath", "UIMainLobbyExtraCampEntry")
  self._main_extra_entry = extraEntry:SpawnObject("UIMainLobbyExtraCampEntry")
  self._main_extra_entry:SetData(self._extraEntryData)
end

function UIMainLobbyController:OnShow(uiParams)
  saveQRClickLastTime = 0
  self.SaveQRLeftTimeTex = self:GetUIComponent("UILocalizationText", "SaveQRLeftTimeTex")
  local saveQRLeftTimeStr = self:GetSaveBtnLeftTimeStr()
  Log.debug("saveQRLeftTimeStr=", saveQRLeftTimeStr)
  self.SaveQRLeftTimeTex:SetText(saveQRLeftTimeStr)
  if GameSingle then
    self:SingleOnShow(uiParams)
  else
    self:MultipleOnShow(uiParams)
  end
end

function UIMainLobbyController:GetSaveBtnLeftTimeStr()
  local str = ""
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local leftTime = loginModule:GetSingleTimeTick() - svrTimeModule:GetServerTime() * 0.001
  local day = math.floor(leftTime / 86400)
  if 1 <= day then
    str = string.format(StringTable.Get("str_set_download_day"), day)
    return str
  end
  leftTime = loginModule:GetSingleTimeTick() - svrTimeModule:GetServerTime() * 0.001
  local hour = math.floor(leftTime / 3600)
  if 1 <= hour then
    str = string.format(StringTable.Get("str_set_download_hour"), hour)
    return str
  end
  leftTime = loginModule:GetSingleTimeTick() - svrTimeModule:GetServerTime() * 0.001
  local minutes = math.floor(leftTime / 60)
  if 1 <= minutes then
    str = string.format(StringTable.Get("str_set_download_minute"), minutes)
    return str
  end
  return str
end

function UIMainLobbyController:SingleOnShow(uiParams)
  self:_GetComponents()
  self:AddListener()
  self:_OnValueOnSingle(uiParams)
  UIBgmHelper.PlayMainBgm()
  if self._anniversaryEffectEvent then
    GameGlobal.Timer():CancelEvent(self._anniversaryEffectEvent)
    self._anniversaryEffectEvent = nil
  end
  self:_PlayAnim("light_in")
  local sModule = GameGlobal.GetModule(SerialAutoFightModule)
  if sModule then
    local jumpData = sModule:GetJumpData()
    if jumpData then
      jumpData:Jump_Clear()
    end
  end
end

function UIMainLobbyController:MultipleOnShow(uiParams)
  self._inited = false
  self:SetCenterEnter()
  self:SetYearSign()
  self:SetCerebSign()
  self:SetCampaignSideEntrys()
  UnityEngine.Input.multiTouchEnabled = false
  GameGlobal.UAReportForceGuideEvent("MainUIEnter", {}, true)
  self:_GetComponents()
  self._roleModule = self:GetModule(RoleModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
  self:_OnValue(uiParams)
  self:AddListener()
  local funcModule = self:GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(false)
  UIBgmHelper.PlayMainBgm()
  self:CheckFixedStatus()
  self._roleModule:LoginCompleteEvent()
  self:_CheckPreDownLoadPV()
  if self._anniversaryEffectEvent then
    GameGlobal.Timer():CancelEvent(self._anniversaryEffectEvent)
    self._anniversaryEffectEvent = nil
  end
  self:_PlayAnim("light_in")
  local sModule = GameGlobal.GetModule(SerialAutoFightModule)
  if sModule then
    local jumpData = sModule:GetJumpData()
    if jumpData then
      jumpData:Jump_Clear()
    end
  end
end

function UIMainLobbyController:_PlayAnim(key, callback)
  local tb = {
    ["in"] = {
      animName = "uieff_UIMainLobbyController_in",
      duration = 1000
    },
    light_in = {
      animName = "uieff_UIMainLobbyController_Anniversary_in",
      duration = 1067
    },
    hide = {
      animName = "uieff_UIMainLobbyController_hide",
      duration = 267
    },
    show = {
      animName = "uieff_UIMainLobbyController_show",
      duration = 367
    }
  }
  UIWidgetHelper.PlayAnimation(self, "uianim", tb[key].animName, tb[key].duration, callback)
end

function UIMainLobbyController:CheckFixedStatus()
  do return end
  local roleModule = self:GetModule(RoleModule)
  if not roleModule:GetIsFix() then
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_shop_resourceerror_title"), StringTable.Get("str_shop_resourceerror_desc"), function(param)
    Log.error("UIMainLobbyController:CheckFixedStatus click")
    roleModule:SetIsFixItem(false)
  end)
end

function UIMainLobbyController:_CheckCutSceneOut()
  CutsceneManager.ExcuteCutsceneOut()
end

function UIMainLobbyController:_GetComponents()
  local testFuncEntry = UIWidgetHelper.SpawnObject(self, "TestFunc", "UITestFuncEntry", "UITestFuncEntry.prefab")
  testFuncEntry:SetData("UITestFuncMainLobby", "UITestFunc_MainLobby.prefab")
  self.SaveQRBtn = self:GetGameObject("SaveQRBtn")
  self.SaveQRBtn:SetActive(not GameSingle and APPVER_1430)
  self._canvasGroupUiAnim = self:GetUIComponent("CanvasGroup", "uianim")
  self.weChatBtn = self:GetGameObject("weChatBtn")
  self.weChatBtn:SetActive(not GameSingle)
  self.NoticeBtn = self:GetGameObject("NoticeBtn")
  self.NoticeBtn:SetActive(not GameSingle)
  self.MailBtn = self:GetGameObject("MailBtn")
  self.MailBtn:SetActive(not GameSingle)
  self._discoveryGuideGO = self:GetGameObject("discoveryGuideGO")
  local toptips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._toptipsInfo = toptips:SpawnObject("UITopTipsContext")
  self._missionName = self:GetUIComponent("RollingText", "missionName")
  self._noticeRed = self:GetGameObject("NoticeRed")
  self._noticeRed:SetActive(false)
  self._homeAwardCountGo = self:GetGameObject("homeAwardGo")
  self._homeAwardCountText = self:GetUIComponent("UILocalizationText", "homeAwardCountTex")
  self._gambleIcon = self:GetUIComponent("RawImageLoader", "gambleIcon")
  self._sumBtn = self:GetUIComponent("Image", "sumBtnView")
  self._gambleNew = self:GetGameObject("gambleNew")
  self._gambleRed = self:GetGameObject("gambleRed")
  self._gambleFreeMul = self:GetGameObject("gambleFreeMul")
  self._gambleFreeSin = self:GetGameObject("gambleFreeSin")
  self._weChatRedGO = self:GetGameObject("weChatRed")
  self._weChatCountGO = self:GetGameObject("weChatCount")
  self._weChatCountTxt = self:GetUIComponent("UILocalizationText", "weChatCountTxt")
  self._weChatTalkGO = self:GetGameObject("wechattalk")
  self._weChatTalkAni = self:GetUIComponent("Animation", "wechattalk")
  self._weChatMainIcon = self:GetUIComponent("RawImageLoader", "wechatmainicon")
  self._weChatMainIcon01 = self:GetUIComponent("RawImageLoader", "wechatmainicon01")
  self._weChatMainIconRaw01 = self:GetUIComponent("RawImage", "wechatmainicon01")
  self._weChatMainIconRaw = self:GetUIComponent("RawImage", "wechatmainicon")
  self._cardNew = self:GetGameObject("heartNew")
  self.missionRed = self:GetGameObject("missionRed")
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._screenShot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  if EngineGameHelper.EnableAppleVerifyBulletin() or GameSingle then
    self._homeObj = self:GetGameObject("HomeBtn")
    self._homeObj:SetActive(false)
  end
  self._atlas = self:GetAsset("UIMainLobbyFinal.spriteatlas", LoadType.SpriteAtlas)
  self._uiCanvasGroup = self:GetUIComponent("CanvasGroup", "UICanvas")
  self._centerCanvasGroup = self:GetUIComponent("CanvasGroup", "Center")
  self._leftUpGroup = self:GetUIComponent("CanvasGroup", "LeftUp")
end

function UIMainLobbyController:ShowRoleInfo()
  local role = self:GetUIComponent("UISelectObjectPath", "UIMainLobbyRole")
  self._main_role = role:SpawnObject("UIMainLobbyRole")
end

function UIMainLobbyController:MainActivityEntry()
  local sop = self:GetUIComponent("UISelectObjectPath", "activityMainEntry")
  self._main_camp_entry = sop:SpawnObject("UIMainLobbyMainCampaignEntry")
  self._main_camp_entry:SetData(self._latestCampObj, self)
end

function UIMainLobbyController:SeasonEntry()
  local seasonEntry = self:GetUIComponent("UISelectObjectPath", "UIMainLobbySeasonEntry")
  self._season_entry = seasonEntry:SpawnObject("UIMainLobbySeasonEntry")
  self._season_entry:SetData()
end

function UIMainLobbyController:_OnValueOnSingle(uiParams)
  self:SetUIMainLobbyBg(uiParams)
  local s = self:GetGameObject("sumBtn")
  s:SetActive(false)
  self:ShowRoleInfo()
end

function UIMainLobbyController:_OnValue(uiParams)
  self:SetUIMainLobbyBg(uiParams)
  self:MainActivityEntry()
  self:_RefreshFunctionLockStatus()
  self:CheckPetRed()
  self:GetCurrentPhyTimer()
  self:ShowUIMainLobbyButtomBtns()
  self:ShowRoleInfo()
  self:CheckNewNotice()
  self:_CheckMailStatus()
  self:CheckGuideShow()
  self:_CheckGuide()
  self:SeasonEntry()
  self:InitScrollView()
  self:CheckHomeRed()
  self._gamebleBtn = UIMainLobbyBtnGamble:New(self._gambleIcon, self._gambleFreeMul, self._gambleFreeSin, self._gambleNew)
  self._gamebleBtn:InitGambleRed(self._gambleRed)
  self:OnUpdateGamble()
  self:OnUpdateWeChatRed()
  self:OnUpdateWeChatMainTalk()
  self:_CheckCutSceneOut()
  self:_CheckWoldBossRedPoint()
  self:SetWakeUp()
end

function UIMainLobbyController:SetUIMainLobbyBg(uiParams)
  local mainLobbyBg = self:GetUIComponent("UISelectObjectPath", "UIMainLobbyBg")
  self._main_lobby_bg = mainLobbyBg:SpawnObject("UIMainLobbyBg")
  self._main_lobby_bg:SetData(uiParams[1])
end

function UIMainLobbyController:OnUpdateGamble()
  local function fnRefreshNewRed()
    self._updateGambleEvent = self:StartTask(function(TT)
      local module = self:GetModule(GambleModule)
      
      local ack = module:ApplyAllPoolInfo(TT)
      if ack:GetSucc() then
        self._gamebleBtn:RefreshNew()
        self._gamebleBtn:RefreshRed()
      else
        Log.notice("[DrawCard] promotion time up, refresh pools failed")
      end
      self._updateGambleEvent = nil
    end)
  end
  
  fnRefreshNewRed()
  local refreshTime = 60
  self._updateGambleTimer = GameGlobal.Timer():AddEventTimes(1000 * refreshTime, TimerTriggerCount.Infinite, fnRefreshNewRed)
end

function UIMainLobbyController:SetWakeUp()
  local wakeup = self:GetUIComponent("UISelectObjectPath", "WakeUp")
  if wakeup then
    wakeup:SpawnObject("UIWakeUpMain")
  end
end

function UIMainLobbyController:InitScrollView()
  Log.debug("###[UIMainLobbyController] InitScrollView !")
  self._scroll = self:GetGameObject("scroll")
  self._main_scroll_pool = self:GetUIComponent("UISelectObjectPath", "scroll")
  self._main_scroll = self._main_scroll_pool:SpawnObject("UIMainLobbyScroll")
  self._main_scroll_inited = self._main_scroll:SetData(true)
end

function UIMainLobbyController:MissionInfo()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local discoveryData = missionModule:GetDiscoveryData()
  if not discoveryData then
    Log.fatal("### DiscoveryData nil.")
    return
  end
  local tmp_val, canPlayNode = discoveryData:GetCanPlayChapterNode()
  if not canPlayNode then
    local count = 0
    for key, chapter in pairs(discoveryData.chapters) do
      local section = discoveryData:GetDiscoverySectionByChapterId(chapter.id)
      if not section.isBetween then
        count = count + 1
      end
    end
    local str = StringTable.Get("str_main_lobby_finish", count + 1)
    self._missionName:RefreshText(str)
  else
    local canPlayStages = canPlayNode:GetCanPlayStages()
    local currentMissionID = canPlayStages[1].id
    local missionName = "1-1"
    local cfg_mission = Cfg.cfg_mission[currentMissionID]
    if cfg_mission then
      missionName = StringTable.Get(cfg_mission.Name)
    end
    local missionIndex = DiscoveryStage.GetStageIndexString(currentMissionID)
    local strMissionName = missionIndex .. " " .. missionName
    self._missionName:RefreshText(strMissionName)
  end
end

function UIMainLobbyController:CheckNewNotice()
  local state = self._roleModule:CheckModuleUnlock(GameModuleID.MD_Notify)
  if state == false then
    self._noticeRed:SetActive(false)
    return
  end
  self._noticeData = self._loginModule:GetNoticeData()
  if self._noticeData == nil then
    Log.fatal("###main notice data is nil !")
    return
  end
  self:CheckNoticeRed()
end

function UIMainLobbyController:CheckNoticeRed()
  if self._noticeData == nil then
    return
  end
  local systemState = self._noticeData:GetNoticeNewStateWithGroup(NoticeType.System)
  local activeState = self._noticeData:GetNoticeNewStateWithGroup(NoticeType.Active)
  self._noticeRed:SetActive(systemState or activeState)
end

function UIMainLobbyController:OnShowChangeMainCg(show)
  if show == UIPetAndBgMoveType.Bg or show == UIPetAndBgMoveType.Pet then
    self._canvasGroupUiAnim.alpha = 0.5
    if self._uiCanvasGroup then
      self._uiCanvasGroup.alpha = 0.5
    end
    if self._centerCanvasGroup then
      self._centerCanvasGroup.enabled = true
    end
    if self._leftUpGroup then
      self._leftUpGroup.alpha = 0.5
    end
    if self._main_lobby_bg then
      self._main_lobby_bg:SetVoiceCanvasGroup(0.5)
    end
    if self._main_role then
      self._main_role:SetRoleCanvasGroup(0.5)
    end
  elseif show == UIPetAndBgMoveType.None then
    self._canvasGroupUiAnim.alpha = 1
    if self._uiCanvasGroup then
      self._uiCanvasGroup.alpha = 1
    end
    if self._centerCanvasGroup then
      self._centerCanvasGroup.enabled = false
    end
    if self._leftUpGroup then
      self._leftUpGroup.alpha = 1
    end
    if self._main_lobby_bg then
      self._main_lobby_bg:SetVoiceCanvasGroup(1)
    end
    if self._main_role then
      self._main_role:SetRoleCanvasGroup(1)
    end
  end
end

function UIMainLobbyController:GetBgIDAndType()
  return self._main_lobby_bg:GetBgIDAndType()
end

function UIMainLobbyController:GetBgSetting()
  return self._main_lobby_bg:GetBgSetting()
end

function UIMainLobbyController:ChooseAssistantBtnOnClick()
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_ChooseAssistantController"
  }, true)
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_CHANGE_ASSISTANT)
  self:ShowDialog("UIChooseMainCgController")
end

function UIMainLobbyController:WatchModeBtnOnClick(go)
  self:_PlayAnim("hide", function()
    self:_SetUI_WatchMode("hide")
  end)
end

function UIMainLobbyController:WatchModePanelOnClick(go)
  self:_SetBackBtn_WatchMode()
end

function UIMainLobbyController:WatchModeBackBtnOnClick(go)
  self:_SetUI_WatchMode("show")
  self:_PlayAnim("show")
end

local saveQRClickGap = 10000
local saveQRClickLastTime = 0

function UIMainLobbyController:SaveQRBtnOnClick(go)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  if saveQRClickLastTime ~= 0 and svrTimeModule:GetServerTime() - saveQRClickLastTime < saveQRClickGap then
    ToastManager.ShowToast(StringTable.Get("str_set_download_tips"))
    return
  end
  saveQRClickLastTime = svrTimeModule:GetServerTime()
  Log.debug("saveQRClickLastTime", saveQRClickLastTime)
  self:ShowDialog("UISaveQRTipNew")
end

function UIMainLobbyController:_SetUI_WatchMode(key)
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    hide = {
      "WatchModePanel",
      "WatchModeBackBtn"
    },
    show = {
      "Left",
      "LeftDown",
      "Right",
      "RightDown",
      "LeftUp",
      "RightUp"
    }
  })
  UIWidgetHelper.SetObjGroupShow(objs, key)
  if key == "hide" then
    self._watchMode_backBtn = true
  else
    self._watchMode_backBtn = nil
  end
  if self._main_lobby_bg then
    local func = key == "hide" and function()
      self:_SetBackBtn_WatchMode()
    end
    self._main_lobby_bg:SetWatchMode(func)
  end
end

function UIMainLobbyController:_SetBackBtn_WatchMode()
  if self._watchMode_backBtn ~= nil then
    self._watchMode_backBtn = not self._watchMode_backBtn
    self:GetGameObject("WatchModeBackBtn"):SetActive(self._watchMode_backBtn)
  end
end

function UIMainLobbyController:CheckGuideShow()
  local module = self:GetModule(MissionModule)
  local discoveryData = module:GetDiscoveryData()
  local chapters = discoveryData:GetVisibleChapters()
  local needChapter = Cfg.cfg_guide_const.guide_discovery_btn_chapter.IntValue
  if chapters and needChapter > table.count(chapters) then
    if not GuideHelper.GuideInProgress() then
      if self._discoveryGuideGO then
        self._discoveryGuideGO:SetActive(true)
      end
    elseif self._discoveryGuideGO then
      self._discoveryGuideGO:SetActive(false)
    end
  elseif self._discoveryGuideGO then
    self._discoveryGuideGO:SetActive(false)
  end
end

function UIMainLobbyController:ShowGuideStep(param)
  self._discoveryGuideGO:SetActive(false)
end

function UIMainLobbyController:GuideDone()
  self:CheckGuideShow()
end

function UIMainLobbyController:UIClose()
  self:CheckGuideShow()
end

function UIMainLobbyController:AddListener()
  self:AttachEvent(GameEventType.CheckCardNew, self.CheckCardNew)
  self:AttachEvent(GameEventType.ItemCountChanged, self.CheckPetRed)
  self:AttachEvent(GameEventType.RolePropertyChanged, self.CheckPetRed)
  self:AttachEvent(GameEventType.CheckCardAwakeRedPoint, self.CheckPetRed)
  self:AttachEvent(GameEventType.RefreshMailStatus, self._CheckMailStatus)
  self:AttachEvent(GameEventType.ModuleMailNotifyNewMail, self._CheckMailStatus)
  self:AttachEvent(GameEventType.ShowGuideStep, self.ShowGuideStep)
  self:AttachEvent(GameEventType.GuideDone, self.GuideDone)
  self:AttachEvent(GameEventType.UIClose, self.UIClose)
  self:AttachEvent(GameEventType.OnUIPetObtainCloseInMain, self.OnUIPetObtainCloseInMain)
  self:AttachEvent(GameEventType.OnNoticeDataCheckNew, self.CheckNoticeRed)
  self:AttachEvent(GameEventType.OnPlayerHeadInfoChanged, self.PlayerHeader)
  self:AttachEvent(GameEventType.OnPlayerChangeHeadBadgeClick, self.PlayerHeader)
  self:AttachEvent(GameEventType.UpdateWeChatRed, self.OnUpdateWeChatRed)
  self:AttachEvent(GameEventType.UpdateWeChatMainTalk, self.OnUpdateWeChatMainTalk)
  self:AttachEvent(GameEventType.UpdateDrawCardRed, self.UpdateDrawCardRed)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnAfterUILayerChanged)
  self:AttachEvent(GameEventType.MainLobbyAutoOpenTryFail, self.OnAutoOpenListFail)
  self:AttachEvent(GameEventType.OnShowChangeMainCg, self.OnShowChangeMainCg)
  self:AttachEvent(GameEventType.WatchPetSkinStory, self.CheckPetRed)
end

function UIMainLobbyController:RefreshCampSampleInfo()
  self:Lock("UIMainLobbyController:RefreshCampSampleInfo")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local campModule = GameGlobal.GetModule(CampaignModule)
    self._latestCampObj = campModule:GetLatestCampaignObj(TT)
    if self._main_camp_entry then
      self._main_camp_entry:RefreshCampSampleInfo(self._latestCampObj, self)
    end
    if self._extraEntryData then
      self._extraEntryData:RefreshCampSampleInfo()
      if self._main_extra_entry then
        self._main_extra_entry:RefreshCampSampleInfo(self._extraEntryData)
      end
    end
    if self._centerEntryData then
      self._centerEntryData:RefreshCampSampleInfo(TT)
      if self._campaignCenter then
        self._campaignCenter:RefreshCampSampleInfo(self._centerEntryData)
      end
    end
    if self._season_entry then
      self._season_entry:OnAfterUILayerChanged()
    end
    if self._yearSign then
      self._yearSign:OnAfterUILayerChanged()
    end
    if self._cerebSign then
      self._cerebSign:OnAfterUILayerChanged()
    end
    self:UnLock("UIMainLobbyController:RefreshCampSampleInfo")
  end, self)
end

function UIMainLobbyController:OnAfterUILayerChanged()
  if GameSingle then
    return
  end
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    Log.debug("###[UIMainLobbyController] OnAfterUILayerChanged !")
    local uiModule = GameGlobal.GetUIModule(CampaignModule)
    uiModule:OnUIShowEnd(self:GetName())
    if self._buttom_btns ~= nil then
      self._buttom_btns:ChkEducationRed()
    end
    if self._inited then
      self:InitScrollView()
      self:RefreshCampSampleInfo()
    end
    UIBgmHelper.PlayMainBgm()
    if GuideHelper.GuideInProgress() then
      return
    end
    self:ShowOpenList()
    self:ShowChatUnLockBGM()
    self:UpdateDrawCardRed()
    if self._spRequest ~= nil then
      self._spRequest:Request()
    end
  end
  self._inited = true
end

function UIMainLobbyController:ShowChatUnLockBGM()
  local uiMainModule = self:GetUIModule(SignInModule)
  local unlockBGMs = uiMainModule:GetUnLockBGMs()
  if unlockBGMs and next(unlockBGMs) then
    local bgm = unlockBGMs[1]
    uiMainModule:RemoveBGM1()
    local title = ""
    local title_en = ""
    local cfg = Cfg.cfg_role_music[bgm]
    if not cfg then
      Log.error("###[UIMainLobbyController] cfg is nil ! id --> ", bgm)
    else
      title = StringTable.Get("str_main_lobby_un_lock_music_tips", StringTable.Get(cfg.Name))
    end
    self:ShowDialog("UIAircraftUnlockFileController", title, title_en, true)
  end
end

function UIMainLobbyController:CheckShowAutoPop()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    if GuideHelper.GuideInProgress() then
      return
    end
    self:ShowOpenList()
  end
end

function UIMainLobbyController:ShowOpenList()
  if not self._openListObj then
    self._openListObj = UIMainLobbyOpenList:New()
    self._openListObj:SetData(self:GetName())
  end
  self._openListObj:ShowOpenList()
end

function UIMainLobbyController:OnAutoOpenListFail()
  Log.debug("#OpenList# OnAutoOpenListFail")
  if self._delayCheckAutoPopEvent ~= nil then
    GameGlobal.Timer():CancelEvent(self._delayCheckAutoPopEvent)
    self._delayCheckAutoPopEvent = nil
  end
  self._delayCheckAutoPopEvent = GameGlobal.RealTimer():AddEvent(1, function()
    self:CheckShowAutoPop()
  end)
end

function UIMainLobbyController:RemoveListener()
end

function UIMainLobbyController:OnHide()
  if self._openListObj then
    self._openListObj:Dispose()
    self._openListObj = nil
  end
  if self._startPhyTimerEvent ~= nil then
    GameGlobal.RealTimer():CancelEvent(self._startPhyTimerEvent)
    self._startPhyTimerEvent = nil
  end
  if self._startPhyTimerLoopEvent ~= nil then
    GameGlobal.RealTimer():CancelEvent(self._startPhyTimerLoopEvent)
    self._startPhyTimerLoopEvent = nil
  end
  self:RemoveListener()
  if self._showTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._showTimeEvent)
    self._showTimeEvent = nil
  end
  if self._phyEvent then
    GameGlobal.RealTimer():CancelEvent(self._phyEvent)
    self._phyEvent = nil
  end
  Log.debug("###main - OnHide")
  if self._scrollEvent then
    Log.debug("###main - cancel")
    GameGlobal.Timer():CancelEvent(self._scrollEvent)
    self._scrollEvent = nil
  end
  self._audioPlayID = nil
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  self:StopWeChatTalkTimer()
  if self._monthcardRefreshEvent ~= nil then
    GameGlobal.Timer():CancelEvent(self._monthcardRefreshEvent)
    self._monthcardRefreshEvent = nil
  end
  if self._delayCheckAutoPopEvent ~= nil then
    GameGlobal.Timer():CancelEvent(self._delayCheckAutoPopEvent)
    self._delayCheckAutoPopEvent = nil
  end
  if self._phyEvent then
    GameGlobal.RealTimer():CancelEvent(self._phyEvent)
    self._phyEvent = nil
  end
  if self._spRequest ~= nil then
    self._spRequest:Dispose()
    self._spRequest = nil
  end
  if self._updateGambleTimer ~= nil then
    GameGlobal.Timer():CancelEvent(self._updateGambleTimer)
    self._updateGambleTimer = nil
  end
  if self._updateGambleEvent ~= nil then
    GameGlobal.TaskManager():KillTask(self._updateGambleEvent)
    self._updateGambleEvent = nil
  end
  if self._anniversaryEffectEvent then
    GameGlobal.Timer():CancelEvent(self._anniversaryEffectEvent)
    self._anniversaryEffectEvent = nil
  end
  self:UnLock("UIMainLobbyController:RefreshCampSampleInfo")
end

function UIMainLobbyController:_CheckMailStatus()
  local mailUnReadGo = self:GetGameObject("MailUnRead")
  local mailModule = GameGlobal.GetModule(MailModule)
  local hasNewMail = mailModule:HaveNewMail()
  mailUnReadGo:SetActive(hasNewMail)
end

function UIMainLobbyController:CheckPetRed()
  local isShow = false
  local petModule = GameGlobal.GetModule(PetModule)
  isShow = petModule:CheckNewPetForMainUI()
  if not isShow then
    local pets = petModule:GetPets()
    for _, pet in pairs(pets) do
      local isSkin = pet:IsShowSkinRedPoint()
      local isRed = isSkin
      if isRed then
        isShow = true
        break
      end
    end
  end
  self._cardNew:SetActive(isShow)
end

function UIMainLobbyController:CheckCardNew()
  local active = false
  local petModule = GameGlobal.GetModule(PetModule)
  active = petModule:CheckNewPetForMainUI()
  self._cardNew:SetActive(active)
end

function UIMainLobbyController:CheckHomeRed()
  local homeModule = self:GetModule(HomelandModule)
  local count = homeModule:GetMainRedCount()
  self._homeAwardCountGo:SetActive(0 < count)
  if 0 < count then
    self._homeAwardCountText:SetText(count)
  end
end

function UIMainLobbyController:_RefreshFunctionLockStatus()
  local homeImg = self:GetUIComponent("Image", "HomeBtnView")
  local s = self:GetUIComponent("UISelectObjectPath", "HomeBtn")
  local homeButtonFunction = s:SpawnObject("UIMainLobbyLockBtn")
  homeButtonFunction:SetFunctionType(GameModuleID.MD_HomeLand)
  homeButtonFunction:SetColorImage(homeImg)
  local noticeImg = self:GetUIComponent("Image", "NoticeBtnView")
  local s = self:GetUIComponent("UISelectObjectPath", "NoticeBtn")
  local expressionButtonFunction = s:SpawnObject("UIMainLobbyLockBtn")
  expressionButtonFunction:SetFunctionType(GameModuleID.MD_Notify)
  expressionButtonFunction:SetColorImage(noticeImg)
  local mailImg = self:GetUIComponent("Image", "MailBtnView")
  local s = self:GetUIComponent("UISelectObjectPath", "MailBtn")
  local mailButtonFunction = s:SpawnObject("UIMainLobbyLockBtn")
  mailButtonFunction:SetFunctionType(GameModuleID.MD_Mail)
  mailButtonFunction:SetColorImage(mailImg)
  local sumBtnView = self:GetUIComponent("Image", "sumBtnView")
  local s = self:GetUIComponent("UISelectObjectPath", "sumBtn")
  local sumButtonFunction = s:SpawnObject("UIMainLobbyLockBtn")
  sumButtonFunction:SetFunctionType(GameModuleID.MD_Gamble)
  sumButtonFunction:SetLockViewCallback(function()
    self._gamebleBtn:ShowNewAndRed(false)
  end, function()
    self._gamebleBtn:ShowNewAndRed(true)
  end)
  local wechatImg = self:GetUIComponent("Image", "weChatBtnView")
  local s = self:GetUIComponent("UISelectObjectPath", "weChatBtn")
  local weChatBtnFunction = s:SpawnObject("UIMainLobbyLockBtn")
  weChatBtnFunction:SetFunctionType(GameModuleID.MD_WeChat)
  weChatBtnFunction:SetColorImage(wechatImg)
end

function UIMainLobbyController:MissionBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_Discovery"
  }, true)
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_EXPLORE)
  self.grassData = GameGlobal.GetModule(CampaignModule):GetGraveRobberData()
  if self.grassData:IsOpenGraveRobber() and self.grassData:HasCanPlayNode() then
    DiscoveryData.EnterStateUIDiscovery(7, nil)
  else
    DiscoveryData.EnterStateUIDiscovery(1)
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIExplore)
end

function UIMainLobbyController:MailBtnOnClick()
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_MailController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Mail)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_MAIL)
  self:ShowDialog("UIMailController")
end

function UIMainLobbyController:WeChatBtnOnClick()
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_WeChatController"
  }, true)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.WeChatBtnClick)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_WeChat)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_TERMINAL)
  self:ShowDialog("UIWeChatController")
end

function UIMainLobbyController:NoticeBtnOnClick()
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "UINoticeController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Notify)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_NOTICE)
  local openType = NoticeType.Active
  if self._noticeData == nil then
    self._noticeData = self._loginModule:GetNoticeData()
  end
  if self._noticeData then
    local systemState = self._noticeData:GetNoticeNewStateWithGroup(NoticeType.System)
    if systemState then
      openType = NoticeType.System
    end
  end
  self:ShowDialog("UINoticeController", openType)
end

function UIMainLobbyController:HeartBtnOnClick(go)
  Log.info("SingleUserData=============" .. UnityEngine.PlayerPrefs.GetString("SingleUserData"))
  if GameSingle then
    self:ShowDialog("UIHeartSpiritController")
    return
  end
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_HeartSpiritController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Pet)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_PET)
  self:ShowDialog("UIHeartSpiritController")
end

function UIMainLobbyController:UnlockAndSummonOnClick(go)
  self._gamebleBtn:OnClicked()
end

function UIMainLobbyController:HomeBtnOnClick(go)
  GameGlobal.GetModule(HomelandModule):GetUIModule():LoadHomeland()
end

function UIMainLobbyController:OnUpdate(deltaTimeMS)
  if self._scroll and self._main_scroll_inited then
    self._main_scroll:OnUpdate(deltaTimeMS)
  end
  if self._main_lobby_bg then
    self._main_lobby_bg:OnUpdate(deltaTimeMS)
  end
end

function UIMainLobbyController:ShowUIMainLobbyButtomBtns()
  local buttom_btns = self:GetUIComponent("UISelectObjectPath", "UIMainLobbyButtomBtns")
  self._buttom_btns = buttom_btns:SpawnObject("UIMainLobbyButtomBtns")
  self._buttom_btns:SetData()
end

function UIMainLobbyController:GetCurrentPhyTimer()
  local main_top_icon = self:GetUIComponent("UISelectObjectPath", "UIMainLobbyTopIcon")
  self._main_top_icon = main_top_icon:SpawnObject("UIMainLobbyTopIcon")
  self._main_top_icon:SetData(self._toptipsInfo)
end

function UIMainLobbyController:UpdateDrawCardRed()
end

function UIMainLobbyController:OnUpdateWeChatRed()
  local state = self._roleModule:CheckModuleUnlock(GameModuleID.MD_WeChat)
  if state == false then
    self._weChatRedGO:SetActive(false)
    self._weChatCountGO:SetActive(false)
    return
  end
  if self._weChatRedGO then
    local module = self:GetModule(QuestChatModule)
    local chats = module:GetWeChatProxy():GetUnReadChats()
    local count = #chats
    if 0 < count then
      self._weChatRedGO:SetActive(true)
      self._weChatCountGO:SetActive(false)
    else
      self._weChatCountGO:SetActive(false)
      self._weChatRedGO:SetActive(module:GetWeChatProxy():HasRed())
    end
  end
end

function UIMainLobbyController:OnUpdateWeChatMainTalk()
  local state = self._roleModule:CheckModuleUnlock(GameModuleID.MD_WeChat)
  if state == false then
    self._weChatTalkGO:SetActive(false)
    return
  end
  local module = self:GetModule(QuestChatModule)
  self.weChatTalkTxts = module:GetWeChatProxy():GetRandomUnReadChats()
  local isConstructor = module:GetWeChatProxy():IsConstructor()
  self:StopWeChatTalkTimer()
  if self.weChatTalkTxts and #self.weChatTalkTxts > 0 then
    if #self.weChatTalkTxts >= 1 then
      if isConstructor then
        local trigger = UICommonHelper:GetInstance():TrggerLocalRecordTime(self._roleModule:GetPstId() .. "WeChatMainTalk")
        if trigger then
          self._weChatTalkGO:SetActive(true)
          self.maxWeChatTalkCount = #self.weChatTalkTxts
          self:AddWeChatTalkTimer()
          module:GetWeChatProxy():SetIsConstructor(false)
        else
          self._weChatTalkGO:SetActive(false)
          module:GetWeChatProxy():SetIsConstructor(false)
        end
      else
        self._weChatTalkGO:SetActive(true)
        self.maxWeChatTalkCount = #self.weChatTalkTxts
        self:AddWeChatTalkTimer()
      end
    else
      self._weChatTalkGO:SetActive(false)
    end
  else
    self._weChatTalkGO:SetActive(false)
    module:GetWeChatProxy():SetIsConstructor(false)
  end
end

function UIMainLobbyController:AddWeChatTalkTimer()
  self.weChatTalkIndex = 1
  self.weChatTalkTimer = GameGlobal.Timer():AddEventTimes(3000, TimerTriggerCount.Infinite, self.OnWeChatTalkLoop, self)
  self:OnWeChatTalkLoop()
end

function UIMainLobbyController:OnWeChatTalkLoop()
  if self.weChatTalkIndex <= self.maxWeChatTalkCount then
    if self.weChatTalkIndex == 1 then
      self._weChatMainIconRaw.color = Color(1, 1, 1, 1)
      self._weChatMainIconRaw01.color = Color(1, 1, 1, 0)
      self._weChatMainIcon:LoadImage(self.weChatTalkTxts[self.weChatTalkIndex])
      self._weChatTalkAni:Play("uieff_UIMainLobbyController_wechattalk_in")
    else
      self._weChatMainIconRaw.color = Color(1, 1, 1, 1)
      self._weChatMainIconRaw01.color = Color(1, 1, 1, 0)
      self._weChatMainIcon:LoadImage(self.weChatTalkTxts[self.weChatTalkIndex - 1])
      self._weChatMainIcon01:LoadImage(self.weChatTalkTxts[self.weChatTalkIndex])
      self._weChatTalkAni:Play("uieff_UIMainLobbyController_wechattalk_cut")
    end
    self.weChatTalkIndex = self.weChatTalkIndex + 1
  else
    self:StopWeChatTalkTimer()
    self._weChatTalkAni:Play("uieff_UIMainLobbyController_wechattalk_out")
  end
end

function UIMainLobbyController:StopWeChatTalkTimer()
  if self.weChatTalkTimer then
    GameGlobal.Timer():CancelEvent(self.weChatTalkTimer)
    self.weChatTalkTimer = nil
  end
end

function UIMainLobbyController:_CheckWoldBossRedPoint()
  local show = false
  local worldBossModule = self:GetModule(WorldBossModule)
  local redPointData = worldBossModule:GetWorldBossRedPoint()
  show = redPointData:MainLobbyHaveRedPoint()
  self.missionRed:SetActive(show)
end

function UIMainLobbyController:ShowAutoTestLogs()
  if EDITOR then
    self:ShowDialog("UIBattleAutoTest")
  end
end

function UIMainLobbyController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.HomelandUnlock)
end

function UIMainLobbyController:_CheckPreDownLoadPV()
  if not self._preDownLoadPv then
    self._preDownLoadPv = UIMainLobbyDownLoadPV:New()
  end
  self._preDownLoadPv:CheckPreDownLoadPV()
end
