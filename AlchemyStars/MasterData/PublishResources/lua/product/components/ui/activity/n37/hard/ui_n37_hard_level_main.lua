_class("UIN37HardLevelMain", UIController)
UIN37HardLevelMain = UIN37HardLevelMain

function UIN37HardLevelMain:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:LoadData(TT, res)
  UIActivityDiffLevelCupData.CreateEntiesDesc()
  self._cdEnd = {tick = 30000, period = 30000}
end

function UIN37HardLevelMain:OnShow(uiParams)
  self._isNormalUI = uiParams[1] and true
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._tipsAnim = self:GetUIComponent("Animation", "TipsAnim")
  self.LockTime = self:GetUIComponent("UILocalizationText", "LockTime")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    if self._isNormalUI then
      self:CloseDialog()
    else
      CutsceneManager.ExcuteCutsceneOut_Shot()
      self:SwitchState(UIStateType.UIN37MainController)
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
  self._normalLevel = UIN37HardLevel:New(self)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._normalLevel:SetActive(false)
  self._diffLevel = UIN37DiffLevel:New(self)
  self._diffLevel:SetData(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  self._diffLevel:SetActive(false)
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  self:SwitchLevelType(self._levelType, true)
  self:PlayEnterAnim()
  if self._levelType == 2 and uiParams[3] then
    self._diffLevel:ClickNodeByID(uiParams[3])
  end
end

function UIN37HardLevelMain:OnHide()
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityMainStatusRefreshEvent)
  if self._diffLevel then
    self._diffLevel:Destroy()
  end
  if self._normalLevel then
    self._normalLevel:Destroy()
  end
end

function UIN37HardLevelMain:LoadData(TT, res)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N37, ECampaignN37ComponentID.ECAMPAIGN_N37_HARD_LINE_MISSION, ECampaignN37ComponentID.ECAMPAIGN_N37_BLACK_DIFFICULT_MISSION)
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    CutsceneManager.ExcuteCutsceneOut_Shot()
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  self._levelHardComponent = self._localProcess:GetComponent(ECampaignN37ComponentID.ECAMPAIGN_N37_HARD_LINE_MISSION)
  self._levelHardCompInfo = self._localProcess:GetComponentInfo(ECampaignN37ComponentID.ECAMPAIGN_N37_HARD_LINE_MISSION)
  self._blackHardComponent = self._localProcess:GetComponent(ECampaignN37ComponentID.ECAMPAIGN_N37_BLACK_DIFFICULT_MISSION)
  self._blackHardCompInfo = self._localProcess:GetComponentInfo(ECampaignN37ComponentID.ECAMPAIGN_N37_BLACK_DIFFICULT_MISSION)
end

function UIN37HardLevelMain:OnTeamReset()
  self:StartTask(self.OnTeamResetCoro, self)
end

function UIN37HardLevelMain:OnTeamResetCoro(TT)
  self:Lock("UIN37HardLevelMain_OnTeamResetCoro")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self:LoadData(TT, res)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._diffLevel:Refresh(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamResetInternal)
  self:UnLock("UIN37HardLevelMain_OnTeamResetCoro")
end

function UIN37HardLevelMain:SwitchLevelType(levelType, playAnim)
  if levelType == 1 then
    self._diffLevel:SetActive(false)
    self._normalLevel:SetActive(true, playAnim)
  elseif levelType == 2 then
    self._diffLevel:SetActive(true, playAnim)
    self._normalLevel:SetActive(false)
  end
end

function UIN37HardLevelMain:HardLevelOpen()
  if not self._blackHardComponent then
    return false
  end
  local open = self._blackHardComponent:ComponentIsOpen()
  local openTime = self._blackHardCompInfo.m_unlock_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if not open and openTime < curTime then
    self:_ForceRefresh()
  end
  return open
end

function UIN37HardLevelMain:_ForceRefresh()
  if not self._refreshId then
    self._refreshId = true
    self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      res:SetSucc(true)
      self._campaign:ReLoadCampaignInfo_Force(TT, res)
      self._refreshId = false
    end, self)
  end
end

function UIN37HardLevelMain:GetPlayerPrefsKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N37_HARD_LEVEL_SHOW_TIPS_FLAG"
  return key
end

function UIN37HardLevelMain:IsShowHardLevelTips()
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

function UIN37HardLevelMain:RefreshSwitchBtnStatus()
end

function UIN37HardLevelMain:BtnCloseOnClick()
  self:StartTask(self.BtnCloseOnClickCoro, self)
end

function UIN37HardLevelMain:BtnCloseOnClickCoro(TT)
  self:Lock("UIN37HardLevelMain_BtnCloseOnClickCoro")
  if self._tipsAnim then
    self._tipsAnim:Play("uieff_UIN37HardLevelMain_Tips_out")
    YIELD(TT, 167)
  end
  self._tips:SetActive(false)
  self:UnLock("UIN37HardLevelMain_BtnCloseOnClickCoro")
end

function UIN37HardLevelMain:NormalLevelOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 1 then
    return
  end
  if self._levelHardComponent:ComponentIsOpen() == false then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIN37MainController)
    return
  end
  self._levelType = 1
  self:RefreshSwitchBtnStatus()
  self:PlaySwitchAnim(self._levelType)
end

function UIN37HardLevelMain:HardLevelOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 2 then
    return
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  if curTime >= self._blackHardCompInfo.m_close_time then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIN37MainController)
    return
  end
  if curTime < self._blackHardCompInfo.m_unlock_time then
    ToastManager.ShowToast(StringTable.Get("str_n37_hard_level_time_lock"))
    return
  end
  if not self:HardLevelOpen() then
    local levelName = StringTable.Get("str_n37_4_levelname_H")
    ToastManager.ShowToast(StringTable.Get("str_n37_hard_level_lock_tips", levelName))
    return
  end
  self._levelType = 2
  self:RefreshSwitchBtnStatus()
  self:PlaySwitchAnim(self._levelType)
end

function UIN37HardLevelMain:BtnInfoOnClick()
  self._diffLevel:BtnInfoOnClick()
end

function UIN37HardLevelMain:PlaySwitchAnim(levelType)
  self:StartTask(self.PlaySwitchAnimCoro, self, levelType)
end

function UIN37HardLevelMain:PlaySwitchAnimCoro(TT, levelType)
  self:Lock("UIN37HardLevelMain_PlaySwitchAnimCoro")
  local animName = ""
  if levelType == 1 then
    self._normalLevel:SetActive(true, true)
    self._diffLevel:SetActive(true, false)
    animName = "uieff_UIN37HardLevelMain_out"
  elseif levelType == 2 then
    self._normalLevel:SetActive(true, false)
    self._diffLevel:SetActive(true, true)
    animName = "uieff_UIN37HardLevelMain_start"
  end
  if self._anim then
    self._anim:Play(animName)
    YIELD(TT, 300)
  end
  self:SwitchLevelType(levelType, false)
  self:UnLock("UIN37HardLevelMain_PlaySwitchAnimCoro")
end

function UIN37HardLevelMain:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIN37HardLevelMain:PlayEnterAnimCoro(TT)
  local isOpen = self:HardLevelOpen()
  local hardLevelMask = self:GetGameObject("HardLevelMask")
  if isOpen == false and hardLevelMask then
    hardLevelMask:SetActive(false)
  end
  if self:IsShowHardLevelTips() == false then
    self:RefreshLockUI()
  end
  self:Lock("UIN37HardLevelMain_PlayEnterAnimCoro")
  local animName = ""
  if self._levelType == 1 then
    animName = "uieff_UIN37HardLevelMain"
  elseif self._levelType == 2 then
    animName = "uieff_UIN37HardLevelMain_in"
  end
  if self._anim then
    self._anim:Play(animName)
    YIELD(TT, 333)
  end
  if self:IsShowHardLevelTips() then
    self._tips:SetActive(true)
    if self._tipsAnim then
      self._tipsAnim:Play("uieff_UIN37HardLevelMain_Tips_in")
      YIELD(TT, 333)
      self:RefreshLockUI()
    else
      self:RefreshLockUI()
    end
    UnityEngine.PlayerPrefs.SetInt(self:GetPlayerPrefsKey(), 1)
  else
    self._tips:SetActive(false)
    self:RefreshLockUI()
  end
  self:UnLock("UIN37HardLevelMain_PlayEnterAnimCoro")
end

function UIN37HardLevelMain:RefreshLockUI()
  local hardLevelLock = self:GetGameObject("HardLevelLock")
  local isOpen = self:HardLevelOpen()
  hardLevelLock:SetActive(not isOpen)
  local hardLevelMask = self:GetGameObject("HardLevelMask")
  if isOpen == false and hardLevelMask then
    hardLevelMask:SetActive(false)
  end
end

function UIN37HardLevelMain:ClosePetEnhanceTips()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClosePetEnhanceTips)
end

function UIN37HardLevelMain:OnUpdate(deltaTimeMS)
  self._cdEnd.tick = self._cdEnd.tick + deltaTimeMS
  if self._cdEnd.tick >= self._cdEnd.period then
    self._cdEnd.tick = 0
    self:RefreshLockTime()
  end
end

function UIN37HardLevelMain:RefreshLockTime()
  local openTime = self._blackHardCompInfo.m_unlock_time
  local closeTime = self._blackHardCompInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if closeTime < curTime then
    return
  end
  if openTime > curTime then
    local deltaTime = math.max(openTime - curTime, 0)
    local timerStr = self:GetFormatTimerStr(deltaTime)
    local txt = StringTable.Get("str_cn6&n35_hard_cdtime") .. timerStr
    self.LockTime.gameObject:SetActive(true)
    self.LockTime:SetText(txt)
  else
    if not self:HardLevelOpen() then
      self.LockTime.gameObject:SetActive(false)
      return
    end
    if self:IsShowHardLevelTips() then
      self._tips:SetActive(true)
      if self._tipsAnim then
        self._tipsAnim:Play("uieff_UIN37HardLevelMain_Tips_in")
        YIELD(TT, 333)
        self:RefreshLockUI()
      else
        self:RefreshLockUI()
      end
      UnityEngine.PlayerPrefs.SetInt(self:GetPlayerPrefsKey(), 1)
    end
    self.LockTime.gameObject:SetActive(false)
  end
end

function UIN37HardLevelMain:GetFormatTimerStr(deltaTime, txtColor)
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
