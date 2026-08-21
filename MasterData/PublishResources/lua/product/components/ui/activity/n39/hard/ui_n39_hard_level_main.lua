_class("UIN39HardLevelMain", UIController)
UIN39HardLevelMain = UIN39HardLevelMain

function UIN39HardLevelMain:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:LoadData(TT, res)
  UIActivityDiffLevelCupData.CreateEntiesDesc()
  self._cdEnd = {tick = 3000, period = 3000}
end

function UIN39HardLevelMain:InitAnim()
  self._tag2anim = {
    hard_in = {
      name = "uieff_UIN39HardLevelMain_HardIn",
      time = 667
    },
    black_in = {
      name = "uieff_UIN39HardLevelMain_DiffIn",
      time = 667
    },
    black2hard = {
      name = "uieff_UIN39HardLevelMain_Switch_DiffToHard",
      time = 533
    },
    hard2black = {
      name = "uieff_UIN39HardLevelMain_Switch_HardToDiff",
      time = 533
    },
    tip_in = {
      name = "uieff_UIN39HardLevelMain_Tips_in",
      time = 500
    },
    tip_out = {
      name = "uieff_UIN39HardLevelMain_Tips_out",
      time = 333
    },
    out = {
      name = "uieff_UIN39HardLevelMain_out",
      time = 333
    }
  }
end

function UIN39HardLevelMain:PlayAnim(tag, callback)
  local anim = self._tag2anim[tag]
  self._anim:Play(anim.name)
  self:Lock("UIN39HardLevelMain:PlayAnim")
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
    self:UnLock("UIN39HardLevelMain:PlayAnim")
  end
  self._animTimer = GameGlobal.Timer():AddEvent(anim.time, function()
    self:UnLock("UIN39HardLevelMain:PlayAnim")
    if callback then
      callback()
    end
  end)
end

function UIN39HardLevelMain:OnShow(uiParams)
  self._isNormalUI = uiParams[1] and true
  self._screenShot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self:InitAnim()
  self.LockTime = self:GetUIComponent("UILocalizedTMP", "LockTime")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:_Back()
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
  self._normalLevel = UIN39HardLevel:New(self)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._normalLevel:SetActive(false)
  self._diffLevel = UIN39DiffLevel:New(self)
  self._diffLevel:SetData(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  self._diffLevel:SetActive(false)
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
  self:SwitchLevelType(self._levelType, true)
  self:PlayEnterAnim()
  if self._levelType == 2 and uiParams[3] then
    self._diffLevel:ClickNodeByID(uiParams[3])
  end
end

function UIN39HardLevelMain:_OnComponentClose(componentCfgId)
  local component = self._levelHardComponent
  if component and component:GetComponentCfgId() == componentCfgId then
    self:_Back()
  end
end

function UIN39HardLevelMain:_Back()
  if self._screenShot and false then
    self._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local rt = self._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CampaignSwitchState(true, UIStateType.UIN39MainController, UIStateType.UIMain, {false, cache_rt}, self._campaign._id)
    end)
  else
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN39MainController, UIStateType.UIMain, {false}, self._campaign._id)
  end
end

function UIN39HardLevelMain:OnHide()
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityMainStatusRefreshEvent)
  if self._diffLevel then
    self._diffLevel:Destroy()
  end
  if self._normalLevel then
    self._normalLevel:Destroy()
  end
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
    self:UnLock("UIN39HardLevelMain:PlayAnim")
  end
end

function UIN39HardLevelMain:LoadData(TT, res)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N39, ECampaignN39ComponentID.ECAMPAIGN_N39_HARD_LINE_MISSION, ECampaignN39ComponentID.ECAMPAIGN_N39_BLACK_DIFFICULT_MISSION)
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    CutsceneManager.ExcuteCutsceneOut_Shot()
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  self._levelHardComponent = self._localProcess:GetComponent(ECampaignN39ComponentID.ECAMPAIGN_N39_HARD_LINE_MISSION)
  self._levelHardCompInfo = self._localProcess:GetComponentInfo(ECampaignN39ComponentID.ECAMPAIGN_N39_HARD_LINE_MISSION)
  self._blackHardComponent = self._localProcess:GetComponent(ECampaignN39ComponentID.ECAMPAIGN_N39_BLACK_DIFFICULT_MISSION)
  self._blackHardCompInfo = self._localProcess:GetComponentInfo(ECampaignN39ComponentID.ECAMPAIGN_N39_BLACK_DIFFICULT_MISSION)
end

function UIN39HardLevelMain:OnTeamReset()
  self:StartTask(self.OnTeamResetCoro, self)
end

function UIN39HardLevelMain:OnTeamResetCoro(TT)
  self:Lock("UIN39HardLevelMain_OnTeamResetCoro")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self:LoadData(TT, res)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._diffLevel:Refresh(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamResetInternal)
  self:UnLock("UIN39HardLevelMain_OnTeamResetCoro")
end

function UIN39HardLevelMain:SwitchLevelType(levelType, playAnim)
  local tag
  if levelType == 1 then
    self._diffLevel:SetActive(false)
    self._normalLevel:SetActive(true, playAnim)
    tag = "hard"
  elseif levelType == 2 then
    self._diffLevel:SetActive(true, playAnim)
    self._normalLevel:SetActive(false)
    tag = "black"
  end
  UIN39Helper.SetComRedTime(tag)
  UIN39Helper.ClearNew(tag)
end

function UIN39HardLevelMain:HardLevelOpen()
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

function UIN39HardLevelMain:_ForceRefresh()
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

function UIN39HardLevelMain:GetPlayerPrefsKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N39_HARD_LEVEL_SHOW_TIPS_FLAG"
  return key
end

function UIN39HardLevelMain:IsShowHardLevelTips()
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

function UIN39HardLevelMain:RefreshSwitchBtnStatus()
end

function UIN39HardLevelMain:BtnCloseOnClick()
  self:PlayAnim("tip_out", function()
    self._tips:SetActive(false)
  end)
end

function UIN39HardLevelMain:NormalLevelOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 1 then
    return
  end
  if self._levelHardComponent:ComponentIsOpen() == false then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIN39MainController)
    return
  end
  self._levelType = 1
  self:RefreshSwitchBtnStatus()
  self:PlaySwitchAnim(self._levelType)
end

function UIN39HardLevelMain:HardLevelOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 2 then
    return
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  if curTime >= self._blackHardCompInfo.m_close_time then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIN39MainController)
    return
  end
  if curTime < self._blackHardCompInfo.m_unlock_time then
    ToastManager.ShowToast(StringTable.Get("str_n39_hard_level_time_lock"))
    return
  end
  if not self:HardLevelOpen() then
    local levelName = StringTable.Get("str_n39_hard_name_4")
    ToastManager.ShowToast(StringTable.Get("str_n39_hard_level_lock_tips", levelName))
    return
  end
  self._levelType = 2
  self:RefreshSwitchBtnStatus()
  self:PlaySwitchAnim(self._levelType)
end

function UIN39HardLevelMain:BtnInfoOnClick()
  self:ShowDialog("UIIntroLoader", "UIN39IntroHard", MaskType.MT_BlurMask)
end

function UIN39HardLevelMain:PlaySwitchAnim(levelType)
  local tag = ""
  if levelType == 1 then
    self._normalLevel:SetActive(true, true)
    self._diffLevel:SetActive(true, false)
    tag = "black2hard"
  elseif levelType == 2 then
    self._normalLevel:SetActive(true, false)
    self._diffLevel:SetActive(true, true)
    tag = "hard2black"
  end
  self:PlayAnim(tag, function()
    self:SwitchLevelType(levelType, false)
  end)
end

function UIN39HardLevelMain:PlayEnterAnim()
  self._enterPlaying = true
  local animName = self._levelType == 1 and "hard_in" or "black_in"
  self:PlayAnim(animName, function()
    if self:IsShowHardLevelTips() then
      self._tips:SetActive(true)
      self:PlayAnim("tip_in", function()
        self:RefreshLockUI()
      end)
      UnityEngine.PlayerPrefs.SetInt(self:GetPlayerPrefsKey(), 1)
    else
      self._tips:SetActive(false)
      self:RefreshLockUI()
    end
    self._enterPlaying = false
  end)
end

function UIN39HardLevelMain:RefreshLockUI()
  local hardLevelLock = self:GetGameObject("HardLevelLock")
  local isOpen = self:HardLevelOpen()
  hardLevelLock:SetActive(not isOpen)
end

function UIN39HardLevelMain:ClosePetEnhanceTips()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClosePetEnhanceTips)
end

function UIN39HardLevelMain:OnUpdate(deltaTimeMS)
  self._cdEnd.tick = self._cdEnd.tick + deltaTimeMS
  if self._cdEnd.tick >= self._cdEnd.period then
    self._cdEnd.tick = 0
    self:RefreshLockTime()
  end
end

function UIN39HardLevelMain:RefreshLockTime()
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
    if not self._enterPlaying and self:IsShowHardLevelTips() then
      self._tips:SetActive(true)
      self:PlayAnim("tip_in", function()
        self:RefreshLockUI()
      end)
      UnityEngine.PlayerPrefs.SetInt(self:GetPlayerPrefsKey(), 1)
    end
    self.LockTime.gameObject:SetActive(false)
  end
end

function UIN39HardLevelMain:GetFormatTimerStr(deltaTime, txtColor)
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
