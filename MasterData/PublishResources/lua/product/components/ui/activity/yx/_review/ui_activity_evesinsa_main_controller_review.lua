_class("UIActivityEveSinsaMainController_Review", UIController)
UIActivityEveSinsaMainController_Review = UIActivityEveSinsaMainController_Review

function UIActivityEveSinsaMainController_Review:_GetComponents()
  self._mainBg = self:GetUIComponent("RawImageLoader", "_mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIActivityReview)
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
  local LevelABtn = self:GetUIComponent("UISelectObjectPath", "_LevelABtn")
  self._LevelABtn = LevelABtn:SpawnObject("UIActivityEveSinsaSwitchLevelBtn_Review")
  self._LevelABtn:SetData(self._campaign, EActivityEveSinsaLevelBtnType.EType_A, true)
  local LevelBBtn = self:GetUIComponent("UISelectObjectPath", "_LevelBBtn")
  self._LevelBBtn = LevelBBtn:SpawnObject("UIActivityEveSinsaSwitchLevelBtn_Review")
  self._LevelBBtn:SetData(self._campaign, EActivityEveSinsaLevelBtnType.EType_B, true)
  self._txtRemainingTimeDesc = self:GetUIComponent("UILocalizationText", "_txtRemainingTimeDesc")
  self._txtRemainingTimeTxt = self:GetUIComponent("UILocalizationText", "_txtRemainingTimeTxt")
  self._redLoginRewardBtn = self:GetGameObject("_redLoginRewardBtn")
  self._redTaskRewardBtn = self:GetGameObject("_redTaskRewardBtn")
end

function UIActivityEveSinsaMainController_Review:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  self._reviewData = uiModule:GetReviewData():GetActivityByType(ECampaignType.CAMPAIGN_TYPE_REVIEW_N1)
  self._reviewData:ReqDetailInfo(TT, res)
  self._campaign = self._reviewData:GetDetailInfo()
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityEveSinsaMainController_Review:OnShow(uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._isOpen = true
  self._timePhase = nil
  self:_GetComponents()
  if not self._campaign:GetSample():GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    self:_SetUI()
  else
    self:_SetFirstPlot()
  end
  self:_SetProgress()
end

function UIActivityEveSinsaMainController_Review:HideBtnOnClick()
  local leftUp = self:GetGameObject("_LeftUp")
  leftUp:SetActive(false)
  local leftDown = self:GetGameObject("_LeftDown")
  leftDown:SetActive(false)
  local rightDown = self:GetGameObject("_RightDown")
  rightDown:SetActive(false)
  local rightUp = self:GetGameObject("_RightUp")
  rightUp:SetActive(false)
  local progress = self:GetGameObject("Progress")
  progress:SetActive(false)
  local showBtn = self:GetGameObject("_ShowBtn")
  showBtn:SetActive(true)
end

function UIActivityEveSinsaMainController_Review:ShowBtnOnClick()
  local leftUp = self:GetGameObject("_LeftUp")
  leftUp:SetActive(true)
  local leftDown = self:GetGameObject("_LeftDown")
  leftDown:SetActive(true)
  local rightDown = self:GetGameObject("_RightDown")
  rightDown:SetActive(true)
  local rightUp = self:GetGameObject("_RightUp")
  rightUp:SetActive(true)
  local progress = self:GetGameObject("Progress")
  progress:SetActive(true)
  local showBtn = self:GetGameObject("_ShowBtn")
  showBtn:SetActive(false)
end

function UIActivityEveSinsaMainController_Review:OnHide()
  self:_DetachEvents()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end

function UIActivityEveSinsaMainController_Review:_SetProgress()
  local progress = UIReviewProgressConst.SpawnObject(self, "Progress", self._reviewData)
end

function UIActivityEveSinsaMainController_Review:_SetFirstPlot()
  local storyID = 0
  local cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  if cfg_campaign then
    storyID = cfg_campaign.FirstEnterStoryID[1]
  end
  if storyID == 0 then
    self:_SetUI()
    self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CampaignClearNewFlag(TT, res, self._campaign._id)
      if not res:GetSucc() then
        Log.info("UIActivityEveSinsaMainController:_SetFirstPlot() CampaignClearNewFlag res.m_result = ", res.m_result)
      end
    end, self)
    return
  end
  self:ShowDialog("UIStoryController", storyID, function()
    self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CampaignClearNewFlag(TT, res, self._campaign._id)
      if not res:GetSucc() then
        Log.info("UIActivityEveSinsaMainController:_SetFirstPlot() CampaignClearNewFlag res.m_result = ", res.m_result)
      end
      self:_SetUI()
    end, self)
  end)
end

function UIActivityEveSinsaMainController_Review:_SetUI()
  self:_UpdateTimePhase()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
  self:_AttachEvents()
  self:_CheckRedPointAll()
end

function UIActivityEveSinsaMainController_Review:_SetBg(phase)
  self._mainBg:LoadImage("event_eve_home1")
end

function UIActivityEveSinsaMainController_Review:_SetTitleDesc(phase)
  local phase2id = {
    "str_activity_evesinsa_main_title_desc_1",
    "str_activity_evesinsa_main_title_desc_1",
    "str_activity_evesinsa_main_title_desc_2"
  }
  local id = phase2id[phase]
  self._txtRemainingTimeDesc:SetText(StringTable.Get(id))
end

function UIActivityEveSinsaMainController_Review:_UpdateTimePhase()
  local phase = UIActivityEveSinsaHelper_Review.CheckTimePhase(self._campaign)
  if self._timePhase ~= phase then
    self._timePhase = phase
    self:_SetBg(self._timePhase)
    self:_SetTitleDesc(self._timePhase)
  end
end

function UIActivityEveSinsaMainController_Review:_SetRemainingTimer()
  if self._isOpen then
    self:_UpdateTimePhase()
    local phase2endphase = {
      EActivityEveSinsaTimePhase.EPhase_Tree,
      EActivityEveSinsaTimePhase.EPhase_Tree,
      EActivityEveSinsaTimePhase.EPhase_Shop
    }
    local uiText = self._txtRemainingTimeTxt
    local formatStr = "<color=#%s>%s</color>"
    local colorStr = "FFFFFF"
    local phase = self._timePhase
    if self._timePhase == EActivityEveSinsaTimePhase.EPhase_Over then
      phase = EActivityEveSinsaTimePhase.EPhase_Shop
    end
    local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
    local endTime = UIActivityEveSinsaHelper_Review.GetPhaseEndTime(self._campaign, phase2endphase[phase])
    local stamp = endTime - curTime
    local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
    local showStr = string.format(formatStr, colorStr, timeStr)
    uiText:SetText(showStr)
    if stamp <= 0 then
      self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
      return true
    end
  end
end

function UIActivityEveSinsaMainController_Review:LoginRewardBtnOnClick(go)
end

function UIActivityEveSinsaMainController_Review:TaskRewardBtnOnClick(go)
  Log.info("UIActivityEveSinsaMainController:TaskRewardBtnOnClick")
  self:ShowDialog("UIActivityEveSinsaTaskController", ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN)
end

function UIActivityEveSinsaMainController_Review:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIActivityEveSinsaMainController_Review:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIActivityEveSinsaMainController_Review:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityEveSinsaMainController_Review:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckRedPointAll()
  end
end

function UIActivityEveSinsaMainController_Review:_CheckRedPointAll()
  self:_CheckRedPoint(self._redTaskRewardBtn)
  self:_CheckRedPoint(self._redLoginRewardBtn)
end

function UIActivityEveSinsaMainController_Review:_CheckRedPoint(obj, ...)
  obj:SetActive(false)
end

function UIActivityEveSinsaMainController_Review:infoBtnOnClick(go)
  self:ShowDialog("UIActivityEveSinsaIntrController")
end
