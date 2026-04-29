_class("UIN48HardController", UIController)
UIN48HardController = UIN48HardController

function UIN48HardController:_SetCommonTopButton()
  local function closeCallback()
    self:_Back()
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback)
end

function UIN48HardController:_Back()
  local campaignMain = CampaignConst.GetSafeStateInfo(self._campaign._id, nil, UIStateType.UIN48MainController, {true})
  local uiMain = CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:SwitchState_Safe(true, {campaignMain, uiMain})
end

function UIN48HardController:_SetRemainingTime(widgetName, descId, endTime, tickCallback, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, tickCallback, stopCallback)
end

function UIN48HardController:_PlayAnim(idx, callback)
  local tb = {
    hardin = {
      animName = "uieff_UIN48HardControllerlMain_in",
      duration = 200
    },
    diffin = {
      animName = "uieff_UIN48HardControllerlMain_red_in"
    },
    difftohard = {
      animName = "uieff_UIN48HardControllerlMain_red_out"
    },
    tipsin = {
      animName = "uieff_UIN48HardControllerlMain_Diff_in",
      duration = 250
    },
    tipsout = {
      animName = "uieff_UIN48HardControllerlMain_Diff_out",
      duration = 500
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end

function UIN48HardController:LoadData(TT, res)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N48
  self._componentId_Black = UIActivityN48Helper.GetComponentId("black")
  self._showTips = false
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {
    self._componentId_Black
  })
  self._levelHardComponent = self._campaign:GetComponent(self._componentId_Black)
  self._levelHardCompInfo = self._campaign:GetComponentInfo(self._componentId_Black)
  self._blackHardComponent = self._campaign:GetComponent(self._componentId_Black)
  self._blackHardCompInfo = self._campaign:GetComponentInfo(self._componentId_Black)
  local status, time = UIActivityN48Helper.CheckComponentStatus(self._blackHardComponent)
  local cfgv = Cfg.cfg_campaign_mission[self._blackHardCompInfo.m_need_mission_id]
  if status == ActivityN48ComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    return true
  elseif status == ActivityN48ComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    return true
  elseif status == ActivityN48ComponentStatus.TimeLock then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
    return true
  elseif status == ActivityN48ComponentStatus.MissionLock then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_hard_level_lock_mission_tips", StringTable.Get(cfgv.Name)))
    return true
  end
  local fRes = AsyncRequestRes:New()
  self._campaign:ReLoadCampaignInfo_Force(TT, fRes)
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
end

function UIN48HardController:LoadDataOnEnter(TT, res, uiParams)
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  local err = self:LoadData(TT, res)
  if err then
    res:SetSucc(false)
    return
  end
  UIActivityDiffLevelCupData.CreateEntiesDesc()
end

function UIN48HardController:OnShow(uiParams)
  self:_SetCommonTopButton()
  self.blur = self:GetGameObject("blur")
  self._diffLevel = UIN48HardBlack:New(self)
  self._diffLevel:SetData(self._campaign, self._blackHardComponent)
  self._diffLevel:SetActive(true)
  UIActivityN48Helper.LocalDB_Set("black", "New")
  UIActivityN48Helper.LocalDB_Set_CrossDay("black", "Red")
  local closeTime = self._blackHardCompInfo.m_close_time
  self:_SetRemainingTime("_time", "str_activity_common_remainingtime_3", closeTime, nil, function(first)
    if not first then
      self:_Refresh()
    end
  end)
  self:_Refresh()
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  self:AttachEvents()
end

function UIN48HardController:OnHide()
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  self:_DetachEvents()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityMainStatusRefreshEvent)
  if self._diffLevel then
    self._diffLevel:Destroy()
  end
  if self._normalLevel then
    self._normalLevel:Destroy()
  end
end

function UIN48HardController:OnTeamReset()
  self:StartTask(function(TT)
    local lockName = "UIN48HardController:OnTeamReset"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self._diffLevel:SetData(self._campaign, self._blackHardComponent)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamResetInternal)
    self:UnLock(lockName)
  end)
end

function UIN48HardController:_Refresh(noPlayAnim)
  self._diffLevel:_Refresh()
end

function UIN48HardController:_SetLineBtn(levelType)
end

function UIN48HardController:_SetBlackBtn(levelType)
  local isLock = self:_GetBlackLevelIslock()
  local isOver = self:_GetIsOver()
  if not isOver then
    if isLock ~= ActivityN48ComponentStatus.Open then
      if isLock == ActivityN48ComponentStatus.TimeLock then
        self:_SetRemainingTime("_blackTime", "str_N48_raffle_remaining_open_time", self._blackHardCompInfo.m_unlock_time, nil, function()
          if self._levelHardCompInfo.m_pass_mission_info[self._blackHardCompInfo.m_need_mission_id] ~= nil then
            self:GetGameObject("_tips"):SetActive(true)
            self:_ShowTips()
            self._levelType = 2
            UIActivityN48Helper.LocalDB_Set("black", "New")
            UIActivityN48Helper.LocalDB_Set_CrossDay("black", "Red")
          else
            self:_Refresh()
          end
        end)
      else
        self:GetGameObject("_blackTime"):SetActive(false)
        self:GetGameObject("_pass_lock"):SetActive(true)
        local passlock = self:GetUIComponent("UILocalizationText", "_pass_lock")
        local missionName = Cfg.cfg_campaign_mission[self._blackHardCompInfo.m_need_mission_id].Name
        local lvName = StringTable.Get(missionName)
        local text = StringTable.Get("str_N48_pass_level_unlock", lvName)
        passlock:SetText(text)
      end
    else
      self:GetGameObject("_BlackBtnLock"):SetActive(isLock ~= ActivityN48ComponentStatus.Open)
    end
    if isLock == ActivityN48ComponentStatus.Open then
      self:StartTask(function(TT)
        YIELD(TT, 200)
        self:_ShowTips()
      end)
    end
  else
    self:GetGameObject("_blackTime"):SetActive(true)
    self:GetGameObject("_pass_lock"):SetActive(false)
    self:_SetRemainingTime("_blackTime", nil, self._levelHardCompInfo.m_close_time, nil, function(first)
      if not first then
        self:_Refresh()
      end
    end)
  end
end

function UIN48HardController:_ShowTips()
  if self:_BlackLevelFirstTipsLocalDB(self._blackHardCompInfo.m_campaign_id) then
    self:_BlackLevelFirstTipsLocalDB(self._blackHardCompInfo.m_campaign_id, true)
    self:StartTask(function(TT)
      YIELD(TT)
      self:_PlayAnim("tipsin", function()
        self:GetGameObject("ShowBtn"):SetActive(true)
        self._showTips = true
      end)
    end)
  end
end

function UIN48HardController:_GetBlackLevelIslock()
  local unlockTime = self._blackHardCompInfo.m_unlock_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local stamp = unlockTime - curTime
  if 0 < stamp then
    return ActivityN48ComponentStatus.TimeLock
  end
  if self._levelHardCompInfo.m_pass_mission_info[self._blackHardCompInfo.m_need_mission_id] == nil then
    return ActivityN48ComponentStatus.MissionLock
  end
  return ActivityN48ComponentStatus.Open
end

function UIN48HardController:_GetIsOver()
  local closeTime = self._blackHardCompInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  return 0 < curTime - closeTime
end

function UIN48HardController:LineBtnOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 1 then
    return
  end
  if self._levelHardComponent:ComponentIsClose() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:_Back()
    return
  end
  self:StartTask(function(TT)
    self:_PlayAnim("difftohard")
    YIELD(TT, 300)
    self._levelType = 1
    self:PlaySwitchAnim(self._levelType)
  end)
end

function UIN48HardController:IntroBtnOnClick()
  self:ShowDialog("UIIntroLoader", "UIN48HardLevel", MaskType.MT_BlurMask)
end

function UIN48HardController:ShowBtnOnClick()
  if self._showTips == true then
    self:GetGameObject("ShowBtn"):SetActive(false)
    self:_PlayAnim("tipsout")
  end
end

function UIN48HardController:PlaySwitchAnim(levelType)
  self:StartTask(function(TT)
    if levelType == 1 then
      self._diffLevel:_HideAnim()
      self._normalLevel:SetActive(true)
    elseif levelType == 2 then
      self._normalLevel:_HideAnim()
      self._diffLevel:SetActive(true)
    end
    YIELD(TT, 250)
    self:_Refresh()
  end)
end

function UIN48HardController:_BlackLevelFirstTipsLocalDB(campaignid, save)
  local key = UIActivityHelper.GetLocalDBKeyWithPstId("_BlackLevelFirstTips_" .. campaignid .. "_")
  if save then
    LocalDB.SetInt(key, 1)
  else
    return not LocalDB.HasKey(key)
  end
end

function UIN48HardController:ClosePetEnhanceTips()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClosePetEnhanceTips)
end

function UIN48HardController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
end

function UIN48HardController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
end

function UIN48HardController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN48HardController:_OnComponentClose(componentCfgId)
  local blackHardComponent = self._blackHardComponent
  if blackHardComponent and blackHardComponent:GetComponentCfgId() == componentCfgId then
    self:_Back()
    return
  end
end
