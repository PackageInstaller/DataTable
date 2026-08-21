_class("UIActivityN29HardLevelMain", UIController)
UIActivityN29HardLevelMain = UIActivityN29HardLevelMain

function UIActivityN29HardLevelMain:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:LoadData(TT, res)
  UIActivityDiffLevelCupData.CreateEntiesDesc()
end

function UIActivityN29HardLevelMain:OnShow(uiParams)
  self._isNormalUI = uiParams[1] and true
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._lockAnim = self:GetUIComponent("Animation", "LockAnim")
  self._tipsAnim = self:GetUIComponent("Animation", "TipsAnim")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self._isNormalUI then
      self:CloseDialog()
    else
      CutsceneManager.ExcuteCutsceneOut_Shot()
      self:SwitchState(UIStateType.UIActivityN29MainController)
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
  self._normalLevel = UIActivityN29HardLevel:New(self)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._normalLevel:SetActive(false)
  self._diffLevel = UIActivityN29DiffLevel:New(self)
  self._diffLevel:SetData(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  self._diffLevel:SetActive(false)
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  self:RefreshSwitchBtnStatus()
  self:CheckTips()
  self:SwitchLevelType(self._levelType, true)
  self:PlayEnterAnim()
  if self._levelType == 2 and uiParams[3] then
    self._diffLevel:ClickNodeByID(uiParams[3])
  end
end

function UIActivityN29HardLevelMain:OnHide()
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityMainStatusRefreshEvent)
  if self._diffLevel then
    self._diffLevel:Destroy()
  end
  if self._normalLevel then
    self._normalLevel:Destroy()
  end
end

function UIActivityN29HardLevelMain:LoadData(TT, res)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N29, ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION, ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION)
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    CutsceneManager.ExcuteCutsceneOut_Shot()
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  self._levelHardComponent = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION)
  self._levelHardCompInfo = self._localProcess:GetComponentInfo(ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION)
  self._blackHardComponent = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION)
  self._blackHardCompInfo = self._localProcess:GetComponentInfo(ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION)
end

function UIActivityN29HardLevelMain:OnTeamReset()
  self:StartTask(self.OnTeamResetCoro, self)
end

function UIActivityN29HardLevelMain:OnTeamResetCoro(TT)
  self:Lock("UIActivityN27HardLevelMain_OnTeamResetCoro")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self:LoadData(TT, res)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._diffLevel:Refresh(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamResetInternal)
  self:UnLock("UIActivityN27HardLevelMain_OnTeamResetCoro")
end

function UIActivityN29HardLevelMain:SwitchLevelType(levelType, playAnim)
  if levelType == 1 then
    self._diffLevel:SetActive(false)
    self._normalLevel:SetActive(true, playAnim)
  elseif levelType == 2 then
    self._diffLevel:SetActive(true, playAnim)
    self._normalLevel:SetActive(false)
  end
end

function UIActivityN29HardLevelMain:HardLevelOpen()
  if not self._blackHardComponent then
    return false
  end
  return self._blackHardComponent:ComponentIsOpen()
end

function UIActivityN29HardLevelMain:CheckTips()
  if self:IsShowHardLevelTips() == false then
    return
  end
  self._tips:SetActive(true)
  UnityEngine.PlayerPrefs.SetInt(self:GetPlayerPrefsKey(), 1)
end

function UIActivityN29HardLevelMain:GetPlayerPrefsKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N29_HARD_LEVEL_SHOW_TIPS_FLAG"
  return key
end

function UIActivityN29HardLevelMain:IsShowHardLevelTips()
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

function UIActivityN29HardLevelMain:RefreshSwitchBtnStatus()
  local hardLevelLock = self:GetGameObject("HardLevelLock")
  if self:IsShowHardLevelTips() == false then
    hardLevelLock:SetActive(not self:HardLevelOpen())
  end
end

function UIActivityN29HardLevelMain:BtnCloseOnClick()
  self:StartTask(self.BtnCloseOnClickCoro, self)
end

function UIActivityN29HardLevelMain:BtnCloseOnClickCoro(TT)
  self:Lock("UIActivityN27HardLevelMain_BtnCloseOnClickCoro")
  if self._tipsAnim then
    self._tipsAnim:Play("uieff_UIActivityN29HardLevelMain_Tips_out")
    YIELD(TT, 333)
  end
  self._tips:SetActive(false)
  self:UnLock("UIActivityN27HardLevelMain_BtnCloseOnClickCoro")
end

function UIActivityN29HardLevelMain:NormalLevelOnClick()
  if self._levelType == 1 then
    return
  end
  if self._levelHardComponent:ComponentIsOpen() == false then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIN27Controller)
    return
  end
  self._levelType = 1
  self:RefreshSwitchBtnStatus()
  self:PlaySwitchAnim(self._levelType)
end

function UIActivityN29HardLevelMain:HardLevelOnClick()
  if self._levelType == 2 then
    return
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  if curTime >= self._blackHardCompInfo.m_close_time then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIN27Controller)
    return
  end
  if not self:HardLevelOpen() then
    ToastManager.ShowToast(StringTable.Get("str_n29_hard_level_unopen"))
    return
  end
  self._levelType = 2
  self:RefreshSwitchBtnStatus()
  self:PlaySwitchAnim(self._levelType)
end

function UIActivityN29HardLevelMain:BtnInfoOnClick()
  self._diffLevel:BtnInfoOnClick()
end

function UIActivityN29HardLevelMain:PlaySwitchAnim(levelType)
  self:StartTask(self.PlaySwitchAnimCoro, self, levelType)
end

function UIActivityN29HardLevelMain:PlaySwitchAnimCoro(TT, levelType)
  self:Lock("UIActivityN27HardLevelMain_PlaySwitchAnimCoro")
  self._normalLevel:SetActive(true, true)
  self._diffLevel:SetActive(true, true)
  local animName = ""
  if levelType == 1 then
    animName = "uieff_UIActivityN29HardLevelMain_Difflevel_switchout"
  elseif levelType == 2 then
    animName = "uieff_UIActivityN29HardLevelMain_Difflevel_switchin"
  end
  if self._anim then
    self._anim:Play(animName)
    YIELD(TT, 670)
  end
  self:SwitchLevelType(levelType, false)
  self:UnLock("UIActivityN27HardLevelMain_PlaySwitchAnimCoro")
end

function UIActivityN29HardLevelMain:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityN29HardLevelMain:PlayEnterAnimCoro(TT)
  self:Lock("UIActivityN27HardLevelMain_PlayEnterAnimCoro")
  local animName = ""
  if self._levelType == 1 then
    animName = "uieff_UIActivityN29HardLevelMain_in"
  elseif self._levelType == 2 then
    animName = "uieff_UIActivityN29HardLevelMain_Difflevel_in"
  end
  if self._anim then
    self._anim:Play(animName)
    YIELD(TT, 100)
  end
  if self:IsShowHardLevelTips() and self._lockAnim then
    self._lockAnim:Play("uieff_UIActivityN27HardLevelMain_rightbottom")
    YIELD(TT, 550)
  else
  end
  local hardLevelLock = self:GetGameObject("HardLevelLock")
  hardLevelLock:SetActive(not self:HardLevelOpen())
  self:UnLock("UIActivityN27HardLevelMain_PlayEnterAnimCoro")
end
