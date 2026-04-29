_class("UIActivityN32HardLevelMain", UIController)
UIActivityN32HardLevelMain = UIActivityN32HardLevelMain

function UIActivityN32HardLevelMain:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:LoadData(TT, res)
  UIActivityDiffLevelCupData.CreateEntiesDesc()
end

function UIActivityN32HardLevelMain:OnShow(uiParams)
  self._isNormalUI = uiParams[1] and true
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._tipsAnim = self:GetUIComponent("Animation", "TipsAnim")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self._isNormalUI then
      self:CloseDialog()
    else
      CutsceneManager.ExcuteCutsceneOut_Shot()
      self:SwitchState(UIStateType.UIActivityN32MainController)
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
  self._normalLevel = UIActivityN32HardLevel:New(self)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._normalLevel:SetActive(false)
  self._diffLevel = UIActivityN32DiffLevel:New(self)
  self._diffLevel:SetData(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  self._diffLevel:SetActive(false)
  self._hardPetEnhanceAreaGo = self:GetGameObject("HardPetEnhanceAreaGen")
  local hardComponentCfgId = self._levelHardComponent:GetComponentCfgId()
  UIActivityHelper.SpawnPetEnhanceArea(self, "HardPetEnhanceAreaGen", hardComponentCfgId, UIActivityPetEnhanceAreaUIStyle.N32_NORMAL)
  self._diffPetEnhanceAreaGo = self:GetGameObject("DiffPetEnhanceAreaGen")
  local diffComponentCfgId = self._blackHardComponent:GetComponentCfgId()
  UIActivityHelper.SpawnPetEnhanceArea(self, "DiffPetEnhanceAreaGen", diffComponentCfgId, UIActivityPetEnhanceAreaUIStyle.N32_HARD)
  self:RefreshPetEnhanceArea()
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  self:SwitchLevelType(self._levelType, true)
  self:PlayEnterAnim()
  if self._levelType == 2 and uiParams[3] then
    self._diffLevel:ClickNodeByID(uiParams[3])
  end
end

function UIActivityN32HardLevelMain:OnHide()
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityMainStatusRefreshEvent)
  if self._diffLevel then
    self._diffLevel:Destroy()
  end
  if self._normalLevel then
    self._normalLevel:Destroy()
  end
end

function UIActivityN32HardLevelMain:LoadData(TT, res)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N32, ECampaignN32ComponentID.ECAMPAIGN_N32_DIFFICULT_MISSION, ECampaignN32ComponentID.ECAMPAIGN_N32_BLACK_DIFFICULT_MISSION)
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    CutsceneManager.ExcuteCutsceneOut_Shot()
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  self._levelHardComponent = self._localProcess:GetComponent(ECampaignN32ComponentID.ECAMPAIGN_N32_DIFFICULT_MISSION)
  self._levelHardCompInfo = self._localProcess:GetComponentInfo(ECampaignN32ComponentID.ECAMPAIGN_N32_DIFFICULT_MISSION)
  self._blackHardComponent = self._localProcess:GetComponent(ECampaignN32ComponentID.ECAMPAIGN_N32_BLACK_DIFFICULT_MISSION)
  self._blackHardCompInfo = self._localProcess:GetComponentInfo(ECampaignN32ComponentID.ECAMPAIGN_N32_BLACK_DIFFICULT_MISSION)
end

function UIActivityN32HardLevelMain:OnTeamReset()
  self:StartTask(self.OnTeamResetCoro, self)
end

function UIActivityN32HardLevelMain:OnTeamResetCoro(TT)
  self:Lock("UIActivityN27HardLevelMain_OnTeamResetCoro")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self:LoadData(TT, res)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._diffLevel:Refresh(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamResetInternal)
  self:UnLock("UIActivityN27HardLevelMain_OnTeamResetCoro")
end

function UIActivityN32HardLevelMain:SwitchLevelType(levelType, playAnim)
  if levelType == 1 then
    self._diffLevel:SetActive(false)
    self._normalLevel:SetActive(true, playAnim)
  elseif levelType == 2 then
    self._diffLevel:SetActive(true, playAnim)
    self._normalLevel:SetActive(false)
  end
end

function UIActivityN32HardLevelMain:HardLevelOpen()
  if not self._blackHardComponent then
    return false
  end
  return self._blackHardComponent:ComponentIsOpen()
end

function UIActivityN32HardLevelMain:GetPlayerPrefsKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N32_HARD_LEVEL_SHOW_TIPS_FLAG"
  return key
end

function UIActivityN32HardLevelMain:IsShowHardLevelTips()
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

function UIActivityN32HardLevelMain:RefreshSwitchBtnStatus()
end

function UIActivityN32HardLevelMain:BtnCloseOnClick()
  self:StartTask(self.BtnCloseOnClickCoro, self)
end

function UIActivityN32HardLevelMain:BtnCloseOnClickCoro(TT)
  self:Lock("UIActivityN27HardLevelMain_BtnCloseOnClickCoro")
  if self._tipsAnim then
    self._tipsAnim:Play("uieff_UIActivityN32HardLevelMain_Tips_out")
    YIELD(TT, 167)
  end
  self._tips:SetActive(false)
  self:UnLock("UIActivityN27HardLevelMain_BtnCloseOnClickCoro")
end

function UIActivityN32HardLevelMain:NormalLevelOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 1 then
    return
  end
  if self._levelHardComponent:ComponentIsOpen() == false then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN32MainController)
    return
  end
  self._levelType = 1
  self:RefreshSwitchBtnStatus()
  self:RefreshPetEnhanceArea()
  self:PlaySwitchAnim(self._levelType)
end

function UIActivityN32HardLevelMain:HardLevelOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 2 then
    return
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  if curTime >= self._blackHardCompInfo.m_close_time then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN32MainController)
    return
  end
  if not self:HardLevelOpen() then
    ToastManager.ShowToast(StringTable.Get("str_n32_hard_level_unopen"))
    return
  end
  self._levelType = 2
  self:RefreshSwitchBtnStatus()
  self:RefreshPetEnhanceArea()
  self:PlaySwitchAnim(self._levelType)
end

function UIActivityN32HardLevelMain:BtnInfoOnClick()
  self._diffLevel:BtnInfoOnClick()
end

function UIActivityN32HardLevelMain:PlaySwitchAnim(levelType)
  self:StartTask(self.PlaySwitchAnimCoro, self, levelType)
end

function UIActivityN32HardLevelMain:PlaySwitchAnimCoro(TT, levelType)
  self:Lock("UIActivityN27HardLevelMain_PlaySwitchAnimCoro")
  local animName = ""
  if levelType == 1 then
    self._normalLevel:SetActive(true, true)
    self._diffLevel:SetActive(true, false)
    animName = "uieff_UIActivityN32HardLevelMain_switch_hard"
  elseif levelType == 2 then
    self._normalLevel:SetActive(true, false)
    self._diffLevel:SetActive(true, true)
    animName = "uieff_UIActivityN32HardLevelMain_switch_diff"
  end
  if self._anim then
    self._anim:Play(animName)
    YIELD(TT, 300)
  end
  self:SwitchLevelType(levelType, false)
  self:UnLock("UIActivityN27HardLevelMain_PlaySwitchAnimCoro")
end

function UIActivityN32HardLevelMain:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityN32HardLevelMain:PlayEnterAnimCoro(TT)
  local isOpen = self:HardLevelOpen()
  local hardLevelMask = self:GetGameObject("HardLevelMask")
  if isOpen == false then
    hardLevelMask:SetActive(false)
  end
  if self:IsShowHardLevelTips() == false then
    self:RefreshLockUI()
  end
  self:Lock("UIActivityN27HardLevelMain_PlayEnterAnimCoro")
  local animName = ""
  if self._levelType == 1 then
    animName = "uieff_UIActivityN32HardLevelMain_Hard_in"
  elseif self._levelType == 2 then
    animName = "uieff_UIActivityN32HardLevelMain_Diff_in"
  end
  if self._anim then
    self._anim:Play(animName)
    YIELD(TT, 333)
  end
  if self:IsShowHardLevelTips() then
    self._tips:SetActive(true)
    if self._tipsAnim then
      self._tipsAnim:Play("uieff_UIActivityN32HardLevelMain_Tips_in")
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
  self:UnLock("UIActivityN27HardLevelMain_PlayEnterAnimCoro")
end

function UIActivityN32HardLevelMain:RefreshLockUI()
  local hardLevelLock = self:GetGameObject("HardLevelLock")
  local isOpen = self:HardLevelOpen()
  hardLevelLock:SetActive(not isOpen)
  local hardLevelMask = self:GetGameObject("HardLevelMask")
  if isOpen == false then
    hardLevelMask:SetActive(false)
  end
end

function UIActivityN32HardLevelMain:ClosePetEnhanceTips()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClosePetEnhanceTips)
end

function UIActivityN32HardLevelMain:RefreshPetEnhanceArea()
  if self._hardPetEnhanceAreaGo then
    self._hardPetEnhanceAreaGo:SetActive(self._levelType == 1)
  end
  if self._diffPetEnhanceAreaGo then
    self._diffPetEnhanceAreaGo:SetActive(self._levelType == 2)
  end
end
