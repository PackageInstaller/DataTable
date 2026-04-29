_class("UICN12N41HardController", UIController)
UICN12N41HardController = UICN12N41HardController

function UICN12N41HardController:_SetCommonTopButton()
  local function closeCallback()
    self:_Back()
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback)
end

function UICN12N41HardController:_Back()
  local campaignMain = CampaignConst.GetSafeStateInfo(self._campaign._id, nil, UIStateType.UICN12N41MainController, nil)
  local uiMain = CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:SwitchState_Safe(true, {campaignMain, uiMain})
end

function UICN12N41HardController:_SetRemainingTime(widgetName, descId, endTime, tickCallback, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, tickCallback, stopCallback)
end

function UICN12N41HardController:_PlayAnim(idx, callback)
  local tb = {
    hardin = {
      animName = "uieff_UINCN12N41HardLevelMain_HardIn",
      duration = 700
    },
    diffin = {
      animName = "uieff_UINCN12N41HardLevelMain_DiffIn",
      duration = 700
    },
    hardtodiff = {
      animName = "uieff_UINCN12N41HardLevelMain_Switch_HardToDiff",
      duration = 533
    },
    difftohard = {
      animName = "uieff_UINCN12N41HardLevelMain_Switch_DiffToHard",
      duration = 533
    },
    tipsin = {
      animName = "uieff_UINCN12N41HardLevelMain_Tips_in",
      duration = 567
    },
    tipsout = {
      animName = "uieff_UINCN12N41HardLevelMain_Tips_out"
    },
    hardunlock = {
      animName = "uieff_UINCN12N41HardLevelMain_HardUnlock"
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end

function UICN12N41HardController:LoadData(TT, res)
  self._campaignType = UICN12N41Helper.GetCampaignType(self._isReview)
  self._componentId_Line = UICN12N41Helper.GetComponentId("hard", self._isReview)
  self._componentId_Black = UICN12N41Helper.GetComponentId("black", self._isReview)
  self._showTips = false
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {
    self._componentId_Line
  })
  local fRes = AsyncRequestRes:New()
  self._campaign:ReLoadCampaignInfo_Force(TT, fRes)
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._levelHardComponent = self._campaign:GetComponent(self._componentId_Line)
  self._levelHardCompInfo = self._campaign:GetComponentInfo(self._componentId_Line)
  self._blackHardComponent = self._campaign:GetComponent(self._componentId_Black)
  self._blackHardCompInfo = self._campaign:GetComponentInfo(self._componentId_Black)
end

function UICN12N41HardController:LoadDataOnEnter(TT, res, uiParams)
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:LoadData(TT, res)
  UIActivityDiffLevelCupData.CreateEntiesDesc()
end

function UICN12N41HardController:OnShow(uiParams)
  self:_SetCommonTopButton()
  self._normalLevel = UICN12N41HardLine:New(self)
  self._normalLevel:SetData(self._campaign, self._levelHardComponent)
  self._normalLevel:SetActive(false)
  self._diffLevel = UICN12N41HardBlack:New(self)
  self._diffLevel:SetData(self._campaign, self._blackHardComponent)
  self._diffLevel:SetActive(false)
  self._isNormalUI = uiParams[1] and true
  self._levelType = uiParams[2] or 1
  if uiParams[2] == nil and self._blackHardComponent:ComponentIsOpen() then
    self._levelType = 2
    UICN12N41Helper.LocalDB_Set("black", "New")
    UICN12N41Helper.LocalDB_Set_CrossDay("black", "Red")
  end
  local closeTime = self._blackHardCompInfo.m_close_time
  self:_SetRemainingTime("_time", "str_cn12_n41_line_remain_time", closeTime, nil, function(first)
    if not first then
      self:_Refresh()
    end
  end)
  if self._levelType == 1 then
    self:_PlayAnim("hardin")
  elseif self._levelType == 2 then
    self:_PlayAnim("diffin")
  end
  self:_Refresh()
  if self._levelType == 2 and uiParams[3] then
    self._diffLevel:ClickNodeByID(uiParams[3])
  end
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  self:AttachEvents()
end

function UICN12N41HardController:OnHide()
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

function UICN12N41HardController:OnTeamReset()
  self:StartTask(function(TT)
    local lockName = "UICN12N41HardController:OnTeamReset"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self._normalLevel:SetData(self._campaign, self._levelHardComponent)
    self._diffLevel:SetData(self._campaign, self._blackHardComponent)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamResetInternal)
    self:UnLock(lockName)
  end)
end

function UICN12N41HardController:_Refresh(playAnim)
  self:_SwitchLevelType(self._levelType, playAnim)
end

function UICN12N41HardController:_SwitchLevelType(levelType, playAnim)
  if levelType == 1 then
    self._diffLevel:SetActive(false)
    self._normalLevel:SetActive(true)
    self._normalLevel:_Refresh()
  elseif levelType == 2 then
    self._diffLevel:SetActive(true)
    self._normalLevel:SetActive(false)
    self._diffLevel:_Refresh()
  end
  local widgetGroup = {
    [1] = {},
    [2] = {"IntroBtn"}
  }
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetGroup, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, levelType)
  self:_SetLineBtn(levelType)
  self:_SetBlackBtn(levelType)
end

function UICN12N41HardController:_SetLineBtn(levelType)
  self:GetGameObject("_BtnSelected_Line"):SetActive(levelType == 1)
end

function UICN12N41HardController:_SetBlackBtn(levelType)
  self:GetGameObject("_BtnSelected_Black"):SetActive(levelType == 2)
  local isLock = self:_GetBlackLevelIslock()
  local isOver = self:_GetIsOver()
  if not isOver then
    if isLock ~= 0 then
      if isLock == 1 then
        self:GetGameObject("_blackTime"):SetActive(true)
        self:GetGameObject("_pass_lock"):SetActive(false)
        self:_SetRemainingTime("_blackTime", "str_cn12_n41_line_lock_time_tips", self._blackHardCompInfo.m_unlock_time, nil, function()
          if self._levelHardCompInfo.m_pass_mission_info[self._blackHardCompInfo.m_need_mission_id] ~= nil then
            self:GetGameObject("_BlackBtnLock"):SetActive(true)
            self:GetGameObject("_blackFirstTips"):SetActive(true)
            UIWidgetHelper.PlayAnimation(self, "_BlackBtnLock", "uieff_UINCN12N41HardLevelMain_HardUnlock", 200, function()
              self:GetGameObject("_BlackBtnLock"):SetActive(false)
              self._levelType = 2
              UICN12N41Helper.LocalDB_Set("black", "New")
              UICN12N41Helper.LocalDB_Set_CrossDay("black", "Red")
              self:PlaySwitchAnim(self._levelType)
            end)
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
        local text = StringTable.Get("str_cn12_n41_hard_level_lock_tips", lvName)
        passlock:SetText(text)
      end
    else
      self:GetGameObject("_BlackBtnLock"):SetActive(isLock ~= 0)
    end
    if isLock == 0 and self:_BlackLevelFirstTipsLocalDB(self._blackHardCompInfo.m_campaign_id) then
      self:_BlackLevelFirstTipsLocalDB(self._blackHardCompInfo.m_campaign_id, true)
      self:_PlayAnim("tipsin", function()
        self:GetGameObject("ShowBtn"):SetActive(true)
        self._showTips = true
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

function UICN12N41HardController:_GetBlackLevelIslock()
  local unlockTime = self._blackHardCompInfo.m_unlock_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local stamp = unlockTime - curTime
  if 0 < stamp then
    return 1
  end
  if self._levelHardCompInfo.m_pass_mission_info[self._blackHardCompInfo.m_need_mission_id] == nil then
    return 2
  end
  return 0
end

function UICN12N41HardController:_GetIsOver()
  local closeTime = self._blackHardCompInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  return 0 < curTime - closeTime
end

function UICN12N41HardController:LineBtnOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 1 then
    return
  end
  if self._levelHardComponent:ComponentIsClose() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:_Back()
    return
  end
  self._levelType = 1
  self:PlaySwitchAnim(self._levelType)
end

function UICN12N41HardController:BlackBtnOnClick()
  self:ClosePetEnhanceTips()
  if self._levelType == 2 then
    return
  end
  local isLock = self:_GetBlackLevelIslock()
  local isOver = self:_GetIsOver()
  if isOver then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:_Back()
    return
  end
  local curTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  if isLock == 1 then
    ToastManager.ShowToast(StringTable.Get("str_cn12_n41_hard_time_lock"))
    return
  end
  if isLock == 2 then
    local missionName = Cfg.cfg_campaign_mission[self._blackHardCompInfo.m_need_mission_id].Name
    local lvName = StringTable.Get(missionName)
    local text = StringTable.Get("str_cn12_n41_hard_level_lock_tips", lvName)
    ToastManager.ShowToast(text)
    return
  end
  UICN12N41Helper.LocalDB_Set("black", "New")
  UICN12N41Helper.LocalDB_Set_CrossDay("black", "Red")
  self._levelType = 2
  self:PlaySwitchAnim(self._levelType)
end

function UICN12N41HardController:IntroBtnOnClick()
  self:ShowDialog("UIIntroLoader", "UICN12N41BlackIntro")
end

function UICN12N41HardController:ShowBtnOnClick()
  if self._showTips == true then
    self:_PlayAnim("tipsout")
    self:GetGameObject("ShowBtn"):SetActive(false)
  end
end

function UICN12N41HardController:PlaySwitchAnim(levelType)
  if levelType == 1 then
    self._normalLevel:SetActive(true)
    self:_PlayAnim("difftohard", function()
      self:_Refresh()
    end)
  elseif levelType == 2 then
    self._diffLevel:SetActive(true)
    self:_PlayAnim("hardtodiff", function()
      self:_Refresh()
    end)
  end
end

function UICN12N41HardController:_BlackLevelFirstTipsLocalDB(campaignid, save)
  local key = UIActivityHelper.GetLocalDBKeyWithPstId("_BlackLevelFirstTips_" .. campaignid .. "_")
  if save then
    LocalDB.SetInt(key, 1)
  else
    return not LocalDB.HasKey(key)
  end
end

function UICN12N41HardController:ClosePetEnhanceTips()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClosePetEnhanceTips)
end

function UICN12N41HardController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
end

function UICN12N41HardController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self._OnComponentClose)
end

function UICN12N41HardController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UICN12N41HardController:_OnComponentClose(componentCfgId)
  local blackHardComponent = self._blackHardComponent
  if blackHardComponent and blackHardComponent:GetComponentCfgId() == componentCfgId then
    self:_Back()
    return
  end
  local levelComponent = self._levelHardComponent
  if levelComponent and levelComponent:GetComponentCfgId() == componentCfgId then
    self:_Back()
    return
  end
end
