_class("UIActivityEveSinsaMainController", UIController)
UIActivityEveSinsaMainController = UIActivityEveSinsaMainController

function UIActivityEveSinsaMainController:_GetComponents()
  self._mainBg = self:GetUIComponent("RawImageLoader", "_mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end)
  local exchangeRewardBtn = self:GetUIComponent("UISelectObjectPath", "_exchangeRewardBtn")
  self._exchangeRewardBtn = exchangeRewardBtn:SpawnObject("UIActivityEveSinsaShopBtn")
  self._exchangeRewardBtn:SetData(self._campaign, true)
  local LevelABtn = self:GetUIComponent("UISelectObjectPath", "_LevelABtn")
  self._LevelABtn = LevelABtn:SpawnObject("UIActivityEveSinsaSwitchLevelBtn")
  self._LevelABtn:SetData(self._campaign, EActivityEveSinsaLevelBtnType.EType_A, true)
  local LevelBBtn = self:GetUIComponent("UISelectObjectPath", "_LevelBBtn")
  self._LevelBBtn = LevelBBtn:SpawnObject("UIActivityEveSinsaSwitchLevelBtn")
  self._LevelBBtn:SetData(self._campaign, EActivityEveSinsaLevelBtnType.EType_B, true)
  self._txtRemainingTimeDesc = self:GetUIComponent("UILocalizationText", "_txtRemainingTimeDesc")
  self._txtRemainingTimeTxt = self:GetUIComponent("UILocalizationText", "_txtRemainingTimeTxt")
  self._redLoginRewardBtn = self:GetGameObject("_redLoginRewardBtn")
  self._redTaskRewardBtn = self:GetGameObject("_redTaskRewardBtn")
end

function UIActivityEveSinsaMainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_EXCHANGE1, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_EXCHANGE2, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_PERSON_PROGRESS, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_CUMULATIVE_LOGIN, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_QUEST, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_LINE_MISSION, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_TREE_MISSION)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityEveSinsaMainController:OnShow(uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._isOpen = true
  self._timePhase = nil
  self:_GetComponents()
  if not self._campaign:GetSample():GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    self:_SetUI()
  else
    self:_SetFirstPlot()
  end
end

function UIActivityEveSinsaMainController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end

function UIActivityEveSinsaMainController:_SetFirstPlot()
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

function UIActivityEveSinsaMainController:_SetUI()
  self:_UpdateTimePhase()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
  self:_AttachEvents()
  self:_CheckRedPointAll()
end

function UIActivityEveSinsaMainController:_SetBg(phase)
  local url = UIActivityEveSinsaHelper.GetPhaseBgUrl(self._campaign, phase)
  if url then
    self._mainBg:LoadImage(url)
  end
end

function UIActivityEveSinsaMainController:_SetTitleDesc(phase)
  local phase2id = {
    "str_activity_evesinsa_main_title_desc_1",
    "str_activity_evesinsa_main_title_desc_1",
    "str_activity_evesinsa_main_title_desc_2"
  }
  local id = phase2id[phase]
  self._txtRemainingTimeDesc:SetText(StringTable.Get(id))
end

function UIActivityEveSinsaMainController:_UpdateTimePhase()
  local phase = UIActivityEveSinsaHelper.CheckTimePhase(self._campaign)
  if self._timePhase ~= phase then
    self._timePhase = phase
    self:_SetBg(self._timePhase)
    self:_SetTitleDesc(self._timePhase)
  end
end

function UIActivityEveSinsaMainController:_SetRemainingTimer()
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
    local endTime = UIActivityEveSinsaHelper.GetPhaseEndTime(self._campaign, phase2endphase[phase])
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

function UIActivityEveSinsaMainController:LoginRewardBtnOnClick(go)
  Log.info("UIActivityEveSinsaMainController:LoginRewardBtnOnClick")
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_CUMULATIVE_LOGIN)
end

function UIActivityEveSinsaMainController:TaskRewardBtnOnClick(go)
  Log.info("UIActivityEveSinsaMainController:TaskRewardBtnOnClick")
  self:ShowDialog("UIActivityEveSinsaTaskController", ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN)
end

function UIActivityEveSinsaMainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIActivityEveSinsaMainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIActivityEveSinsaMainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityEveSinsaMainController:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckRedPointAll()
  end
end

function UIActivityEveSinsaMainController:_CheckRedPointAll()
  self:_CheckRedPoint(self._redTaskRewardBtn, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_PERSON_PROGRESS, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_QUEST)
  self:_CheckRedPoint(self._redLoginRewardBtn, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_CUMULATIVE_LOGIN)
end

function UIActivityEveSinsaMainController:_CheckRedPoint(obj, ...)
  local bShow = self._campaign:CheckComponentRed(...)
  obj:SetActive(bShow)
end

function UIActivityEveSinsaMainController:infoBtnOnClick(go)
  self:ShowDialog("UIActivityEveSinsaIntrController")
end
