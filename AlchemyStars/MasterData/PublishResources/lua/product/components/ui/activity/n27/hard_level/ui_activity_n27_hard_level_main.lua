_class("UIActivityN27HardLevelMain", UIController)
UIActivityN27HardLevelMain = UIActivityN27HardLevelMain

function UIActivityN27HardLevelMain:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:LoadData(TT, res)
  UIActivityN27DiffLevelCupData.CreateEntiesDesc()
end

function UIActivityN27HardLevelMain:OnShow(uiParams)
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
      self:SwitchState(UIStateType.UIN27Controller)
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
  self._normalLevel = UIActivityN27HardLevel:New(self)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._normalLevel:SetActive(false)
  self._diffLevel = UIActivityN27DiffLevel:New(self)
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

function UIActivityN27HardLevelMain:OnHide()
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  if self._diffLevel then
    self._diffLevel:Destroy()
  end
  if self._normalLevel then
    self._normalLevel:Destroy()
  end
end

function UIActivityN27HardLevelMain:LoadData(TT, res)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N27, ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_BLACK_DIFFICULT_MISSION)
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    CutsceneManager.ExcuteCutsceneOut_Shot()
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  self._levelHardComponent = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION)
  self._levelHardCompInfo = self._localProcess:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION)
  self._blackHardComponent = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_BLACK_DIFFICULT_MISSION)
  self._blackHardCompInfo = self._localProcess:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_BLACK_DIFFICULT_MISSION)
end

function UIActivityN27HardLevelMain:OnTeamReset()
  self:StartTask(self.OnTeamResetCoro, self)
end

function UIActivityN27HardLevelMain:OnTeamResetCoro(TT)
  self:Lock("UIActivityN27HardLevelMain_OnTeamResetCoro")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self:LoadData(TT, res)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent, self._levelHardCompInfo)
  self._diffLevel:Refresh(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamResetInternal)
  self:UnLock("UIActivityN27HardLevelMain_OnTeamResetCoro")
end

function UIActivityN27HardLevelMain:SwitchLevelType(levelType, playAnim)
  if levelType == 1 then
    self._diffLevel:SetActive(false)
    self._normalLevel:SetActive(true, playAnim)
  elseif levelType == 2 then
    self._diffLevel:SetActive(true, playAnim)
    self._normalLevel:SetActive(false)
  end
end

function UIActivityN27HardLevelMain:HardLevelOpen()
  if not self._blackHardComponent then
    return false
  end
  return self._blackHardComponent:ComponentIsOpen()
end

function UIActivityN27HardLevelMain:CheckTips()
  if self:IsShowHardLevelTips() == false then
    return
  end
  self._tips:SetActive(true)
  UnityEngine.PlayerPrefs.SetInt(self:GetPlayerPrefsKey(), 1)
end

function UIActivityN27HardLevelMain:GetPlayerPrefsKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N27_HARD_LEVEL_SHOW_TIPS_FLAG"
  return key
end

function UIActivityN27HardLevelMain:IsShowHardLevelTips()
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

function UIActivityN27HardLevelMain:RefreshSwitchBtnStatus()
  local hardLevelLock = self:GetGameObject("HardLevelLock")
  if self:IsShowHardLevelTips() == false then
    hardLevelLock:SetActive(not self:HardLevelOpen())
    if self._levelType == 1 then
    else
    end
  end
end

function UIActivityN27HardLevelMain:BtnCloseOnClick()
  self:StartTask(self.BtnCloseOnClickCoro, self)
end

function UIActivityN27HardLevelMain:BtnCloseOnClickCoro(TT)
  self:Lock("UIActivityN27HardLevelMain_BtnCloseOnClickCoro")
  self._tipsAnim:Play("uieff_UIActivityN27HardLevelMain_tips_out")
  YIELD(TT, 300)
  self._tips:SetActive(false)
  self:UnLock("UIActivityN27HardLevelMain_BtnCloseOnClickCoro")
end

function UIActivityN27HardLevelMain:NormalLevelOnClick()
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

function UIActivityN27HardLevelMain:HardLevelOnClick()
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
    ToastManager.ShowToast(StringTable.Get("str_n27_hard_level_unopen"))
    return
  end
  self._levelType = 2
  self:RefreshSwitchBtnStatus()
  self:PlaySwitchAnim(self._levelType)
end

function UIActivityN27HardLevelMain:BtnInfoOnClick()
  self._diffLevel:BtnInfoOnClick()
end

function UIActivityN27HardLevelMain:PlaySwitchAnim(levelType)
  self:StartTask(self.PlaySwitchAnimCoro, self, levelType)
end

function UIActivityN27HardLevelMain:PlaySwitchAnimCoro(TT, levelType)
  self:Lock("UIActivityN27HardLevelMain_PlaySwitchAnimCoro")
  self._normalLevel:SetActive(true, true)
  self._diffLevel:SetActive(true, true)
  local animName = ""
  if levelType == 1 then
    animName = "uieff_UIActivityN27HardLevelMain_out"
  elseif levelType == 2 then
    animName = "uieff_UIActivityN27HardLevelMain_loop"
  end
  self._anim:Play(animName)
  YIELD(TT, 670)
  self:SwitchLevelType(levelType, false)
  self:UnLock("UIActivityN27HardLevelMain_PlaySwitchAnimCoro")
end

function UIActivityN27HardLevelMain:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityN27HardLevelMain:PlayEnterAnimCoro(TT)
  self:Lock("UIActivityN27HardLevelMain_PlayEnterAnimCoro")
  local animName = ""
  if self._levelType == 1 then
    animName = "uieff_UIActivityN27HardLevelMain"
  elseif self._levelType == 2 then
    animName = "uieff_UIActivityN27HardLevelMain_start"
  end
  self._anim:Play(animName)
  YIELD(TT, 100)
  if self:IsShowHardLevelTips() then
    self._lockAnim:Play("uieff_UIActivityN27HardLevelMain_rightbottom")
  end
  YIELD(TT, 550)
  local hardLevelLock = self:GetGameObject("HardLevelLock")
  hardLevelLock:SetActive(not self:HardLevelOpen())
  self:UnLock("UIActivityN27HardLevelMain_PlayEnterAnimCoro")
end
