_class("UIN12MainController", UIController)
UIN12MainController = UIN12MainController

function UIN12MainController:Constructor()
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._redDotModule = self:GetModule(RedDotModule)
  self._componentState = {}
  self._showSpine = false
end

function UIN12MainController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST, ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION, ECampaignN12ComponentID.ECAMPAIGN_N12_CUMULATIVE_LOGIN, ECampaignN12ComponentID.ECAMPAIGN_N12_LEVEL_FIXTEAM, ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE, ECampaignN12ComponentID.ECAMPAIGN_N12_STORY, ECampaignN12ComponentID.ECAMPAIGN_N12_QUEST_MISSION)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._dailyMissionComponent = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION)
  self._dailyMissionComponentInfo = self._dailyMissionComponent:GetComponentInfo()
  self._challengeMissionComponent = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  self._challengeMissionComponentInfo = self._challengeMissionComponent:GetComponentInfo()
  self._entrustComponent = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST)
  self._entrustCompInfo = self._entrustComponent:GetComponentInfo()
  self._battlePassCampaign = UIActivityCampaign:New()
  local bp_res = AsyncRequestRes:New()
  self._battlePassCampaign:LoadCampaignInfo(TT, bp_res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN12MainController:OnShow(uiParams)
  self._rt = uiParams[1]
  self:_AttachEvent()
  self:_GetComponent()
  self:_OnValue()
end

function UIN12MainController:_AttachEvent()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIN12MainController:_GetComponent()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end, nil, nil, false, function()
    if not self._showSpine then
      self:_ShowBgSpine(true, "uieff_N12_Main_Hide")
    end
  end)
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._unLockTime = self:GetUIComponent("UILocalizationText", "UnLockTime")
  self._entrustRollingText = self:GetUIComponent("RollingText", "EntrustUnLockTime")
  self._entrustText = self:GetUIComponent("UILocalizationText", "EntrustUnLockTime")
  self._entrustGameLockImg = self:GetGameObject("EntrustGameLockImg")
  self._btnImg = {}
  self._btnImg[ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE] = self:GetUIComponent("Image", "ScoreStore")
  self._btnImg[ECampaignN12ComponentID.ECAMPAIGN_N12_CUMULATIVE_LOGIN] = self:GetUIComponent("Image", "LoginAwardBtn")
  self._btnImg[ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION] = self:GetUIComponent("RawImage", "NormalLevelBtn")
  self._btnImg[ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION] = self:GetUIComponent("Image", "HardLevelBtn")
  self._btnImg[ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST] = self:GetUIComponent("Image", "EntrustGameBtn")
  self._loginAwardRedPoint = self:GetGameObject("LoginAwardRedPoint")
  self._entrustGameRedPoint = self:GetGameObject("EntrustGameRedPoint")
  self._normalLevelRedPoint = self:GetGameObject("NormalLevelRedPoint")
  self._hardLevelRedPoint = self:GetGameObject("HardLevelRedPoint")
  self._scoreStoreRedPoint = self:GetGameObject("ScoreStoreRedPoint")
  self._entrustGameNew = self:GetGameObject("EntrustGameNew")
  self._battlePassRedPoint = self:GetGameObject("BattlePassRedPoint")
  self._animation = self.view.gameObject:GetComponent("Animation")
  self._screenCut = self:GetUIComponent("RawImage", "ScreenCut")
  self._normalLevelText = self:GetUIComponent("RawImage", "NormalLevelText")
  self._textObj = self:GetGameObject("Text")
  self._textRender = self._textObj:GetComponent(typeof(UnityEngine.Renderer))
  self._normalLevelBtnLock = self:GetGameObject("NormalLevelBtnLock")
end

function UIN12MainController:_OnValue()
  if self._rt then
    self._screenCut.texture = self._rt
    self._animation:Play("uieff_N12_Main_In")
  else
    self._animation:Play("uieff_N12_Main_In2")
  end
  self._textRender.material:SetTexture("_MainTex", self._normalLevelText.material:GetTexture("_MainTex"))
  self:_PlayStory()
  self:_RefreshRemainTime()
  self._timeEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_RefreshRemainTime()
  end)
  self:_RefreshEntrustUnLockRemainTime(true)
  local remainTime = self._entrustCompInfo.m_unlock_time - self._svrTimeModule:GetServerTime() * 0.001
  if 0 < remainTime then
    self._entruskTimeEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:_RefreshEntrustUnLockRemainTime(false)
    end)
  end
end

function UIN12MainController:_Close()
  self:SwitchState(UIStateType.UIMain)
end

function UIN12MainController:OnHide()
  if self._timeEvent then
    GameGlobal.Timer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
  if self._entruskTimeEvent then
    GameGlobal.Timer():CancelEvent(self._entruskTimeEvent)
    self._entruskTimeEvent = nil
  end
  if self._clearNewTask then
    GameGlobal.TaskManager():KillTask(self._clearNewTask)
    self._clearNewTask = nil
  end
  if self._refreshCoomponentStateTask then
    GameGlobal.TaskManager():KillTask(self._refreshCoomponentStateTask)
    self._refreshCoomponentStateTask = nil
  end
end

function UIN12MainController:AfterUILayerChanged()
  self:_RefreshComponentState()
  self:_CheckRedPointAll()
  self:_CheckNewAll()
end

function UIN12MainController:_RefreshEntrustUnLockRemainTime(refresh)
  local remainTime = self._entrustCompInfo.m_unlock_time - self._svrTimeModule:GetServerTime() * 0.001
  local str = ""
  if 0 < remainTime then
    str = StringTable.Get("str_n12_activity_unlock_time", N12ToolFunctions.GetRemainTime(remainTime))
  end
  if refresh then
    self._entrustRollingText:RefreshText(str)
  else
    self._entrustText:SetText(str)
  end
  self._entrustGameLockImg:SetActive(0 < remainTime)
  if remainTime <= 0 and self._entruskTimeEvent then
    GameGlobal.Timer():CancelEvent(self._entruskTimeEvent)
    self._entruskTimeEvent = nil
    self._refreshCoomponentStateTask = self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST)
      self._campaign:ReLoadCampaignInfo_Force(TT, res)
      if res:GetSucc() then
        self:_RefreshComponentState()
      end
    end)
  end
end

function UIN12MainController:_RefreshRemainTime()
  local str = "str_n12_reward_remain_time"
  local remainTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  remainTime = self._dailyMissionComponentInfo.m_close_time - curtime
  if 0 < remainTime then
    str = "str_n12_normal_remain_time"
  else
    remainTime = self._entrustCompInfo.m_close_time - curtime
    if 0 < remainTime then
      str = "str_n12_entrust_remain_time"
    end
  end
  self._remainTime:SetText(StringTable.Get(str, N12ToolFunctions.GetRemainTime(remainTime)))
  if remainTime <= 0 and self._timeEvent then
    GameGlobal.Timer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
end

function UIN12MainController:_RefreshComponentState()
  for key, value in pairs(ECampaignN12ComponentID) do
    self._componentState[value] = self:_GetComponentState(value)
    if self._btnImg[value] then
      if self._componentState[value] then
        self._btnImg[value].color = Color.white
      else
        self._btnImg[value].color = Color.gray
      end
      if value == ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION then
        self._normalLevelBtnLock:SetActive(not self._componentState[value])
      end
    end
  end
end

function UIN12MainController:_GetComponentState(componentid)
  return self._campaign:CheckComponentOpen(componentid)
end

function UIN12MainController:_CheckRedPointAll()
  self._loginAwardRedPoint:SetActive(self._redDotModule:_RequestRedDotStatus4N12(RedDotType.RDT_N12_LOGIN_AWARD))
  self._entrustGameRedPoint:SetActive(false)
  self._normalLevelRedPoint:SetActive(self._redDotModule:_RequestRedDotStatus4N12(RedDotType.RDT_N12_DAILYMISSION))
  self._hardLevelRedPoint:SetActive(self._redDotModule:_RequestRedDotStatus4N12(RedDotType.RDT_N12_CHALLENGEEMISSION) or self._redDotModule:_RequestRedDotStatus4N12(RedDotType.RDT_N12_FIXLINEMISSION))
  self._scoreStoreRedPoint:SetActive(self._redDotModule:_RequestRedDotStatus4N12(RedDotType.RDT_N12_SCORE_AWARD) or self._redDotModule:_RequestRedDotStatus4N12(RedDotType.RDT_N12_STORY))
  self._battlePassRedPoint:SetActive(UIActivityBattlePassHelper.CheckCampaignRedPoint(self._battlePassCampaign))
end

function UIN12MainController:_CheckNewAll()
  self._entrustGameNew:SetActive(self._redDotModule:_RequestRedDotStatus4N12(RedDotType.RDT_N12_ENTRUSTMISSION_NEW))
end

function UIN12MainController:ActivityIntroBtnOnClick(go)
  self:ShowDialog("UIN12IntroController", "UIN12MainController")
end

function UIN12MainController:BattlePassBtnOnClick(go)
  UIActivityBattlePassHelper.OpenMainController()
end

function UIN12MainController:ScoreStoreOnClick(go)
  if not self._componentState[ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE] then
    ToastManager.ShowToast(StringTable.Get("str_n12_activity_over"))
    return
  end
  self:SwitchState(UIStateType.UIN12IntegralController)
end

function UIN12MainController:LoginAwardBtnOnClick(go)
  if not self._componentState[ECampaignN12ComponentID.ECAMPAIGN_N12_CUMULATIVE_LOGIN] then
    ToastManager.ShowToast(StringTable.Get("str_n12_activity_over"))
    return
  end
  self:ShowDialog("UIActivityTotalLoginAwardController", true, ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_CUMULATIVE_LOGIN)
end

function UIN12MainController:NormalLevelBtnOnClick(go)
  local remainTime = self._dailyMissionComponentInfo.m_unlock_time - self._svrTimeModule:GetServerTime() * 0.001
  if 0 < remainTime then
    ToastManager.ShowToast(StringTable.Get("str_n12_activity_lock"))
    return
  end
  if not self._componentState[ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION] then
    ToastManager.ShowToast(StringTable.Get("str_n12_activity_over"))
    return
  end
  self:SwitchState(UIStateType.UIN12NormalLevel)
end

function UIN12MainController:HardLevelBtnOnClick(go)
  local remainTime = self._challengeMissionComponentInfo.m_unlock_time - self._svrTimeModule:GetServerTime() * 0.001
  if 0 < remainTime then
    ToastManager.ShowToast(StringTable.Get("str_n12_activity_lock"))
    return
  end
  if not self._componentState[ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION] then
    ToastManager.ShowToast(StringTable.Get("str_n12_activity_over"))
    return
  end
  self:SwitchState(UIStateType.UIN12HardlLevel)
end

function UIN12MainController:EntrustGameBtnOnClick(go)
  local remainTime = self._entrustCompInfo.m_unlock_time - self._svrTimeModule:GetServerTime() * 0.001
  if 0 < remainTime then
    ToastManager.ShowToast(StringTable.Get("str_n12_activity_lock"))
    return
  end
  if not self._componentState[ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST] then
    ToastManager.ShowToast(StringTable.Get("str_n12_activity_over"))
    return
  end
  self:SwitchState(UIStateType.UIN12EntrustStageController)
end

function UIN12MainController:_ShowBgSpine(showSpine, animationName)
  self._showSpine = showSpine
  self._animation:Play(animationName)
end

function UIN12MainController:bgOnClick(go)
  if self._showSpine then
    self:_ShowBgSpine(false, "uieff_N12_Main_Show")
  end
end

function UIN12MainController:StoryReviewBtnOnClick(go)
  local canReviewStages = {}
  local cfgs = Cfg.cfg_n12_story_review({})
  if cfgs then
    for i = 1, #cfgs do
      local cfg = cfgs[i]
      local curStage = DiscoveryStage:New()
      curStage.id = cfg.ID
      curStage.longDesc = StringTable.Get(cfg.Des)
      curStage.name = StringTable.Get(cfg.Name)
      curStage.stageIdx = StringTable.Get(cfg.StageIndexTitle)
      curStage.fullname = StringTable.Get(cfg.FullName)
      local storyList = DiscoveryStoryList:New()
      local slist = {}
      storyList.stageId = cfg.ID
      local storyListCfg = cfg.StoryList
      for j = 1, #storyListCfg do
        local story = DiscoveryStory:New()
        story:Init(storyListCfg[j][1], storyListCfg[j][2])
        table.insert(slist, story)
      end
      storyList.list = slist
      curStage.story = storyList
      table.insert(canReviewStages, curStage)
    end
  end
  local tempStage = canReviewStages[1]
  self:ShowDialog("UIPlot", tempStage, canReviewStages, false, true, StringTable.Get("str_n12_story_review_stage_title"))
end

function UIN12MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN12MainController)
end

function UIN12MainController:_PlayStory()
  if not self._campaign:GetSample():GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    return
  end
  if self._cfg_campaign ~= nil then
    if self._cfg_campaign.FirstEnterStoryID ~= nil and self._cfg_campaign.FirstEnterStoryID[1] ~= nil then
      GameGlobal.GetModule(StoryModule):StartStory(self._cfg_campaign.FirstEnterStoryID[1], function()
        self._clearNewTask = self:StartTask(function(TT)
          local res = AsyncRequestRes:New()
          GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._campaign._id)
          if res:GetSucc() then
            Log.info("n12 play first enter story succ.")
            self:_CheckGuide()
          end
        end, self)
      end, true)
    else
      self._clearNewTask = self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._campaign._id)
        if res:GetSucc() then
          self:_CheckGuide()
          Log.info("n12 play first enter story succ.")
        end
      end, self)
    end
  end
end
