_class("UISeasonOnceMissionControllerTab", UICustomWidget)
UISeasonOnceMissionControllerTab = UISeasonOnceMissionControllerTab

function UISeasonOnceMissionControllerTab:OnShow(uiParams)
  self:InitWidget()
  self:Deselect()
end

function UISeasonOnceMissionControllerTab:OnHide()
  self:CancelTimer()
end

function UISeasonOnceMissionControllerTab:InitWidget()
  self.title = self:GetUIComponent("UILocalizationText", "Title")
  self.new = self:GetGameObject("New")
  self.locked = self:GetGameObject("Locked")
  self.closed = self:GetGameObject("Closed")
  self.lockText = self:GetUIComponent("UILocalizationText", "LockText")
  self.closeText = self:GetUIComponent("UILocalizationText", "CloseText")
  self._notOpenGo = self:GetGameObject("NotOpen")
  self.openCountDown = self:GetUIComponent("UILocalizationText", "openCountDown")
  self.logoTitle = self:GetUIComponent("RawImageLoader", "logoTitle")
  self.rootRawImage = self:GetUIComponent("RawImageLoader", "Root")
end

function UISeasonOnceMissionControllerTab:SetData(onceMissionData, idx, cpt, onSelect)
  self._index = idx
  self._onSelect = onSelect
  self._onceMissionData = onceMissionData
  self._cpt = cpt
  self._firstCheckTimeUnlock = true
  local cfg = Cfg.cfg_season_brance_tab[cpt:GetComponentCfgId()]
  if cfg then
    self.title:SetText(StringTable.Get(cfg.TabName))
    self.logoTitle:LoadImage(cfg.TabNamePic)
    self.rootRawImage:LoadImage(cfg.TabPicture)
  end
  self:RefreshTime()
  self:RefreshNew()
  self:RefreshState()
end

function UISeasonOnceMissionControllerTab:RefreshState()
  self:CancelTimer()
  local state = self._onceMissionData:GetCompState(self._cpt)
  self._notOpenGo:SetActive(state == SeasonOnceMissionData.ComState_NotOpen)
  self.closed:SetActive(state == SeasonOnceMissionData.ComState_Closed)
  self.locked:SetActive(state == SeasonOnceMissionData.ComState_OpenButLock)
  local cmpInfo = self._cpt:GetComponentInfo()
  if cmpInfo.m_need_mission_id > 0 then
    local missionName = Cfg.cfg_season_mission[cmpInfo.m_need_mission_id].Name
    local lvName = StringTable.Get(missionName)
    self.lockText:SetText(StringTable.Get("str_season_level_pre_condition_tip", lvName))
  end
  if state == SeasonOnceMissionData.ComState_Closed then
  elseif state == SeasonOnceMissionData.ComState_NotOpen then
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:RefreshTime()
    end)
  elseif state == SeasonOnceMissionData.ComState_OpenButLock then
  elseif state == SeasonOnceMissionData.ComState_Normal then
  end
end

function UISeasonOnceMissionControllerTab:RefreshNew()
  local bNew = self._onceMissionData:HasNewByComp(self._cpt)
  self.new:SetActive(bNew)
end

function UISeasonOnceMissionControllerTab:Deselect()
  self:_PlayAnim("down")
end

function UISeasonOnceMissionControllerTab:Select()
  self:_PlayAnim("up")
end

function UISeasonOnceMissionControllerTab:RootOnClick(go)
  local state = self._onceMissionData:GetCompState(self._cpt)
  if state == SeasonOnceMissionData.ComState_Closed then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
  elseif state == SeasonOnceMissionData.ComState_NotOpen then
    ToastManager.ShowToast(StringTable.Get("str_season_s5_branch_tab_lock"))
  elseif state == SeasonOnceMissionData.ComState_OpenButLock then
    if self._firstCheckTimeUnlock then
      self._firstCheckTimeUnlock = false
      self:RequestOnceMissionData()
    else
      local cmpInfo = self._cpt:GetComponentInfo()
      if cmpInfo.m_need_mission_id > 0 then
        local missionName = Cfg.cfg_season_mission[cmpInfo.m_need_mission_id].Name
        local lvName = StringTable.Get(missionName)
        ToastManager.ShowToast(StringTable.Get("str_season_level_pre_condition_tip", lvName))
      end
    end
  elseif state == SeasonOnceMissionData.ComState_Normal then
    self._onSelect(self._index)
  end
end

function UISeasonOnceMissionControllerTab:ReadNew()
  local bNew = self._onceMissionData:HasNewByComp(self._cpt)
  if bNew then
    self._onceMissionData:SetNewAsReadBy(self._cpt)
    self:RefreshNew()
  end
end

function UISeasonOnceMissionControllerTab:CancelTimer()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UISeasonOnceMissionControllerTab:RequestOnceMissionData()
  self:StartTask(function(TT)
    self:Lock("UISeasonOnceMissionControllerTab:CancelTimer")
    self._onceMissionData:ForceLoadData(TT)
    self:RefreshState()
    self:UnLock("UISeasonOnceMissionControllerTab:CancelTimer")
  end, self)
end

function UISeasonOnceMissionControllerTab:RefreshTime()
  local cInfo = self._cpt:GetComponentInfo()
  if not cInfo then
    return
  end
  local openTime = cInfo.m_unlock_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local timeStr = StringTable.Get("str_season_debris_locktime", UIActivityCustomHelper.GetTimeString(openTime - curTime))
  self.openCountDown:SetText(timeStr)
  if openTime <= curTime then
    self:CancelTimer()
    if self._firstCheckTimeUnlock then
      self._firstCheckTimeUnlock = false
      self:RequestOnceMissionData()
    end
  end
end

function UISeasonOnceMissionControllerTab:_PlayAnim(idx, callback)
  local tb = {
    up = {
      animName = "uieff_UISeasonOnceMissionControllerTab_up"
    },
    down = {
      animName = "uieff_UISeasonOnceMissionControllerTab_down"
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end
