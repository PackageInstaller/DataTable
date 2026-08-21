_class("UIActivityEveSinsaSwitchLevelBtn", UICustomWidget)
UIActivityEveSinsaSwitchLevelBtn = UIActivityEveSinsaSwitchLevelBtn
local EActivityEveSinsaLevelBtnType = {EType_A = 1, EType_B = 2}
_enum("EActivityEveSinsaLevelBtnType", EActivityEveSinsaLevelBtnType)

function UIActivityEveSinsaSwitchLevelBtn:_GetComponents()
  self._lockObj = self:GetGameObject("_lock")
  self._normalObj = self:GetGameObject("_normal")
  self._remainingText = self:GetUIComponent("UILocalizationText", "_remainingText")
  self._titleText = self:GetUIComponent("UILocalizationText", "_titleText")
  self._title2Text = self:GetUIComponent("UILocalizationText", "_title2Text")
  self._newFlag = self:GetGameObject("newFlag")
  self._redPoint = self:GetGameObject("redPoint")
end

function UIActivityEveSinsaSwitchLevelBtn:OnShow()
  self._isOpen = true
  self:_GetComponents()
end

function UIActivityEveSinsaSwitchLevelBtn:OnHide()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
  self._timeEventForClose = UIActivityHelper.CancelTimerEvent(self._timeEventForClose)
end

function UIActivityEveSinsaSwitchLevelBtn:SetData(campaign, type, isMain)
  self._campaign = campaign
  self._type = type
  self._isMain = isMain
  self._phase = UIActivityEveSinsaHelper.CheckTimePhase(self._campaign)
  self._lockObj:SetActive(self._type == EActivityEveSinsaLevelBtnType.EType_B)
  self._normalObj:SetActive(self._type == EActivityEveSinsaLevelBtnType.EType_A)
  self:_SetTitle()
  if self._phase == EActivityEveSinsaTimePhase.EPhase_Shop then
    self._lockObj:SetActive(false)
    self._normalObj:SetActive(true)
  else
    self:_SetTimer()
    self:_SetTimerForClose()
  end
  self:_CheckNewFlagRedPoint()
end

function UIActivityEveSinsaSwitchLevelBtn:_CheckNewFlagRedPoint()
  local campaignModule = self:GetModule(CampaignModule)
  local data = campaignModule:GetEveSinsaNewFlagRedPoint()
  if self._type == EActivityEveSinsaLevelBtnType.EType_A then
    local showNew = data:P1SStageUnLockNew()
    self._newFlag:SetActive(showNew)
    local showRedPoint = data:PetStageRedPoint() or data:ActionPointRedPoint()
    self._redPoint:SetActive(showRedPoint and not showNew)
  elseif self._type == EActivityEveSinsaLevelBtnType.EType_B then
    self._newFlag:SetActive(data:P2StageUnLockNew())
    self._redPoint:SetActive(false)
  end
end

function UIActivityEveSinsaSwitchLevelBtn:_SetTitle()
  local type2id = {
    "str_activity_evesinsa_main_levelabtn",
    "str_activity_evesinsa_main_levelbbtn"
  }
  local id = type2id[self._type]
  self._titleText:SetText(StringTable.Get(id))
  if self._title2Text then
    local phase2id = {
      "str_activity_evesinsa_main_actionsecond",
      "str_activity_evesinsa_main_actionsecond",
      "str_activity_error_107"
    }
    id = phase2id[self._phase]
    self._title2Text:SetText(StringTable.Get(id))
  end
end

function UIActivityEveSinsaSwitchLevelBtn:_SetTimer()
  if self._type == EActivityEveSinsaLevelBtnType.EType_B then
    self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
      return self:_SetRemainingTimer()
    end)
  else
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
  end
end

function UIActivityEveSinsaSwitchLevelBtn:_SetTimerForClose()
  self._timeEventForClose = UIActivityHelper.StartTimerEvent(self._timeEventForClose, function()
    if self._isOpen then
      local svrTimeModule = self:GetModule(SvrTimeModule)
      local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
      local endTime = UIActivityEveSinsaHelper.GetPhaseEndTime(self._campaign, EActivityEveSinsaTimePhase.EPhase_Tree)
      local stamp = endTime - curTime
      if stamp < 0 then
        self._phase = UIActivityEveSinsaHelper.CheckTimePhase(self._campaign)
        self:_SetTitle()
        self:_CheckNewFlagRedPoint()
        self._timeEventForClose = UIActivityHelper.CancelTimerEvent(self._timeEventForClose)
        return true
      end
    end
  end)
end

function UIActivityEveSinsaSwitchLevelBtn:_SetRemainingTimer()
  if self._isOpen then
    local uiText = self._remainingText
    local formatStr = "<color=#%s>%s</color>"
    if self._isMain then
      local extra = StringTable.Get("str_activity_evesinsa_shop_group_unlock_time")
      formatStr = "<color=#%s>" .. extra .. " %s</color>"
    end
    local colorStr = "DECE00"
    local svrTimeModule = self:GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    local endTime = UIActivityEveSinsaHelper.GetPhaseEndTime(self._campaign, EActivityEveSinsaTimePhase.EPhase_Line)
    local stamp = endTime - curTime
    local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
    local showStr = string.format(formatStr, colorStr, timeStr)
    uiText:SetText(showStr)
    if stamp <= 0 then
      self:_CheckUnlockLevel()
      self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
      return true
    end
  end
end

function UIActivityEveSinsaSwitchLevelBtn:_CheckUnlockLevel()
  local componet = self._campaign:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_TREE_MISSION)
  if componet:ComponentIsUnLock() then
    self._lockObj:SetActive(false)
    self._normalObj:SetActive(true)
  else
    local uiText = self._remainingText
    local formatStr = "<color=#%s>%s</color>"
    local colorStr = "DECE00"
    local strId = "str_activity_evesinsa_main_lockbtn_level"
    local showStr = string.format(formatStr, colorStr, StringTable.Get(strId))
    uiText:SetText(showStr)
  end
end

function UIActivityEveSinsaSwitchLevelBtn:btnOnClick()
  Log.info("UIActivityEveSinsaSwitchLevelBtn:btnOnClick")
  self._phase = UIActivityEveSinsaHelper.CheckTimePhase(self._campaign)
  if self._type == EActivityEveSinsaLevelBtnType.EType_B and self._phase == EActivityEveSinsaTimePhase.EPhase_Tree then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.GoHome)
    self:_SetFirstPlot()
  else
    self:_OpenDialog()
  end
end

function UIActivityEveSinsaSwitchLevelBtn:_SetFirstPlot()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local keyStr = string.format("UIActivityEveSinsa_LevelBtn_Plot_%s_%s", self._campaign._id, pstId)
  if LocalDB.HasKey(keyStr) then
    Log.info("UIActivityEveSinsaSwitchLevelBtn:_SetFirstPlot() keyStr = ", keyStr)
    self:_OpenDialog()
    return
  end
  LocalDB.SetInt(keyStr, 1)
  local storyID = 0
  local cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  if cfg_campaign then
    storyID = cfg_campaign.FirstEnterStoryID[2]
  end
  if storyID ~= 0 then
    self:ShowDialog("UIStoryController", storyID, function()
      self:StartTask(function(TT)
        self:_OpenDialog()
      end, self)
    end)
  end
end

function UIActivityEveSinsaSwitchLevelBtn:_OpenDialog()
  if self._type == EActivityEveSinsaLevelBtnType.EType_A then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.WindPlace)
  elseif self._type == EActivityEveSinsaLevelBtnType.EType_B then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.GoHome)
  end
  local type2show = {
    "UIActivityEveSinsaLevelAController",
    "UIActivityEveSinsaLevelBController"
  }
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:CampaignSwitchState(true, type2show[self._type], UIStateType.UIMain, nil, self._campaign._id)
end
