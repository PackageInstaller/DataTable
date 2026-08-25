local PopupQueManager, Super = System.NewClass("PopupQueManager", Manager, IUpdater)

function PopupQueManager:ctor()
  Super.ctor(self)
  self.isEnabled = false
  self._isDealRewardsInQue = false
  self.popupComps = {}
  self.stopUrls = {
    Urls.SummonNewItemPanel,
    Urls.AvgFinishPanel,
    Urls.DBGMainCopyOutPanel,
    Urls.PvpPasswordWaitingView,
    Urls.PvpPasswordRoleListView
  }
  self.tempPriorityCompList = {}
  self._stuckLastReason = nil
  self._stuckCount = 0
  self._stuckNextPrintAt = 1
end

function PopupQueManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
  self:InitPopupList()
  binder:BindTimer(5, -1, System.fn(self, self.CheckPopupQueStuck))
end

function PopupQueManager:Clear()
  for _, popupComp in ipairs(self.popupComps) do
    popupComp:Clear()
    popupComp:SetBusy(false)
  end
end

function PopupQueManager:SetBusy(isBusy)
  if isBusy then
    return
  end
  for _, popupComp in ipairs(self.popupComps) do
    popupComp:SetBusy(false)
  end
end

function PopupQueManager:CancelBusy()
  self:SetBusy(false)
end

function PopupQueManager:InitPopupList()
  if #self.popupComps > 0 then
    return
  end
  local popupList = {
    PopupOutOfDateTaskComp,
    PopupFirstChapterFinishComp,
    PopupLoginAvgDialogComp,
    PopupMonthCardComp,
    PopupKeeperSkillComp,
    PopupRelicUnlockComp,
    PopupReturnBackActivityComp,
    PopupFeatureUnlockComp,
    PopupNewbieGuideComp,
    PopupBattlePassComp,
    PopupDayRefreshComp,
    PopupRewardComp,
    PopupLevelUpComp,
    PopupMonthSignActivityComp,
    PopupTaskAppointRstTipsComp,
    Popup2ndAnniversaryInviteComp,
    PopupTutorialAvgComp
  }
  self.popupComps = {}
  for index, compCls in ipairs(popupList) do
    self.popupComps[index] = self.binder:BindComponent(compCls())
  end
end

function PopupQueManager:GetPopupComp(compCls)
  for _, popupComp in ipairs(self.popupComps) do
    if System.is(popupComp, compCls) then
      return popupComp
    end
  end
end

function PopupQueManager:AddToTempPriorityComp(popupComp)
  if not table.contains(self.tempPriorityCompList, popupComp) then
    table.insert(self.tempPriorityCompList, popupComp)
  end
end

function PopupQueManager:Update()
  if self:GetBusyAndReason() then
    return
  end
  self:DealUpdateRed()
  if not self:IsEnabled() then
    for _, popupComp in ipairs(self.popupComps) do
      if System.is(popupComp, PopupRewardComp) or System.is(popupComp, PopupTutorialAvgComp) then
        popupComp:CheckPopup()
        if popupComp:IsBusy() then
          return
        end
      end
    end
    return
  end
  for index, popupComp in ipairs(self.tempPriorityCompList) do
    popupComp:CheckPopup()
    if popupComp:IsBusy() then
      table.remove(self.tempPriorityCompList, index)
      return
    end
  end
  for _, popupComp in ipairs(self.popupComps) do
    popupComp:CheckPopup()
    if popupComp:IsBusy() then
      return
    end
  end
end

local PopupStuckResetSec = 10

function PopupQueManager:CheckPopupQueStuck()
  local busy, reason = self:GetBusyAndReason()
  if not busy then
    if self._stuckLastReason then
      Logger.Warn("PopupQueManager:CheckPopupQueStuck recovered", self._stuckLastReason, "totalChecks:" .. self._stuckCount)
    end
    self._stuckLastReason = nil
    self._stuckCount = 0
    self._stuckNextPrintAt = 1
    self._stuckFirstTime = nil
    return
  end
  if reason ~= self._stuckLastReason then
    self._stuckLastReason = reason
    self._stuckCount = 1
    self._stuckNextPrintAt = 2
    self._stuckFirstTime = os.time()
    Logger.Warn("PopupQueManager:CheckPopupQueStuck", reason, "count:1")
    return
  end
  self._stuckCount = self._stuckCount + 1
  if self._stuckCount >= self._stuckNextPrintAt then
    Logger.Warn("PopupQueManager:CheckPopupQueStuck", reason, "count:" .. self._stuckCount, "elapsed:" .. self._stuckCount * 5 .. "s")
    self._stuckNextPrintAt = self._stuckNextPrintAt * 2
  end
  local elapsed = os.time() - (self._stuckFirstTime or os.time())
  if elapsed >= PopupStuckResetSec and 1 == string.find(reason, "Popup Comp Busy:", 1, true) then
    for _, popupComp in ipairs(self.popupComps) do
      if popupComp:IsBusy() then
        Logger.Warn("PopupQueManager:ForceResetBusyComp", popupComp.__name, "stuckFor:" .. elapsed .. "s", "reason:" .. reason)
        popupComp:SetBusy(false)
      end
    end
    self._stuckFirstTime = os.time()
    self._stuckCount = 0
    self._stuckNextPrintAt = 1
  end
end

function PopupQueManager:GetBusyAndReason()
  for _, url in ipairs(self.stopUrls) do
    if UIManager.Instance:GetWindow(url) then
      return true, "panelOpened:" .. url
    end
  end
  if NewbieGuideManager.Instance:IsBusy() then
    return true, NewbieGuideManager.Instance:GetBusyReason()
  end
  if PvpPasswordModel.Instance:IsInRoom() then
    return true, "PvpPasswordInRoom"
  end
  if PvPMatchDataUtils.GetIsPvpPreparing() then
    return true, "PvpPreparing"
  end
  if AvgStoryManager.Instance:IsPlaying() then
    return true, "AvgStoryPlaying"
  end
  local rewardComp = self:GetPopupComp(PopupRewardComp)
  if rewardComp and not rewardComp:HasPendingRewards() and UIManager.Instance:GetWindow(Urls.ShowRewardPanel) then
    return true, "panelOpened:ShowRewardPanel"
  end
  if self:IsBusy() then
    local busyComp = self:GetBusyComp()
    return true, "Popup Comp Busy:" .. busyComp.__name
  end
end

function PopupQueManager:SetEnabled(isEnabled)
  self.isEnabled = isEnabled
  Logger.Warn("PopupQueManager:SetEnabled", isEnabled)
end

function PopupQueManager:IsEnabled()
  return self.isEnabled
end

function PopupQueManager:SetIsDealRewardsInQue(isDeal)
  self._isDealRewardsInQue = isDeal
end

function PopupQueManager:GetIsDealRewardsInQue()
  return self._isDealRewardsInQue
end

function PopupQueManager:IsBusy()
  for _, popupComp in ipairs(self.popupComps) do
    if popupComp:IsBusy() then
      return true, popupComp.__name
    end
  end
end

function PopupQueManager:GetBusyComp()
  for _, popupComp in ipairs(self.popupComps) do
    if popupComp:IsBusy() then
      return popupComp
    end
  end
end

function PopupQueManager:SetForbidShowRewardTime(time)
  assert(time < 5, "设置奖励显示延迟时间必须小于5秒")
  local popupRewardComp = self:GetPopupComp(PopupRewardComp)
  popupRewardComp:SetForbidShowRewardTime(time)
end

function PopupQueManager:ClearMonthCardModel()
  local comp = self:GetPopupComp(PopupMonthCardComp)
  if comp then
    comp:ClearMonthCardModel()
  end
end

function PopupQueManager:InsertPopTutorialAvgInfo(avgTid, key)
  local comp = self:GetPopupComp(PopupTutorialAvgComp)
  if comp then
    comp:InsertPopTutorialAvgInfo(avgTid, key)
  end
end

function PopupQueManager:ClearPopTutorialAvgInfo()
  local comp = self:GetPopupComp(PopupTutorialAvgComp)
  if comp then
    comp:ClearPopTutorialAvgInfo()
  end
end

function PopupQueManager:IsPopupAddOpen(popupAdTid)
  local popupAdCfg = DT.PopupAd[popupAdTid]
  local popupLinkedTidList = popupAdCfg.LinkedActivity
  for _, linkedTid in ipairs(popupLinkedTidList) do
    local activityType = ActivityCfgUtils.GetCfgField("ActivityType", linkedTid)
    if activityType == ActivityDefine.ActivityType.TwoAnniversaryWorldBossActivity and ActivityManager.Instance:IsActivityFinishedByTid(linkedTid) then
      return false
    end
    if ActivityDataUtils.IsActivityOpen(linkedTid) then
      return true
    end
    if SummonDataUtils.IsSummonPoolOpen(linkedTid) then
      return true
    end
    if MainShopDataUtils.IsShopOpen(linkedTid) then
      local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Shop, linkedTid)
      if unlocked then
        return true
      end
    end
  end
  return false
end

function PopupQueManager:OnActivityChange()
  self.binder:BindTimer(0.1, 0, nil, function()
    for _, popupComp in ipairs(self.popupComps) do
      if popupComp.OnActivityChange then
        popupComp:OnActivityChange()
      end
    end
  end)
end

function PopupQueManager:SetDelayRedUpdate(redUpdateFunc)
  if not self._delayRedUpdateTimeMap then
    self._delayRedUpdateTimeMap = {}
  end
  self._delayRedUpdateTimeMap[redUpdateFunc] = os.time() + CommonDefine.AwakerRedUpdateDelay
end

function PopupQueManager:DealUpdateRed()
  if not self._delayRedUpdateTimeMap then
    return
  end
  local now = os.time()
  for func, time in pairs(table.clone(self._delayRedUpdateTimeMap)) do
    if now > time then
      func()
      self._delayRedUpdateTimeMap[func] = nil
    end
  end
end

local copyUrls = {
  Urls.CopyMainView,
  Urls.CopyMainChapterView
}

function PopupQueManager:IsInCopyView()
  for _, url in ipairs(copyUrls) do
    if UIManager.Instance:GetWindow(url) then
      return true
    end
  end
  return false
end

return PopupQueManager
