local function createActivityModelState()
  local state = {}
  
  state.activityTidMap = {}
  state.displayTidMap = {}
  state.notOpenTidMap = {}
  state.openningNotShowTidMap = {}
  state.sortedTidList = {}
  state.trialTidList = {}
  state.selectedTrialTid = nil
  return state
end

local function createActivityModelViews(_)
  local views = {}
  
  function views:GetActivityDataClient(tid)
    if not tid then
      return
    end
    do return ActivityDataUtils.GetActivityData end
    return ActivityDataUtils.GetActivityData, tid
  end
  
  function views:GetDisplayActivityTidMap()
    return self.displayTidMap
  end
  
  function views:CheckCondition(activityData)
    do return ActivityDataUtils.CheckActivityDataCondition end
    return ActivityDataUtils.CheckActivityDataCondition, activityData
  end
  
  function views:GetNotOpenSubplotActivities()
    local map = {}
    local activityDatas = DataCenter.activityData.activityDatas
    for tid, activityData in pairs(activityDatas) do
      if activityData then
        local activityType = ActivityDataUtils.GetType(tid)
        local isSubplotActivity = activityType == ActivityDefine.ActivityType.SubPlot
        local activityBaseData = activityData.base or {}
        local serverNotOpen = activityBaseData.state == ActivityDefine.ActivityState.NotOpen
        if isSubplotActivity and serverNotOpen then
          local config = ActivityDataUtils.GetConfig(tid)
          local groupTids = config and config.ActivityPara1 or {}
          for _, groupTid in ipairs(groupTids) do
            map[groupTid] = true
          end
        end
      end
    end
    return map
  end
  
  function views:GetGamePassports()
    local list = {}
    local now = TimeUtils.GetServerTime()
    local passportType = ActivityDefine.ActivityType.TaskList
    local passportSysType = "BattlePassActivity"
    local preOrderType = ActivityDefine.ActivityType.PreOrder
    local newPreOrderType = ActivityDefine.ActivityType.NewPreOrder
    for tid in pairs(self.activityTidMap) do
      local activityData = ActivityDataUtils.GetActivityData(tid)
      if 0 ~= activityData.endTime and now >= activityData.endTime then
      elseif activityData.base.hideTs and 0 ~= activityData.base.hideTs then
      else
        local config = ActivityDataUtils.GetConfig(activityData.activityTid)
        if not config then
        elseif config.WhereShow ~= ActivityDefine.WhereShow.GamePassport then
        else
          local type = ActivityDataUtils.GetType(activityData.activityTid)
          local sysType = ActivityDataUtils.GetConfigByField("ActivitySystemType", activityData.activityTid)
          if passportType == type and passportSysType == sysType then
            table.insert(list, activityData)
          elseif preOrderType == type or newPreOrderType == type then
            table.insert(list, activityData)
          end
        end
      end
    end
    table.sort(list, function(a, b)
      local cfg1 = ActivityDataUtils.GetConfig(a.activityTid)
      local cfg2 = ActivityDataUtils.GetConfig(b.activityTid)
      return cfg1.BaseSortID < cfg2.BaseSortID
    end)
    return list
  end
  
  function views:GetActivityListByTypeAndSysType(activityTypeList, sysTypeList, isSort)
    local list = {}
    if type(activityTypeList) ~= "table" then
      activityTypeList = {activityTypeList}
    end
    if type(sysTypeList) ~= "table" and nil ~= sysTypeList then
      sysTypeList = {sysTypeList}
    end
    local now = TimeUtils.GetServerTime()
    for tid in pairs(self.activityTidMap) do
      local activityData = ActivityDataUtils.GetActivityData(tid)
      local cfg = ActivityDataUtils.GetConfig(activityData.activityTid)
      if 0 ~= activityData.endTime and now >= activityData.endTime then
      elseif activityData.base.hideTs and 0 ~= activityData.base.hideTs and now > activityData.base.hideTs then
      else
        local isAllGot = #(cfg.ActivityPara1 or {}) > 0
        for _, taskId in ipairs(cfg.ActivityPara1 or {}) do
          if not DT.Task[taskId] then
            isAllGot = false
            break
          end
          if not TaskDataUtils.TaskFinshAndGetedAward(taskId) then
            isAllGot = false
            break
          end
        end
        if isAllGot then
        elseif table.contains(activityTypeList, cfg.ActivityType) then
          if not sysTypeList then
            table.insert(list, activityData)
          elseif table.contains(sysTypeList, cfg.ActivitySystemType) then
            table.insert(list, activityData)
          end
        end
      end
    end
    if isSort then
      table.sort(list, function(a, b)
        local cfg1 = ActivityDataUtils.GetConfig(a.activityTid)
        local cfg2 = ActivityDataUtils.GetConfig(b.activityTid)
        if not cfg1.ShowAwaker and not cfg2.ShowAwaker then
          return cfg1.BaseSortID < cfg2.BaseSortID
        end
        if a.endTime and b.endTime and a.endTime ~= b.endTime then
          return a.endTime < b.endTime
        end
        return cfg1.BaseSortID < cfg2.BaseSortID
      end)
    end
    return list
  end
  
  function views:GetTimeLimitGiftActivities()
    local activityTypeList = {
      ActivityDefine.ActivityType.TaskList,
      ActivityDefine.ActivityType.FirstTimeLimitedSale
    }
    local sysTypeList = {
      "TriggerOnceEvent",
      "PeriodTrigger",
      "LimitedTimeSale"
    }
    do return self.GetActivityListByTypeAndSysType, self, activityTypeList, sysTypeList end
    return self.GetActivityListByTypeAndSysType, self, activityTypeList, sysTypeList, true
  end
  
  function views:GetPopupLimitGiftActivityMap()
    local rst = {}
    local list = self:GetTimeLimitGiftActivities()
    if 0 == #list then
      return rst
    end
    for _, act in ipairs(list) do
      local actId = act.activityTid
      rst[actId] = act
    end
    return rst
  end
  
  function views:GetPopupLimitGiftActivityList()
    local map = self:GetPopupLimitGiftActivityMap()
    local list = table.values(map)
    table.sort(list, function(a, b)
      return a.endTime < b.endTime
    end)
    return list
  end
  
  function views:GetOpenningNotShowActivity(activityType)
    local list = {}
    for activityTid in pairs(self.openningNotShowTidMap) do
      local activityData = ActivityDataUtils.GetActivityData(activityTid)
      local config = ActivityDataUtils.GetConfig(activityTid)
      if config and config.ActivityType == activityType then
        table.insert(list, activityData)
      end
    end
    return list
  end
  
  function views:HasNotOpenSubplotActivity()
    local map = self:GetNotOpenSubplotActivities()
    return table.next(map) ~= nil
  end
  
  function views:GetOpeningSubplotActivity(stageGroupTid)
    if not stageGroupTid then
      return
    end
    local now = TimeUtils.GetServerTime()
    for tid in pairs(self.activityTidMap) do
      local activityData = ActivityDataUtils.GetActivityData(tid)
      local activityType = ActivityDataUtils.GetType(activityData.activityTid)
      if activityType == ActivityDefine.ActivityType.SubPlot then
        local isUnlockFreeStageGroupTid = table.contains(DT.GetOriginalConstant("StageGroupUnlockFeature"), stageGroupTid)
        if isUnlockFreeStageGroupTid or now >= activityData.startTime and now < activityData.endTime then
          local config = ActivityDataUtils.GetConfig(activityData.activityTid)
          if config and config.ActivityPara1 then
            for _, groupTid in ipairs(config.ActivityPara1) do
              if stageGroupTid == groupTid then
                return activityData
              end
            end
          end
        end
      end
    end
    return
  end
  
  function views:IsActivityDataExist(activityTid)
    return self.activityTidMap[activityTid] ~= nil
  end
  
  function views:IsNotOpenActivityDataExist(activityTid)
    return self.notOpenTidMap[activityTid]
  end
  
  function views:HasOpeningSubplotActivity(stageGroupTid)
    local activityData = self:GetOpeningSubplotActivity(stageGroupTid)
    return nil ~= activityData
  end
  
  function views:IsTrialActivityTid(activityTid)
    do return table.contains, self.trialTidList end
    return table.contains, self.trialTidList, activityTid
  end
  
  function views:HasOpeningAbyssActivity()
    local now = TimeUtils.GetServerTime()
    local openningAbyssActivityList = self:GetOpenningNotShowActivity(ActivityDefine.ActivityType.Abyss)
    if openningAbyssActivityList then
      for _, activityData in ipairs(openningAbyssActivityList) do
        local activityBaseData = activityData and activityData.base
        if not (activityBaseData and activityBaseData.startTime) or not activityBaseData.endTime then
        elseif now >= activityBaseData.startTime and now < activityBaseData.endTime then
          return true
        end
      end
    end
    return false
  end
  
  function views:GetCurRoundActivityEndTime(time, activityType)
    local activityList = self.activityTidMap
    local nearestStartTime
    for tid in pairs(activityList) do
      local activityData = ActivityDataUtils.GetActivityData(tid)
      local config = ActivityDataUtils.GetConfig(activityData.activityTid)
      if not config or config.ActivityType ~= activityType then
      elseif not activityData.startTime or not activityData.endTime then
      else
        local endTime = activityData.finishTime or activityData.endTime
        if time >= activityData.startTime and time < endTime then
          return endTime
        end
        if time < activityData.startTime and (not nearestStartTime or nearestStartTime > activityData.startTime) then
          nearestStartTime = activityData.startTime
        end
      end
    end
    return nearestStartTime
  end
  
  function views:GetTrialTidList()
    local rst = {}
    local now = TimeUtils.GetServerTime()
    for tid, _ in pairs(self.displayTidMap) do
      local activityData = ActivityDataUtils.GetActivityData(tid)
      local activityCfg = ActivityDataUtils.GetConfig(tid)
      if activityData then
        local endTime = activityData.endTime or math.huge
        if (0 == endTime or now < endTime) and activityCfg.ActivityType == ActivityDefine.ActivityType.AwakerTrial then
          table.insert(rst, tid)
        end
      end
    end
    return rst
  end
  
  return views
end

local function createActivityModelActions()
  local actions = {}
  
  function actions:AddActivity(activityTid, needSort)
    self.activityTidMap[activityTid] = true
    local activityData = ActivityDataUtils.GetActivityData(activityTid)
    local config = ActivityDataUtils.GetConfig(activityTid)
    if 0 ~= config.ActivityDisplay then
      local hasFinish = ActivityDataUtils.CheckActivityFinishState(activityTid)
      activityData.hasFinish = hasFinish
      self.displayTidMap[activityTid] = activityData
    end
    if true == needSort or nil == needSort then
      self:SortActivityList()
    end
  end
  
  function actions:SetNotOpenActivity(activityTid)
    self.notOpenTidMap[activityTid] = true
  end
  
  function actions:SetOpenningNotShowActivity(activityTid)
    self.openningNotShowTidMap[activityTid] = true
  end
  
  function actions:SetSelectedTrialTid(trialTid)
    self.selectedTrialTid = trialTid
  end
  
  function actions:UpdateNotOpenActivity()
    if not self.notOpenTidMap then
      return
    end
    EventMgr.Instance.OnActivityDisplayChanged:Dispatch()
    local willOpenList = {}
    local isLevelOk, isStageOk = false, false
    for activityTid in pairs(self.notOpenTidMap) do
      local config = ActivityDataUtils.GetConfig(activityTid)
      if config.ActivityLevelCondition then
        isLevelOk = PlayerDataUtils.GetLevel() >= config.ActivityLevelCondition
      else
        isLevelOk = true
      end
      if config.ActivityStageCondition then
        local stageData = MainCopyDataUtils.GetStageData(config.ActivityStageCondition)
        isStageOk = stageData and stageData.firstRewardDraw
      else
        isStageOk = true
      end
      if isLevelOk and isStageOk then
        table.insert(willOpenList, activityTid)
      end
    end
    if #willOpenList > 0 then
      ActivityRedUtils.UpdateActivityRed(willOpenList)
      for _, activityTid in ipairs(willOpenList) do
        self:AddActivity(activityTid, false)
        self.notOpenTidMap[activityTid] = nil
      end
    end
    self:SortActivityList()
  end
  
  function actions:RemoveActivity(activityTid)
    if not activityTid then
      return
    end
    self.activityTidMap[activityTid] = nil
    self.displayTidMap[activityTid] = nil
    self.notOpenTidMap[activityTid] = nil
    self.openningNotShowTidMap[activityTid] = nil
    self:SortActivityList()
  end
  
  function actions:SortActivityList()
    self.trialTidList = {}
    local list = {}
    local now = TimeUtils.GetServerTime()
    for tid, _ in pairs(self.displayTidMap) do
      local activityData = ActivityDataUtils.GetActivityData(tid)
      local activityCfg = ActivityDataUtils.GetConfig(tid)
      if activityData then
        local endTime = activityData.endTime or math.huge
        if 0 == endTime or now < endTime then
          if activityCfg.ActivityType == ActivityDefine.ActivityType.AwakerTrial then
            table.insert(self.trialTidList, tid)
          else
            table.insert(list, tid)
          end
        end
      end
    end
    table.sort(self.trialTidList, function(tidA, tidB)
      local aCfg = ActivityDataUtils.GetConfig(tidA)
      local bCfg = ActivityDataUtils.GetConfig(tidB)
      if aCfg.ActivityPara2 == bCfg.ActivityPara2 then
        return aCfg.BaseSortID < bCfg.BaseSortID
      else
        return aCfg.ActivityPara2 < bCfg.ActivityPara2
      end
    end)
    if self.trialTidList[1] then
      self:SetSelectedTrialTid(self.trialTidList[1])
      table.insert(list, self.trialTidList[1])
    end
    ActivityTrialUIUtils.InitTrialTab(nil, self.trialTidList)
    table.sort(list, function(tidA, tidB)
      local finishedA = ActivityTrialUIUtils.GetActivityHasFinish(tidA) and 1 or 0
      local finishedB = ActivityTrialUIUtils.GetActivityHasFinish(tidB) and 1 or 0
      if finishedA == finishedB then
        local configA = ActivityDataUtils.GetConfig(tidA)
        local configB = ActivityDataUtils.GetConfig(tidB)
        return configA.BaseSortID < configB.BaseSortID
      end
      return finishedA < finishedB
    end)
    self.sortedTidList = list
  end
  
  function actions:GetFirstDisplayActivityTid()
    return self.sortedTidList[1]
  end
  
  function actions:IsDisplayActivityTid(activityTid)
    return self.displayTidMap[activityTid] ~= nil
  end
  
  function actions:UpdateActivityData(activityData)
    local activityBaseData = activityData and activityData.base
    if activityData and activityBaseData then
      local hasFinish = ActivityDataUtils.CheckActivityFinishState(activityData.activityTid)
      activityData.hasFinish = hasFinish
    end
  end
  
  function actions:UpdateFinishState(activityTid)
    local activityData = ActivityDataUtils.GetActivityData(activityTid)
    local hasFinish = ActivityDataUtils.CheckActivityFinishState(activityTid)
    activityData.hasFinish = hasFinish
    if hasFinish then
      GlobalDispatcher:Dispatch(NotifyId.OnActivityFinished, activityTid)
    end
  end
  
  function actions:SetActUnlockPassport(activityData, isBuyPassport)
    activityData.isUnlockExtraTask = isBuyPassport
  end
  
  function actions:ResetData()
    self.notOpenTidMap = {}
    self.activityTidMap = {}
  end
  
  return actions
end

local function onSetup(_, _)
end

local ActivityModel = Vue.model("ActivityModel", createActivityModelState):views(createActivityModelViews):actions(createActivityModelActions):setup(onSetup)
return ActivityModel
