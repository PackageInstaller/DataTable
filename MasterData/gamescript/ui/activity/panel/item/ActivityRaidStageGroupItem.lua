local ActivityRaidStageGroupItem, Super = System.NewComponent("ActivityRaidStageGroupItem", ActivityStageGroupItem)

function ActivityRaidStageGroupItem:OnBind(binder)
  self.binder = binder
  self.ui.uiNode:SetActive(self.stageGroupId ~= nil)
  if not self.stageGroupId then
    return
  end
  self:SetStageGroupInfo()
  self:SetTimeAndStageGroupToOpen()
  self:RefreshKillCount()
  self:SetLimitSchool()
  self:BindNewStageGroupRed({
    self.stageGroupId
  })
  self.binder:BindTimer(0.3, -1, System.fn(self, self._OnOpenStateTimerTick), nil)
end

function ActivityRaidStageGroupItem:_OnOpenStateTimerTick()
  self:SetTimeAndStageGroupToOpen()
end

function ActivityRaidStageGroupItem:SetStageGroupInfo()
  local stageGroupCfg = DT.StageGroup[self.stageGroupId]
  if not stageGroupCfg then
    return
  end
  self.binder:SetText(self.ui.Text_Name, stageGroupCfg.Name)
  if stageGroupCfg.DailyIcon then
    self.binder:SetImage(self.ui.Image_Base, stageGroupCfg.DailyIcon[1])
  end
  if self.ui.Text_StageNum and self.stageNum then
    local stageNum = StrUtils.ParseEmojiNumber(self.stageNum, "Number1")
    local desc = self.stageNum < 10 and string.format("<sprite=\"Number1\" index=0>%s", stageNum) or stageNum
    self.binder:SetText(self.ui.Text_StageNum, desc)
  end
  self.binder:BindZ1Button(self.ui.Image_Container, System.fn(self, self._OnClickContainer))
end

function ActivityRaidStageGroupItem:_OnClickContainer()
  if not self._isTimeToOpen.value then
    Alert.ShowStr(LT.Text(DT.TipsType[20032].Title))
    return
  end
  if not self.isStageUnlock then
    local featureId = self:_GetFraturId()
    PlayerDataUtils.AlertLockedTips(featureId, self.stageGroupId)
    return
  end
  if CopyDataUtils.HasDisplayTime(self.stageGroupId) then
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.NewStageGroupUnlock, RedPointDataUtils.RedAttrType.IsNew, self.stageGroupId)
  end
  local redKey = PlayerDataUtils.GetFeatureByKey(self.stageGroupId)
  if redKey then
    RedPointDataUtils.ReqRemoveData(redKey, RedPointDataUtils.RedAttrType.IsNew, self.stageGroupId)
  end
  if self:CheckIsCanClick() and self.clickCb then
    self.clickCb(self.stageGroupId)
  end
end

function ActivityRaidStageGroupItem:_GetConfiguredStageOpenTimestamp()
  local stageGroupCfg = DT.StageGroup[self.stageGroupId]
  local openTime = stageGroupCfg and stageGroupCfg.StageDisplayDate
  if openTime and openTime > 0 then
    return openTime
  end
  local activityCfg = ActivityDataUtils.GetConfig(self.activityTid)
  local activityStartTime = activityCfg and activityCfg.ActivityStartTime
  if activityStartTime and activityStartTime > 0 then
    local stageNum = self.stageNum or 1
    if stageNum < 1 then
      stageNum = 1
    end
    Logger.Warn("ActivityRaidStageGroupItem use ActivityStartTime fallback, activityTid=%s stageGroupId=%s", self.activityTid, self.stageGroupId)
    return activityStartTime + (stageNum - 1) * TimeUtils.OneDaySeconds
  end
  Logger.Warn("ActivityRaidStageGroupItem missing open time, activityTid=%s stageGroupId=%s", self.activityTid, self.stageGroupId)
  return 0
end

function ActivityRaidStageGroupItem:SetTimeAndStageGroupToOpen()
  local scheduledOpen = self:_GetConfiguredStageOpenTimestamp()
  local curTime = TimeUtils.GetServerTime()
  local isTimeToOpen = scheduledOpen <= 0 or scheduledOpen <= curTime
  self._isTimeToOpen.value = isTimeToOpen
  self.isStageUnlock = self:_IsFratureUnlock()
  local isUnlocked = self.isStageUnlock and isTimeToOpen
  self.binder:SetActive(self.ui.Image_Base, isUnlocked)
  self.binder:SetActive(self.ui.Image_Disable, not isUnlocked)
  self.binder:SetTextColorType(self.ui.Text_Name, isUnlocked and cd.ColorType.Light or cd.ColorType.Dark)
  if self.ui.Text_StageNum then
    self.binder:SetCanvasGroup(self.ui.Text_StageNum, isUnlocked and 1 or 0.5)
  end
  if scheduledOpen > curTime then
    self.binder:SetText(self.ui.Text_Timing, LT.Textf("StageOpenCountdownText", TimeUtils.format2Hour(scheduledOpen - curTime)))
    self.binder:SetActive(self.ui.Text_Timing, true)
  else
    self.binder:SetText(self.ui.Text_Timing, "")
    self.binder:SetActive(self.ui.Text_Timing, false)
  end
  if self.ui.Group_Timing then
    self.ui.Group_Timing:SetActive(scheduledOpen > curTime)
  end
  if self.ui.Text_C_LockTips then
    self.ui.Text_C_LockTips:SetActive(isTimeToOpen and not self.isStageUnlock)
  end
  self:RefreshKillCount()
end

function ActivityRaidStageGroupItem:RefreshKillCount()
  if not self.binder or not self.ui.Text_KilledCount then
    return
  end
  local isOpen = self._isTimeToOpen and self._isTimeToOpen.value and self.isStageUnlock
  local count = ActivityRaidUtils.GetWorldBossKillCount(self.activityTid, self.stageGroupId)
  local isShowKillCount = isOpen and (count or 0) > 0
  if self.ui.Group_KillCount then
    self.binder:SetActive(self.ui.Group_KillCount, isShowKillCount)
  else
    self.binder:SetActive(self.ui.Text_KilledCount, isShowKillCount)
  end
  if isShowKillCount then
    self.binder:SetText(self.ui.Text_KilledCount, LT.Textf("KilledMonsterCount", count))
  end
end

return ActivityRaidStageGroupItem
