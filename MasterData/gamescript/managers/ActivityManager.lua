local ActivityManager, Super = System.NewClass("ActivityManager", Manager)

function ActivityManager:ctor()
  Super.ctor(self)
end

function ActivityManager:Awake(binder)
  self.binder = binder
  self.model = binder:createModel(ActivityModel)
  binder:BindRawTable(function()
    return DataCenter.activityData.activityDatas
  end, System.fn(self, self._OnActivityDataChanged))
  binder:BindToRaw(function(_, currPlayerLevel, oldLevel)
    self:_OnPlayerLevelChanged(_, currPlayerLevel, oldLevel)
    EventMgr.Instance.OnActivityDisplayChanged:Dispatch()
  end, function()
    local playerData = DataCenter.playerData
    if not (playerData and playerData.DRole) or not playerData.DRole.level then
      return
    end
    return playerData.DRole.level
  end)
  binder:BindToRaw(function(_, dayExp)
    if not dayExp then
      return
    end
    self:_OnPlayerDayExpChanged()
    EventMgr.Instance.OnActivityDisplayChanged:Dispatch()
  end, function()
    local playerData = DataCenter.playerData
    if not (playerData and playerData.DRole) or not playerData.DRole.level then
      return
    end
    return playerData.DRole.dayExp
  end)
  binder:BindEvent(EventMgr.Instance.OnStagePassEvent, System.bind(self.model.UpdateNotOpenActivity, self.model))
  binder:BindEvent(EventMgr.Instance.CloseUIPanel, function(url)
    if url == Urls.GmPanel then
      binder:BindTimer(0.5, 0, nil, function()
        self.model:UpdateNotOpenActivity()
      end)
    end
  end)
  binder:BindEvent(EventMgr.Instance.AddItemEvent, function()
    ActivityDataUtils.CheckNeedReqActivityData()
  end)
end

function ActivityManager:GetActivityList()
  local list = {}
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    if activityData then
      table.insert(list, activityData)
    end
  end
  return list
end

function ActivityManager:GetDisplayActivityList()
  local list = {}
  for tid in pairs(self.model.displayTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    if activityData then
      table.insert(list, activityData)
    end
  end
  return list
end

function ActivityManager:GetMultiDropActivity(stageGroupTid)
  if not self.model.activityTidMap or not stageGroupTid then
    return
  end
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    if activityData then
      local config = ActivityDataUtils.GetConfig(tid)
      if config and config.ActivityType == ActivityDefine.ActivityType.DoubleOutput and config.ActivityPara1 then
        for _, _stageGroupTid in pairs(config.ActivityPara1) do
          if stageGroupTid == _stageGroupTid then
            return activityData
          end
        end
      end
    end
  end
  return
end

function ActivityManager:IsActivityOpenByType(activityType)
  if not self.model.activityTidMap then
    return
  end
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    if activityData and activityData.state ~= ActivityDefine.ActivityState.Finish then
      local config = ActivityDataUtils.GetConfig(tid)
      if config and config.ActivityType == activityType then
        return true
      end
    end
  end
  return false
end

function ActivityManager:IsGotCompensate(activityType)
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    local config = ActivityDataUtils.GetConfig(tid) or {}
    if config and config.ActivityType == activityType and activityData.unlockReward then
      return true
    end
  end
end

function ActivityManager:GetOpeningActivityByType(activityType)
  if not self.model.activityTidMap then
    return
  end
  local now = TimeUtils.GetServerTime()
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    local config = ActivityDataUtils.GetConfig(tid) or {}
    if config.ActivityType == activityType and now >= activityData.startTime and now < activityData.endTime then
      return activityData, config
    end
  end
end

function ActivityManager:GetMultiDropActivityList()
  if not self.model.activityTidMap then
    return
  end
  local list = {}
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    if activityData then
      local config = ActivityDataUtils.GetConfig(tid)
      if config and config.ActivityType == ActivityDefine.ActivityType.DoubleOutput then
        table.insert(list, activityData)
      end
    end
  end
  return list
end

function ActivityManager:IsActivityStageGroup(stageGroupTid)
  if not self.model.activityTidMap then
    return false
  end
  local stageGroupType = CopyDataUtils.GetStageGroupType(stageGroupTid)
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    if activityData then
      local config = ActivityDataUtils.GetConfig(tid)
      if config and config.ActivityPara1 and config.ActivityPara1[1] == stageGroupType then
        return true
      end
    end
  end
  return false
end

function ActivityManager:GetBonusCardActivityList(stageGroupTid)
  if not self.model.activityTidMap then
    return
  end
  local stageGroupType = CopyDataUtils.GetStageGroupType(stageGroupTid)
  local list = {}
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    if activityData then
      local config = ActivityDataUtils.GetConfig(tid)
      if config and config.ActivityPara5 and config.ActivityPara1[1] == stageGroupType then
        table.insert(list, activityData)
      end
    end
  end
  return list
end

function ActivityManager:CheckDoubleOutputEffect(stageGroupTid)
  if not stageGroupTid then
    return false
  end
  local activityData = self:GetMultiDropActivity(stageGroupTid)
  if not activityData then
    return false
  end
  local config = ActivityDataUtils.GetConfig(activityData.activityTid)
  if not config or not config.ActivityPara1 then
    return
  end
  for _, _stageGroupTid in ipairs(config.ActivityPara1) do
    if _stageGroupTid and _stageGroupTid == stageGroupTid then
      local data = activityData
      return data and data.count > 0
    end
  end
  return false
end

function ActivityManager:GetMultiDropActivityText(stageGroupTid)
  if not self:CheckDoubleOutputEffect(stageGroupTid) then
    return ""
  end
  do return LT.Text end
  return LT.Text, "ActivityExtraDropTimes", stageGroupTid
end

function ActivityManager:GetMultiDropActivityCount(stageGroupTid)
  local activityDataList = ActivityManager.Instance:GetMultiDropActivityList()
  if not activityDataList then
    return
  end
  local leftCount = 0
  local totalCount = 0
  for _, activityData in ipairs(activityDataList) do
    local config = ActivityDataUtils.GetConfig(activityData.activityTid)
    if not config or not config.ActivityPara1 then
    else
      for _, _stageGroupTid in pairs(config.ActivityPara1) do
        if _stageGroupTid == stageGroupTid then
          local data = activityData.data
          local cnt = data and data.count or 0
          leftCount = leftCount + cnt
          local _totalCnt = ActivityDataUtils.GetDoubleOutputTotalCount(activityData.activityTid)
          totalCount = totalCount + _totalCnt
        end
      end
    end
  end
  return leftCount, totalCount
end

function ActivityManager:_OnActivityDataChanged(childBinder, activityData, oldActivityData, activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return
  end
  local oldBannerTidList = ActivityDataUtils.GetMainPanelBannerActivityTidList()
  local taskList = activityData and activityData.taskList
  if taskList then
    for _, taskInfo in pairs(taskList) do
      TaskDataUtils.UpdateTask(taskInfo)
    end
  end
  local activityBaseData = activityData and activityData.base
  local now = TimeUtils.GetServerTime()
  local isReachHideTime = false
  if activityBaseData and activityBaseData.hideTs and activityBaseData.hideTs > 0 then
    isReachHideTime = now >= activityBaseData.hideTs
  end
  if oldActivityData then
    local oldActivityBaseData = oldActivityData and oldActivityData.base
    local notRunningActivity = activityBaseData and activityBaseData.state ~= ActivityDefine.ActivityState.Running
    if not activityBaseData or notRunningActivity or isReachHideTime then
      self.model:RemoveActivity(oldActivityBaseData.tid)
    end
  end
  if activityData and activityBaseData then
    if self.model:IsActivityDataExist(activityBaseData.tid) then
      self.model:UpdateActivityData(activityData)
      self:_DispatchActivityDisplayChangedIfBannerTidListChanged(oldBannerTidList)
      return
    end
    if activityBaseData.state == ActivityDefine.ActivityState.Running and not isReachHideTime then
      if 0 == config.ActivityDisplay then
        self.model:SetOpenningNotShowActivity(activityTid, activityData)
        RedPointDataUtils.ReqRemoveData(RedTypeDefine.RedType.ActivityServer, RedPointDataUtils.RedAttrType.IsNew, activityTid)
        RedPointDataUtils.ReqRemoveData(RedTypeDefine.RedType.ActivityServer, RedPointDataUtils.RedAttrType.Red, activityTid)
      end
      local openCondition = self.model:CheckCondition(activityData)
      local isActivityAlwaysShow = ActivityDataUtils.IsActivityAlwaysShow(activityTid)
      local isHideOfAct2_5 = ActivityDataUtils.ShouldHideTwoAndAHalfAnniversaryRaidNeverJoined(activityData)
      if not isHideOfAct2_5 and (isActivityAlwaysShow or openCondition) then
        self.model:AddActivity(activityTid, activityData)
      elseif not isHideOfAct2_5 then
        self.model:SetNotOpenActivity(activityTid, activityData)
      end
    end
  end
  self:_DispatchActivityDisplayChangedIfBannerTidListChanged(oldBannerTidList)
end

function ActivityManager:_DispatchActivityDisplayChangedIfBannerTidListChanged(oldTidList)
  local newTidList = ActivityDataUtils.GetMainPanelBannerActivityTidList()
  if #oldTidList ~= #newTidList then
    EventMgr.Instance.OnActivityDisplayChanged:Dispatch()
    return
  end
  for i = 1, #oldTidList do
    if oldTidList[i] ~= newTidList[i] then
      EventMgr.Instance.OnActivityDisplayChanged:Dispatch()
      return
    end
  end
end

function ActivityManager:_IsExtendShowActivity(activityTid)
  return 44273 == activityTid
end

function ActivityManager:_OnPlayerLevelChanged(_, currPlayerLevel, oldLevel)
  if currPlayerLevel and oldLevel and oldLevel < currPlayerLevel then
    self.model:UpdateNotOpenActivity()
  end
end

function ActivityManager:_OnPlayerDayExpChanged()
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    if activityData then
      local activityType = ActivityDataUtils.GetType(activityData.activityTid)
      if activityType == ActivityDefine.ActivityType.DoubleExp then
        self.model:UpdateFinishState(activityData.activityTid)
      end
    end
  end
end

function ActivityManager:CheckHideActivity()
  local now = TimeUtils.GetServerTime()
  local removeList = {}
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    if activityData then
      local hideTs = activityData.base.hideTs
      if hideTs > 0 and now >= hideTs then
        table.insert(removeList, activityData.activityTid)
      end
    end
  end
  for _, activityTid in ipairs(removeList) do
    self.model:RemoveActivity(activityTid)
  end
end

function ActivityManager:HasNotOpenSubplotActivity()
  if not self.model then
    return false
  end
  do return self.model.HasNotOpenSubplotActivity end
  return self.model.HasNotOpenSubplotActivity, self.model
end

function ActivityManager:GetNotOpenSubplotActivities()
  if not self.model then
    return {}
  end
  do return self.model.GetNotOpenSubplotActivities end
  return self.model.GetNotOpenSubplotActivities, self.model
end

function ActivityManager:IsActivityOpenedByTid(activityTid)
  if not (self.model and activityTid) or 0 == activityTid then
    return false
  end
  local activityData = self.model:GetActivityDataClient(activityTid)
  if not activityData then
    return false
  end
  if ActivityDataUtils.ShouldHideTwoAndAHalfAnniversaryRaidNeverJoined(activityData) then
    return false
  end
  if self:IsActivityOpenedAboutTimeType(activityData) then
    return true
  end
  return false
end

function ActivityManager:GetActivityData(activityTid)
  if not self.model then
    return nil
  end
  do return self.model.GetActivityDataClient, self.model end
  return self.model.GetActivityDataClient, self.model, activityTid
end

function ActivityManager:GetActivityDataByType(targetActivityType)
  if not targetActivityType then
    return nil
  end
  for tid in pairs(self.model.activityTidMap) do
    local activityData = ActivityDataUtils.GetActivityData(tid)
    local activityType = ActivityDataUtils.GetType(activityData.activityTid)
    if targetActivityType == activityType then
      return self:GetActivityData(activityData.activityTid)
    end
  end
  return nil
end

function ActivityManager:GetActivityDataByField(field, activityTid)
  if not field or not activityTid then
    return nil
  end
  local activityData = self:GetActivityData(activityTid)
  if not activityData then
    return nil
  end
  return activityData[field]
end

function ActivityManager:IsActivityOpenedAboutTimeType(activityData)
  local timeType = ActivityDataUtils.GetTimeType(activityData.activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    return true
  else
    local now = TimeUtils.GetServerTime()
    local isStarted = now >= activityData.startTime
    local isNotEnd = now < activityData.endTime
    if 0 == activityData.endTime then
      isNotEnd = true
    end
    if isStarted and isNotEnd then
      return true
    end
  end
  return false
end

function ActivityManager:IsActivityBannerOpenedAboutTimeType(activityData)
  local activityTid = activityData.activityTid
  local activityCfg = ActivityDataUtils.GetConfig(activityTid)
  local hideTs = activityData.base.hideTs or 0
  local now = TimeUtils.GetServerTime()
  if hideTs > 0 and hideTs < now then
    return false
  end
  if activityCfg.ActivityType == ActivityDefine.ActivityType.TwoAnniversaryWorldBossActivity then
    return true
  end
  local timeType = ActivityDataUtils.GetTimeType(activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    return true
  else
    local startTime = activityData.startTime
    local endTime = activityCfg and activityCfg.ActivityStageEndTime or activityData.endTime
    if now >= startTime and now < endTime then
      return true
    end
  end
  return false
end

function ActivityManager:IsActivityFinishedByTid(activityTid)
  if not (self.model and activityTid) or 0 == activityTid then
    return true
  end
  local activityData = self.model:GetActivityDataClient(activityTid)
  if not activityData then
    return true
  end
  local timeType = ActivityDataUtils.GetTimeType(activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    return false
  else
    if not activityData.finishTime or activityData.finishTime <= 0 then
      return false
    end
    local now = TimeUtils.GetServerTime()
    if now < activityData.startTime then
      return false
    end
    if now >= activityData.finishTime then
      return true
    end
  end
  return false
end

function ActivityManager:HasOpeningSubplotActivity(stageGroupTid)
  if not self.model then
    return false
  end
  do return self.model.HasOpeningSubplotActivity, self.model end
  return self.model.HasOpeningSubplotActivity, self.model, stageGroupTid
end

function ActivityManager:GetOpeningSubplotActivity(stageGroupTid)
  if not self.model then
    return false
  end
  do return self.model.GetOpeningSubplotActivity, self.model end
  return self.model.GetOpeningSubplotActivity, self.model, stageGroupTid
end

function ActivityManager:HasOpeningAbyssActivity()
  if not self.model then
    return false
  end
  do return self.model.HasOpeningAbyssActivity end
  return self.model.HasOpeningAbyssActivity, self.model
end

function ActivityManager:GetCurRoundActivityEndTime(time, activityType)
  if not self.model then
    return nil
  end
  do return self.model.GetCurRoundActivityEndTime, self.model, time end
  return self.model.GetCurRoundActivityEndTime, self.model, time, activityType
end

function ActivityManager:ResetData()
  if self.model then
    self.model:ResetData()
  end
end

function ActivityManager:OnDestroy()
end

return ActivityManager
