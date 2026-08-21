_class("UIActivityCN6N35HardLevelMain", UIController)
UIActivityCN6N35HardLevelMain = UIActivityCN6N35HardLevelMain

function UIActivityCN6N35HardLevelMain:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:LoadData(TT, res)
  UIActivityDiffLevelCupData.CreateEntiesDesc()
end

function UIActivityCN6N35HardLevelMain:OnShow(uiParams)
  self._isNormalUI = uiParams[1] and true
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._anim2 = self:GetUIComponent("Animation", "Anim2")
  self._tipsAnim = self:GetUIComponent("Animation", "TipsAnim")
  self.LockTime = self:GetUIComponent("UILocalizationText", "LockTime")
  self._hardBG = self:GetGameObject("HardBG")
  self._diffBG = self:GetGameObject("DiffBG")
  self._hardLevelMask = self:GetGameObject("HardLevelMask")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self._isNormalUI then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityMainStatusRefreshEvent)
      self:CloseDialog()
    else
      self:SwitchState(UIStateType.UIActivityCN6N35MainController)
    end
  end)
  self._levelType = uiParams[2] or 1
  if uiParams[2] == nil and self:HardLevelOpen() then
    self._levelType = 2
  end
  if self:IsShowHardLevelTips() then
    self._levelType = 2
  end
  self._tips = self:GetGameObject("Tips")
  self._tips:SetActive(false)
  self._normalLevel = UIActivityCN6N35HardLevel:New(self)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._normalLevel:SetActive(false)
  self._diffLevel = UIActivityCN6N35DiffLevel:New(self)
  self._diffLevel:SetData(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  self._diffLevel:SetActive(false)
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  self:SwitchLevelType(self._levelType, true)
  self:PlayEnterAnim()
end

function UIActivityCN6N35HardLevelMain:OnHide()
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  if self._diffLevel then
    self._diffLevel:Destroy()
  end
  if self._normalLevel then
    self._normalLevel:Destroy()
  end
end

function UIActivityCN6N35HardLevelMain:LoadData(TT, res)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_N6, ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION, ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA)
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    CutsceneManager.ExcuteCutsceneOut_Shot()
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  self._levelHardComponent = self._localProcess:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION)
  self._levelHardCompInfo = self._localProcess:GetComponentInfo(ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION)
  self._blackHardComponent = self._localProcess:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA)
  self._blackHardCompInfo = self._localProcess:GetComponentInfo(ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA)
end

function UIActivityCN6N35HardLevelMain:OnTeamReset()
  self:StartTask(self.OnTeamResetCoro, self)
end

function UIActivityCN6N35HardLevelMain:OnTeamResetCoro(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self:LoadData(TT, res)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._diffLevel:Refresh(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamResetInternal)
end

function UIActivityCN6N35HardLevelMain:SwitchLevelType(levelType, playAnim)
  if levelType == 1 then
    self._diffLevel:SetActive(false)
    self._normalLevel:SetActive(true)
    self._hardBG:SetActive(true)
    self._diffBG:SetActive(false)
  elseif levelType == 2 then
    self._diffLevel:SetActive(true)
    self._normalLevel:SetActive(false)
    self._hardBG:SetActive(false)
    self._diffBG:SetActive(true)
    UIActivityCustomHelper.SetNewFlagStatus("ACTIVITY_NEW" .. ECampaignType.CAMPAIGN_TYPE_INLAND_N6 .. ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange)
  end
end

function UIActivityCN6N35HardLevelMain:HardLevelOpen()
  if not self._blackHardComponent then
    return false
  end
  return self._blackHardComponent:ComponentIsOpen()
end

function UIActivityCN6N35HardLevelMain:GetPlayerPrefsKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_CN6N35_HARD_LEVEL_SHOW_TIPS_FLAG"
  return key
end

function UIActivityCN6N35HardLevelMain:IsShowHardLevelTips()
  if not self:HardLevelOpen() then
    return false
  end
  local key = self:GetPlayerPrefsKey()
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityCN6N35HardLevelMain:RefreshSwitchBtnStatus()
end

function UIActivityCN6N35HardLevelMain:BtnCloseOnClick()
  self:StartTask(self.BtnCloseOnClickCoro, self)
end

function UIActivityCN6N35HardLevelMain:BtnCloseOnClickCoro(TT)
  if self._tipsAnim then
  end
  self._tips:SetActive(false)
end

function UIActivityCN6N35HardLevelMain:NormalLevelOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 1 then
    return
  end
  if self._levelHardComponent:ComponentIsOpen() == false then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityCN6N35MainController)
    return
  end
  self._levelType = 1
  self:RefreshSwitchBtnStatus()
  self:PlaySwitchAnim(self._levelType)
end

function UIActivityCN6N35HardLevelMain:HardLevelOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 2 then
    return
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  if curTime >= self._blackHardCompInfo.m_close_time then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityCN6N35MainController)
    return
  end
  if curTime < self._blackHardCompInfo.m_unlock_time then
    ToastManager.ShowToast(StringTable.Get("str_cn6&n35_hard_level_time_lock"))
    return
  end
  if not self:HardLevelOpen() then
    ToastManager.ShowToast(StringTable.Get("str_cn6&n35_hard_level_unopen"))
    return
  end
  self._levelType = 2
  self:RefreshSwitchBtnStatus()
  self:PlaySwitchAnim(self._levelType)
end

function UIActivityCN6N35HardLevelMain:PlaySwitchAnim(levelType)
  self:StartTask(self.PlaySwitchAnimCoro, self, levelType)
end

function UIActivityCN6N35HardLevelMain:PlaySwitchAnimCoro(TT, levelType)
  self:Lock("UIActivityCN6N35HardLevelMain_PlaySwitchAnimCoro")
  local animName = ""
  if levelType == 1 then
    animName = "uieff_UIActivityCN6N35HardLevelMain_switch_Hard"
  elseif levelType == 2 then
    UIActivityCustomHelper.SetNewFlagStatus("ACTIVITY_NEW" .. ECampaignType.CAMPAIGN_TYPE_INLAND_N6 .. ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange)
    animName = "uieff_UIActivityCN6N35HardLevelMain_switch_Diff"
  end
  if self._anim2 then
    self._anim2:Play(animName)
    YIELD(TT, 300)
  end
  self:SwitchLevelType(levelType, false)
  self:UnLock("UIActivityCN6N35HardLevelMain_PlaySwitchAnimCoro")
end

function UIActivityCN6N35HardLevelMain:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityCN6N35HardLevelMain:PlayEnterAnimCoro(TT)
  if self:IsShowHardLevelTips() == false then
    self:RefreshLockUI()
  end
  self:Lock("UIActivityCN6N35HardLevelMain_PlayEnterAnimCoro")
  local animName = ""
  if self._levelType == 1 then
    animName = "uieff_UIActivityCN6N35HardLevelMain_Hard_in"
  elseif self._levelType == 2 then
    animName = "uieff_UIActivityCN6N35HardLevelMain_Diff_in"
  end
  if self._anim then
    self._anim:Play(animName)
    YIELD(TT, 333)
  end
  if self:IsShowHardLevelTips() then
    if self._tipsAnim then
      self:RefreshLockUI()
    else
      self:RefreshLockUI()
    end
    UnityEngine.PlayerPrefs.SetInt(self:GetPlayerPrefsKey(), 1)
  else
    self._tips:SetActive(false)
    self:RefreshLockUI()
  end
  self:UnLock("UIActivityCN6N35HardLevelMain_PlayEnterAnimCoro")
end

function UIActivityCN6N35HardLevelMain:RefreshLockUI()
end

function UIActivityCN6N35HardLevelMain:ClosePetEnhanceTips()
end

function UIActivityCN6N35HardLevelMain:OnUpdate(deltaTimeMS)
  self:RefreshLockTime()
end

function UIActivityCN6N35HardLevelMain:RefreshLockTime()
  local openTime = self._blackHardCompInfo.m_unlock_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if openTime > curTime then
    local deltaTime = math.max(openTime - curTime, 0)
    local timerStr = self:GetFormatTimerStr(deltaTime)
    local txt = StringTable.Get("str_cn6&n35_hard_cdtime") .. timerStr
    self._hardLevelMask:SetActive(true)
    self.LockTime.gameObject:SetActive(true)
    self.LockTime:SetText(txt)
  else
    if not self:HardLevelOpen() then
      self._hardLevelMask:SetActive(true)
      self.LockTime.gameObject:SetActive(false)
      return
    end
    self._hardLevelMask:SetActive(false)
    self.LockTime.gameObject:SetActive(false)
  end
end

function UIActivityCN6N35HardLevelMain:GetFormatTimerStr(deltaTime, txtColor)
  local id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107",
    format = "%s%s",
    clrFormat = "<color=#%s>%s</color>"
  }
  local clrFormat = id.clrFormat
  if txtColor == nil then
    clrFormat = id.format
    txtColor = ""
  end
  local day = 0
  local hour = 0
  local min = 0
  local second = 0
  if 0 <= deltaTime then
    day, hour, min, second = UIActivityHelper.Time2Str(deltaTime)
  end
  local timeStr
  if 0 < day and 0 < hour then
    timeStr = string.format(clrFormat, txtColor, day) .. StringTable.Get(id.day)
    timeStr = timeStr .. string.format(clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
  elseif 0 < day then
    timeStr = string.format(clrFormat, txtColor, day) .. StringTable.Get(id.day)
  elseif 0 < hour and 0 < min then
    timeStr = string.format(clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
    timeStr = timeStr .. string.format(clrFormat, txtColor, min) .. StringTable.Get(id.min)
  elseif 0 < hour then
    timeStr = string.format(clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
  elseif 0 < min then
    timeStr = string.format(clrFormat, txtColor, min) .. StringTable.Get(id.min)
  else
    timeStr = string.format(clrFormat, txtColor, StringTable.Get(id.zero))
  end
  return timeStr
end
