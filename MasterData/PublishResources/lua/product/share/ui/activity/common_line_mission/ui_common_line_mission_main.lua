_class("UICommonLineMissionMain", UISideEnterCenterContentBase)
UICommonLineMissionMain = UICommonLineMissionMain

function UICommonLineMissionMain:DoInit()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaign = self._data
  self._animHide = nil
  self._animShow = nil
  self._lineMissionUI = "UICommonLineMission"
end

function UICommonLineMissionMain:DoShow(uiParams)
  if self._campaign:CheckCampaignNew() then
    self:StartTask(function(TT)
      self._campaign:ClearCampaignNew(TT)
    end, self)
  end
  self:GetComponents()
  self:AddListener()
  self:OnValue()
end

function UICommonLineMissionMain:AddListener()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UICommonLineMissionMain:_OnAfterUILayerChanged()
  self:Red()
end

function UICommonLineMissionMain:GetComponents()
  self.timeStr = self:GetUIComponent("UILocalizationText", "timeStr")
  self.timeStr2 = self:GetUIComponent("UILocalizationText", "timeStr2")
  self.ShowBtn = self:GetGameObject("ShowBtn")
  self.uiAnim = self:GetUIComponent("Animation", "uiAnim")
  self.LineMissionRed = self:GetGameObject("LineMissionRed")
  self.shareBtn = self:GetGameObject("ShareBtn")
  self.reuse = self:GetGameObject("Reuse")
  self.awards = self:GetUIComponent("UISelectObjectPath", "Awards")
  self._hideRoot = self:GetGameObject("HideRoot")
end

function UICommonLineMissionMain:DoHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
    self.animEvent = nil
  end
end

function UICommonLineMissionMain:DoDestroy()
end

function UICommonLineMissionMain:OnValue()
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  self._timerEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetTimerTex()
  end)
  self:SetTimerTex()
  self:Award()
  self:Red()
  if GameGlobal.GetModule(ShareModule):CanShare() then
    if self:CheckShareBtnActive() then
      self:AttachEvent(GameEventType.OnFocusAfterShareBack, self.OnShareResult)
    end
  else
    self.shareBtn:SetActive(false)
  end
  if not IsInland then
    self.reuse:SetActive(true)
  else
    self.reuse:SetActive(false)
  end
end

function UICommonLineMissionMain:CheckShareBtnActive()
  local storyInfo = self._campaign:GetComponentInfo(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_SHARED)
  local storyid = self:GetShareStoryID()
  local dataActive
  if storyInfo.m_recieved_reward_story and table.count(storyInfo.m_recieved_reward_story) > 0 then
    dataActive = not table.icontains(storyInfo.m_recieved_reward_story, storyid)
  else
    local storyReward = Cfg.cfg_campaign_story[storyid].RewardList
    dataActive = storyReward
  end
  self._shareActive = dataActive and GameGlobal.GetModule(ShareModule):CanShare()
  local goShareTip = self:GetGameObject("shareTip")
  if goShareTip ~= nil then
    goShareTip:SetActive(self._shareActive)
  end
  return self._shareActive
end

function UICommonLineMissionMain:GetShareStoryID()
  local comcfgid = self._campaign:GetComponent(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_SHARED):GetComponentCfgId()
  local cfg = Cfg.cfg_component_story[comcfgid]
  if not cfg then
    Log.error("###[UIShareWidget] cfg is nil ! id --> ", comcfgid)
    return
  end
  local storyList = cfg.StoryID
  if not storyList or not next(storyList) then
    Log.error("###[UIShareWidget] storyList is nil !")
    return
  end
  return storyList[1]
end

function UICommonLineMissionMain:SetTimerTex()
  local sample = self._campaign:GetSample()
  local sec
  if not sample then
    sec = 0
  else
    sec = sample.end_time - math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  end
  local strShow
  if sec <= 0 then
    sec = 0
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._timerEvent = nil
    end
    strShow = StringTable.Get("str_activity_finished")
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    local titleStr = "str_n22_activity_linemission_lasttime"
    strShow = StringTable.Get(titleStr) .. ":" .. timeStr
  end
  self.timeStr:SetText(strShow)
  if self.timeStr2 then
    self.timeStr2:SetText(strShow)
  end
end

function UICommonLineMissionMain:HideBtnOnClick()
  if self:CheckCampaignClose() then
    return
  end
  self.ShowBtn:SetActive(true)
  if self._animHide and self._animShow then
    self:Lock("UICommonLineMissionMainAnim")
    if self.uiAnim then
      self.uiAnim:Play(self._animHide)
    end
    if self.animEvent then
      GameGlobal.Timer():CancelEvent(self.animEvent)
    end
    self.animEvent = GameGlobal.Timer():AddEvent(333, function()
      self:UnLock("UICommonLineMissionMainAnim")
    end)
    self:RootUIOwner():HideEntry(true)
  else
    self._hideRoot:SetActive(false)
    self:RootUIOwner():HideEntry()
  end
end

function UICommonLineMissionMain:ShareBtnOnClick()
  if self:CheckCampaignClose() then
    return
  end
  self:HideBtnOnClick()
  self:ShowDialog("UICommonLineMissionMainShare", function()
    self:CheckShareBtnActive()
    self:ShowBtnOnClick()
  end)
end

function UICommonLineMissionMain:Award()
  local awardsEntry = self.awards:SpawnObject("UICommonLineMissionAwardsEntry")
  awardsEntry:SetData(self._campaign, function()
    if self:CheckCampaignClose() then
      return true
    else
      return false
    end
  end)
end

function UICommonLineMissionMain:Red()
  local redLine = not UIActivityHelper.HasCmptRedViewed(UICommonLineMissionConst.LineMissionDBID()) and self._campaign:CheckComponentRed(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_MISSION)
  self.LineMissionRed:SetActive(redLine)
end

function UICommonLineMissionMain:ShowBtnOnClick()
  self.ShowBtn:SetActive(false)
  if self._animHide and self._animShow then
    self:Lock("UICommonLineMissionMainAnim")
    if self.uiAnim then
      self.uiAnim:Play(self._animShow)
    end
    if self.animEvent then
      GameGlobal.Timer():CancelEvent(self.animEvent)
    end
    self.animEvent = GameGlobal.Timer():AddEvent(633, function()
      self:UnLock("UICommonLineMissionMainAnim")
    end)
    self:RootUIOwner():ShowEntry(true)
  else
    self._hideRoot:SetActive(true)
    self:RootUIOwner():ShowEntry()
  end
end

function UICommonLineMissionMain:IntrBtnOnClick()
  if self:CheckCampaignClose() then
    return
  end
  self:ShowDialog("UICommonLineMissionIntro", self._campaign:GetCampaignID())
end

function UICommonLineMissionMain:LineMissionBtnOnClick()
  if self:CheckCampaignClose() then
    return
  end
  self:ShowDialog(self._lineMissionUI, self._campaign)
end

function UICommonLineMissionMain:CheckCampaignClose()
  if not self._campaign:CheckCampaignOpen() then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    return true
  else
    return false
  end
end

function UICommonLineMissionMain:OnShareResult(RetCode)
  Log.debug("###[UICommonLineMissionMain] OnShareResult RetCode:", RetCode)
  if not self._shareActive then
    Log.debug("###[UICommonLineMissionMain] 已经领奖")
    return
  end
  Log.debug("###[UICommonLineMissionMain] 开始领奖表现")
  local storyid = self:GetShareStoryID()
  self:FinishStory(storyid)
end

function UICommonLineMissionMain:FinishStory(id)
  self:Lock("UICommonLineMissionMain:OnFinishStory")
  GameGlobal.TaskManager():StartTask(self.OnFinishStory, self, id)
end

function UICommonLineMissionMain:OnFinishStory(TT, storyid)
  local res = AsyncRequestRes:New()
  local storyCom = self._campaign:GetComponent(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_SHARED)
  local rewards = storyCom:HandleStoryTake(TT, res, storyid)
  self:UnLock("UICommonLineMissionMain:OnFinishStory")
  self._rewards = nil
  if res:GetSucc() then
    Log.error("###[UICommonLineMissionMain] OnFinishStory succ")
    self:ShowRewards(rewards)
  else
    Log.error("###[UICommonLineMissionMain] OnFinishStory fail, result:", res:GetResult(), " storyid:", storyid)
  end
end

function UICommonLineMissionMain:ShowRewards(rewards)
  if not rewards then
    Log.debug("###[UICampaignCenterDanTang] rewards is nil !")
    return
  end
  if self.view == nil then
    return
  end
  self:ShowDialog("UIGetItemController", rewards, function()
    self:CheckShareBtnActive()
  end)
end
