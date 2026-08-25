local TimeUtil = CS.Framework.TimeUtil
local AvgFuncBtnComp, Super = System.NewClass("AvgFuncBtnComp")

function AvgFuncBtnComp:ctor(avgPanel, binder, avgModel)
  Super.ctor(self)
  self.ui = avgPanel.ui
  self.binder = binder
  self.avgPanel = avgPanel
  self.avgModel = avgModel
  self.playSpeed = Vue.ref(avgPanel.playSpeed)
  self.isFastMode = Vue.ref(avgPanel.isFastMode)
  self.isManualHideDialog = Vue.ref(avgPanel.isManualHideDialog)
  self.isAuto = Vue.ref(avgPanel.isAuto)
  self.isEnding = false
  self.isSkipping = false
  self.lastAutoSpeed = Vue.ref(1)
  self:OnBind(binder)
end

function AvgFuncBtnComp:OnBind(binder)
  ShortCutKeyManager.Instance:Register("Space", System.fn(self, self.OnBtnNext))
  binder:BindButtonClick(self.ui.Group_Btn_Jump, function()
    self:OnBtnJump()
  end)
  binder:BindButtonClick(self.ui.Btn_Hide_HUD, function()
    self.isManualHideDialog.value = true
  end)
  binder:BindTimer(0.8, 0, nil, function()
    binder:BindButtonClick(self.ui.Btn_Next, function()
      if self.isManualHideDialog.value then
        self.isManualHideDialog.value = false
      else
        self:OnBtnNext()
      end
    end)
  end)
  binder:BindToRaw(function(_, isShow)
    self.ui.DialogMenuPanel:SetActive(isShow)
    if self.ui.DialogMenuPanelLeft then
      self.ui.DialogMenuPanelLeft:SetActive(isShow)
    end
  end, System.fn(self, self.IsShowDialogMenu))
  self.binder:BindButtonClick(self.ui.Group_Btn_History, function()
    self:OpenHistoryPanel()
  end)
  self.binder:BindButtonClick(self.ui.Group_Btn_Skip, function()
    self:OnBtnSkip()
  end)
  self.binder:BindEvent(EventMgr.Instance.StorySkip, function()
    self:OnBtnSkip()
  end)
  self.binder:BindButtonClick(self.ui.Group_Btn_Auto, function()
    self:OnBtnAuto()
  end)
  self.binder:BindButtonClick(self.ui.Btn_Pause, function()
    self:OnBtnPause()
  end)
  self.binder:BindButtonClick(self.ui.Btn_Play, function()
    self:OnBtnPlay()
  end)
  self:BindUIVisible()
  self:BindPlaySpeed()
  self:InitLongPressFunc()
  binder:BindTimer(0.1, -1, function()
    self:_TryAutoPlay()
    self:CheckIsClearFastMode()
  end)
  binder:BindToRaw(function(_, nVal)
    if true == nVal then
      AudioManager.Instance:PostSoundEvent("Set_State_Avg_Speedup_CTRL_On")
    elseif false == nVal then
      AudioManager.Instance:PostSoundEvent("Set_State_Avg_Speedup_CTRL_Off")
    end
  end, function()
    return self.isFastMode.value
  end)
end

function AvgFuncBtnComp:HideDialogMenuPanelLeft(isShow)
  self.ui.Group_Btn_History:SetActive(isShow)
  self.ui.Btn_Hide_HUD:SetActive(isShow)
  if self.ui.DialogMenuPanelLeft then
    self.ui.DialogMenuPanelLeft:SetActive(isShow)
  end
end

function AvgFuncBtnComp:InitLongPressFunc()
  local binder = self.binder
  binder:BindEvent(EventMgr.Instance.NextDialog, function()
    self:OnBtnNext()
  end)
  binder:BindLongPressButton(self.ui.Btn_Next, function()
    if self.isAuto.value then
      return
    end
    self.isFastMode.value = true
  end, function()
    self.isFastMode.value = false
  end, 0.8)
  binder:BindEvent(EventMgr.Instance.TouchEndEvent, function()
    self.isFastMode.value = false
  end)
end

function AvgFuncBtnComp:IsShowDialogMenu()
  local info = self.avgModel:GetDialogInfo()
  local isTimelineShow = info.TimelineParam == nil
  local isHudShow = not self.isManualHideDialog.value
  local isNotNil = nil ~= self.avgModel.bgId and self.avgModel.bgId ~= CommonDefine.TransparentBG
  local isRadioDrama = self.avgModel:IsRadioDrama()
  if isRadioDrama then
    return false
  end
  return isTimelineShow and isHudShow and isNotNil
end

function AvgFuncBtnComp:BindPlaySpeed()
  self.binder:BindToRaw(function(_, value, _)
    TimeUtil.SetTimeScale(value)
  end, function()
    do return self.GetTimeScale end
    return self.GetTimeScale, self
  end)
  self.binder:BindToRaw(function(_, speed, _)
    self.avgPanel.avgVideoComp:SetPlaySpeed(speed)
  end, function()
    do return self.GetTimeScale end
    return self.GetTimeScale, self
  end)
  if not self.avgModel:IsNoBgDialog() then
    self:RecoverSavedSpeed()
  end
end

function AvgFuncBtnComp:GetTimeScale()
  local avgModel = self.avgModel
  if avgModel and avgModel:IsBanSpeedingUp() then
    return 1
  end
  if avgModel:IsDialogType(cd.AvgDialogType.RadioDrama) then
    return 1
  end
  if avgModel.video then
    return 1
  end
  if self.isFastMode.value then
    return 4
  end
  if 1 == self.playSpeed.value then
    return 1
  elseif self.playSpeed.value >= 2 then
    return 3
  end
end

function AvgFuncBtnComp:RecoverSavedSpeed()
  local lastSpeedKey = CommonDefine.LocalSaveKey.AvgLastAutoSpeed
  local lastSpeed = MobileFileDataManager.Instance:GetPlayerFileValue(lastSpeedKey, 0)
  if lastSpeed > 0 then
    self.lastAutoSpeed.value = lastSpeed
  end
  local savedKey = CommonDefine.LocalSaveKey.AvgSavedSpeed
  local savedSpeed = MobileFileDataManager.Instance:GetPlayerFileValue(savedKey, 0)
  if savedSpeed > 0 then
    self.lastAutoSpeed.value = savedSpeed
    self.playSpeed.value = savedSpeed
    self.isAuto.value = true
  end
end

function AvgFuncBtnComp:_SaveAutoSpeed(speed)
  local savedKey = CommonDefine.LocalSaveKey.AvgSavedSpeed
  MobileFileDataManager.Instance:SetPlayerFileValue(savedKey, speed)
  if speed > 0 then
    local lastSpeedKey = CommonDefine.LocalSaveKey.AvgLastAutoSpeed
    MobileFileDataManager.Instance:SetPlayerFileValue(lastSpeedKey, speed)
  end
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
end

function AvgFuncBtnComp:BindUIVisible()
  local binder = self.binder
  local avgModel = self.avgModel
  binder:BindToVisible(self.ui.Image_Auto_Speed_1, function()
    return 1 == self.playSpeed.value and self.isAuto.value
  end)
  binder:BindToVisible(self.ui.Image_Auto_Speed_2, function()
    return 2 == self.playSpeed.value and self.isAuto.value
  end)
  binder:BindToVisible(self.ui.Image_Auto_Speed_4, function()
    return 4 == self.playSpeed.value and self.isAuto.value
  end)
  binder:BindToVisible(self.ui.Group_Btn_History, function()
    return not avgModel:IsPlayingVideo()
  end)
  binder:BindToVisible(self.ui.Group_Btn_Auto, function()
    return self.isAuto.value and not avgModel:IsPlayingVideo()
  end)
  binder:BindToVisible(self.ui.Btn_Pause, function()
    return self.isAuto.value and not avgModel:IsPlayingVideo()
  end)
  binder:BindToVisible(self.ui.Btn_Play, function()
    return not self.isAuto.value and not avgModel:IsPlayingVideo()
  end)
  binder:BindToVisible(self.ui.Group_Btn_Skip, function()
    return not avgModel:IsPlayingVideo()
  end)
  binder:BindToVisible(self.ui.Btn_Hide_HUD, function()
    return not avgModel:IsPlayingVideo()
  end)
end

function AvgFuncBtnComp:OnBtnJump()
  local avgModel = self.avgModel
  local contentList = AvgStoryManager.Instance:GetDialogInfoList(avgModel.storyId)
  local list = {}
  for k, v in pairs(contentList) do
    table.insert(list, {
      id = k,
      text = string.format("%s %s", v.ChatID or "", v.Content or "")
    })
  end
  table.sort(list, function(a, b)
    return a.id < b.id
  end)
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    avgModel:ResetChoosedOption()
    avgModel:JumpToDialog(data.id)
  end, true)
end

function AvgFuncBtnComp:_RecordNextAttempt(blockReason)
  if self.isAuto.value or self.isFastMode.value then
    return
  end
  if UIManager.Instance:GetWindow(Urls.AvgDialogHistoryPanel) then
    return
  end
  if self.avgModel.optionIds then
    return
  end
  if self.ui.UI_Address_Panel_Dialog and self.ui.UI_Address_Panel_Dialog.activeSelf then
    return
  end
  local model = self.avgModel
  local stuckKey = string.format("%s_%s", model.chatIndex, blockReason)
  if self._stuckKey ~= stuckKey then
    self._stuckKey = stuckKey
    self._stuckStartTime = os.time()
    self._stuckClickCount = 0
  end
  if self._stuckClickCount then
    self._stuckClickCount = self._stuckClickCount + 1
  end
end

function AvgFuncBtnComp:_ClearStuckInfo()
  self._stuckStartTime = nil
  self._stuckClickCount = nil
end

function AvgFuncBtnComp:_IsSafeToNext()
  if not self._stuckKey or not self._stuckClickCount then
    return false
  end
  local stuckTime = DT.GetConstant("AvgDialog_StuckTime", 15)
  local clickCount = DT.GetConstant("AvgDialog_StuckClickCount", 15)
  if self._stuckStartTime and stuckTime < os.time() - self._stuckStartTime and clickCount <= self._stuckClickCount then
    self._stuckStartTime = nil
    self._stuckClickCount = nil
    print("--------------clear stuck", self._stuckKey, self._stuckStartTime)
    return true
  end
  return false
end

function AvgFuncBtnComp:_ReportStuck()
  local blockReason = self._stuckKey
  local dialogInfo = self.avgModel:GetDialogInfo()
  local content = dialogInfo and dialogInfo.Content or ""
  local err = string.format("AvgStuck: %s %s %s %s", self.avgModel.storyId, self.avgModel.chatIndex, blockReason, content)
  Logger.Warn(err)
  EventMgr.Instance.StoryStuck:Dispatch(self.avgModel.storyId, self.avgModel.chatIndex)
end

function AvgFuncBtnComp:OnBtnNext()
  if self.isEnding or self.avgModel:IsEnd() then
    return
  end
  if self.avgModel:IsDialogType(cd.AvgDialogType.RadioDrama) then
    return
  end
  if self:_IsSafeToNext() then
    self:_ReportStuck()
    self.avgModel:NextDialog()
    return
  end
  local textComp = self.avgPanel.textComp
  if textComp:IsPrinting() and not textComp:GetIsPassContentSliderStartTime() then
    if not self.isAuto.value and not self.isFastMode.value then
      textComp:StopTyping()
    end
    self:_RecordNextAttempt("IsPrinting")
    return
  end
  if not textComp:IsTextScrollDone() then
    textComp:SlideToNextLine()
    self:_RecordNextAttempt("IsTextScrollDone")
    return
  end
  if self.avgModel.optionIds then
    local optionComp = self.avgPanel.optionComp
    if optionComp and optionComp:IsShowOption() then
      optionComp:ShowOptionItems(true)
    end
    return
  end
  if textComp:IsWaitToRead() then
    self:_RecordNextAttempt("IsWaitToRead")
    return
  end
  if self.avgModel.isLockedInBgTrans then
    self:_RecordNextAttempt("IsLockedInBgTrans")
    return
  end
  local avgVideoComp = self.avgPanel.avgVideoComp
  if self.avgModel:IsPureVideoDialog() and not avgVideoComp:IsVideoPureEnd() then
    self.binder:SetActive(self.ui.Group_Btn_Skip, true)
    return
  end
  if self.avgPanel:CheckDoClickActions() then
    self:_RecordNextAttempt("CheckDoClickActions")
    return
  end
  if #self.avgModel.waitActionIdList > 0 then
    self:_RecordNextAttempt("waitActionIdList")
    EventMgr.Instance.OnStoryClickNext:Dispatch()
    return
  end
  self.avgModel:NextDialog()
end

function AvgFuncBtnComp:OpenHistoryPanel()
  if self.isSkipping then
    return
  end
  UIManager.Instance:Reopen(Urls.AvgDialogHistoryPanel, self.avgModel.histList)
end

function AvgFuncBtnComp:OnBtnSkip()
  if AvgStoryManager.Instance:IsLooping() then
    AvgStoryManager.Instance:StopLoop()
  end
  if self.avgModel:IsNoBgDialog() then
    EventMgr.Instance.SkipDialog:Dispatch()
    return
  end
  local avgVideoComp = self.avgPanel.avgVideoComp
  if self.avgModel:IsPureVideoDialog() and not avgVideoComp:IsVideoPureEnd() then
    avgVideoComp:ClearVideo()
    self.avgModel:NextDialog()
    return
  end
  if table.next(self.avgModel.optionIds or {}) then
    return
  end
  local nextOptionId = self.avgModel:GetNoSkipOptionId()
  if nextOptionId then
    self.avgModel:JumpToDialog(nextOptionId)
  else
    if self.isSkipping then
      return
    end
    Alert.SetMaskClickClose(true)
    local skipTipsId = 20078
    if not IntroductionDataUtils.IsFinish() then
      skipTipsId = 20185
    end
    Alert.Show(skipTipsId, nil, function()
      self.isSkipping = true
      EventMgr.Instance.SkipDialog:Dispatch()
    end)
  end
end

function AvgFuncBtnComp:OnBtnPause()
  self.isAuto.value = false
  self.playSpeed.value = 1
  self.isFastMode.value = false
  self:_SaveAutoSpeed(0)
end

function AvgFuncBtnComp:OnBtnPlay()
  self.isAuto.value = true
  self.playSpeed.value = self.lastAutoSpeed.value
  self.isFastMode.value = false
  self:_SaveAutoSpeed(self.playSpeed.value)
end

function AvgFuncBtnComp:OnBtnAuto()
  if not self.isAuto.value then
    self.isAuto.value = true
    self.playSpeed.value = self.lastAutoSpeed.value
    self.isFastMode.value = false
    self:_SaveAutoSpeed(self.playSpeed.value)
  else
    if 1 == self.playSpeed.value then
      self.playSpeed.value = 2
    elseif 2 == self.playSpeed.value then
      self.playSpeed.value = AvgDefine.MaxAutoPlaySpeed
    else
      self.playSpeed.value = 1
    end
    self.lastAutoSpeed.value = self.playSpeed.value
    self:_SaveAutoSpeed(self.playSpeed.value)
  end
end

function AvgFuncBtnComp:_TryAutoPlay()
  if UIManager.Instance:IsPanelRendering(Urls.AvgDialogHistoryPanel) then
    return
  end
  if UIManager.Instance:IsPanelRendering(Urls.AlertConfirm2Panel) then
    return
  end
  if not self.isAuto.value and not self.isFastMode.value then
    return
  end
  if self.isManualHideDialog.value then
    return
  end
  if 1 == self.playSpeed.value and os.time() < self.avgPanel:GetVoiceEndTs() then
    return
  end
  self:OnBtnNext()
end

function AvgFuncBtnComp:CheckIsClearFastMode()
  if self.isFastMode.value and InputManager.Instance:GetFingerCount() <= 0 then
    self.isFastMode.value = false
  end
end

function AvgFuncBtnComp:OnUnbind()
  ShortCutKeyManager.Instance:UnRegister("Space", System.fn(self, self.OnBtnNext))
end

return AvgFuncBtnComp
