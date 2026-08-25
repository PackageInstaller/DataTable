local ActivityRAIDComp, Super = System.NewClass("ActivityRAIDComp", ActivityMagicStoryComp)
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)

function ActivityRAIDComp:ctor(uiNode, activityTid, model)
  self.ui = UI_Events_Panel_RAIDResource(uiNode)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
end

function ActivityRAIDComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self:BindActivityName()
  self:_BindActivityTimer()
  self:_SetActivityPlot()
  self:BindLockState()
  self:BindProgress()
  self:BindWorldRaidProgress()
  self:ReqStageGroupInfo()
  self:BindButtons()
  self:BindTaskRewardEntry()
  self:TryReportActivityClientJoin()
  binder:BindEvent(EventMgr.Instance.OnActivityDataSynced, System.fn(self, self._OnActivityDataSyncedRefreshRaidKill))
  binder:BindEvent(EventMgr.Instance.OnActivityWorldBossKillSynced, System.fn(self, self._OnActivityWorldBossKillSynced))
end

function ActivityRAIDComp:TryReportActivityClientJoin()
  if ActivityDataUtils.GetType(self.activityTid) ~= ActivityDefine.ActivityType.TwoAndAHalfAnniversaryRAIDActiviity then
    return
  end
  local cfg = self.activityConfig or ActivityDataUtils.GetConfig(self.activityTid)
  local activityEndTime = cfg and cfg.ActivityEndTime or 0
  if activityEndTime > 0 and activityEndTime < TimeUtils.GetServerTime() then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "ActivityClientJoinRequest", nil, nil, self.activityTid)
end

function ActivityRAIDComp:BindActivityName()
  self.binder:SetText(self.ui.Text_C_Topic, ActivityDataUtils.GetActivityName(self.activityTid))
end

function ActivityRAIDComp:BindLockState()
  self.binder:SetActive(self.ui.Group_Locked, false)
  self.binder:SetActive(self.ui.Group_UnLock, true)
end

function ActivityRAIDComp:_BindActivityTimer()
  if not (self.activityData and self.binder and self.ui) or not self.ui.Text_Time then
    Logger.Warn("_BindActivityTimer wrong activityData:%s binder:%s Text_Time:%s", self.activityData, self.binder, self.ui and self.ui.Text_Time)
    return
  end
  local timeType = ActivityDataUtils.GetTimeType(self.activityData.activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
    return
  end
  self:_ClearTimer()
  self:_TimerFixedUpdate()
  self.activityTimer = self.binder:BindTimer(1, -1, System.fn(self, self._TimerFixedUpdate), nil)
end

function ActivityRAIDComp:_TimerFixedUpdate()
  local activityData = ActivityDataUtils.GetActivityData(self.activityTid) or self.activityData
  self.activityData = activityData
  self.binder:SetActive(self.ui.Text_Time, true)
  self.binder:SetText(self.ui.Text_Time, ActivityRaidUtils.GetActivityTimeText(activityData, self.activityConfig))
  local endTime = activityData and activityData.endTime
  if endTime and endTime > 0 and endTime < TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime()) then
    self:_ClearTimer()
  end
end

function ActivityRAIDComp:BindProgress()
  self.binder:BindToRaw(function()
    self:RefreshProgressText()
  end, function()
    do return self.GetRaidAchievementProgress end
    return self.GetRaidAchievementProgress, self
  end)
  self.binder:BindComponent(UICompRedDotNewVue(self.ui.NewTag_Challenge, RedDotDefine.DynamicRedDotID.ActivityWorldBossStageGroupEntry, {
    activityTid = self.activityTid
  }))
end

function ActivityRAIDComp:BindWorldRaidProgress()
  if not self.ui.UI_Events_Item_RAIDProgressGroup then
    return
  end
  self._raidWorldMilestoneRows = nil
  self._progressGroupRes = UI_Events_Item_RAIDProgressGroupResource(self.ui.UI_Events_Item_RAIDProgressGroup)
  self._raidMilestoneReady = false
  self.binder:BindToRaw(function(cbinder)
    self:_EnsureRaidMilestoneCells()
    self:_ApplyWorldRaidProgressVisual(cbinder, self:GetWorldRaidKillTotal())
  end, function()
    do return ActivityRaidUtils.GetWorldProgressRawKey, self.activityTid end
    return ActivityRaidUtils.GetWorldProgressRawKey, self.activityTid, self.activityConfig
  end)
  self.binder:BindTimer(5, -1, System.fn(self, self._OnWorldRaidProgressTimerTick), nil)
end

function ActivityRAIDComp:_OnWorldRaidProgressTimerTick()
  local totalCount = self:GetWorldRaidKillTotal()
  self:_EnsureRaidMilestoneCells()
  self:_ApplyWorldRaidProgressVisual(self.binder, totalCount)
end

function ActivityRAIDComp:GetWorldRaidKillTotal()
  do return ActivityRaidUtils.ResolveWorldKillDisplayCount, self.activityTid end
  return ActivityRaidUtils.ResolveWorldKillDisplayCount, self.activityTid, self.activityConfig
end

function ActivityRAIDComp:_OnWorldBossKillCountReady()
  self:_EnsureRaidMilestoneCells()
  self:_ApplyWorldRaidProgressVisual(self.binder, self:GetWorldRaidKillTotal())
end

function ActivityRAIDComp:_OnActivityDataSyncedRefreshRaidKill(syncMap)
  if not self.activityTid or not syncMap then
    return
  end
  if not syncMap[self.activityTid] and not syncMap[tostring(self.activityTid)] then
    return
  end
  self:_OnWorldBossKillCountReady()
end

function ActivityRAIDComp:_OnActivityWorldBossKillSynced(activityTid)
  if not self.activityTid or not activityTid then
    return
  end
  if activityTid ~= self.activityTid and activityTid ~= tonumber(self.activityTid) then
    return
  end
  self:_OnWorldBossKillCountReady()
end

function ActivityRAIDComp:_GetRaidWorldMilestoneRows()
  if self._raidWorldMilestoneRows == nil then
    self._raidWorldMilestoneRows = ActivityRaidUtils.ResolveWorldMilestoneRows(self.activityConfig)
  end
  return self._raidWorldMilestoneRows
end

function ActivityRAIDComp:_GetRaidWorldProgressCap()
  do return ActivityRaidUtils.GetWorldProgressCap, self:_GetRaidWorldMilestoneRows() end
  return ActivityRaidUtils.GetWorldProgressCap, self:_GetRaidWorldMilestoneRows()
end

function ActivityRAIDComp:_EnsureRaidMilestoneCells()
  if self._raidMilestoneReady then
    return
  end
  if not self._progressGroupRes then
    return
  end
  local template = self._progressGroupRes.UI_Events_Item_RAIDProgress
  local groupGo = self._progressGroupRes.Group_ProgressCon
  if not template or not groupGo then
    return
  end
  local parentTf = groupGo.transform
  local targetCount = #self:_GetRaidWorldMilestoneRows()
  while targetCount > parentTf.childCount do
    self.binder:Instantiate(template, parentTf)
  end
  self._raidMilestoneReady = true
end

function ActivityRAIDComp:_ApplyWorldRaidProgressVisual(cbinder, totalCount)
  if not self._progressGroupRes or not cbinder then
    return
  end
  totalCount = totalCount or 0
  local bar = self._progressGroupRes.Image_ProgressBar
  if bar then
    local fillAmount = ActivityRaidUtils.GetWorldMilestoneFillAmount(totalCount, self:_GetRaidWorldMilestoneRows())
    cbinder:SetImageFillAmount(bar, fillAmount)
  end
  local textKill = self._progressGroupRes.Text_C_Kill or self._progressGroupRes.Text_CurProgress
  if textKill then
    cbinder:SetText(textKill, tostring(totalCount))
  end
  local groupGo = self._progressGroupRes.Group_ProgressCon
  if not groupGo then
    return
  end
  local parentTf = groupGo.transform
  local rows = self:_GetRaidWorldMilestoneRows()
  for i = 0, parentTf.childCount - 1 do
    parentTf:GetChild(i).gameObject:SetActive(i < #rows)
  end
  for idx, row in ipairs(rows) do
    if idx - 1 >= parentTf.childCount then
      break
    end
    local childGo = parentTf:GetChild(idx - 1).gameObject
    local itemRes = UI_Events_Item_RAIDProgressResource(childGo)
    local milestone = row.threshold
    if itemRes.Text_Count then
      cbinder:SetText(itemRes.Text_Count, ActivityRaidUtils.FormatWorldCount(milestone))
    end
    local reached = totalCount >= milestone
    if itemRes.Group_High then
      cbinder:SetActive(itemRes.Group_High, reached)
    end
    if itemRes.Group_Normal then
      cbinder:SetActive(itemRes.Group_Normal, not reached)
    end
  end
end

function ActivityRAIDComp:RefreshProgressText()
  local finishCount, totalCount = self:GetRaidAchievementProgress()
  self.binder:SetText(self.ui.Text_AchieveProgress, string.format("%d/%d", finishCount, totalCount))
  local isFinished = false
  self.binder:SetActive(self.ui.Group_Finish, isFinished)
  self.binder:SetActive(self.ui.Group_UnLock, not isFinished)
end

function ActivityRAIDComp:BindButtons()
  self.binder:BindButtonClick(self.ui.Btn_Challenge, System.fn(self, self.OnClickChallenge))
  self.binder:BindButtonClick(self.ui.Btn_Rank, System.fn(self, self.OnClickBtnRank))
end

function ActivityRAIDComp:_CollectRaidAchievementParentTaskIds()
  local para3 = self.activityConfig and self.activityConfig.ActivityPara3
  if not para3 or 0 == #para3 then
    return {}
  end
  local ordered = {}
  local seen = {}
  for _, tid in ipairs(para3) do
    local cfg = DT.Task[tid]
    if cfg then
      if cfg.TaskType == "TaskType_Activity_Main" then
        if not seen[tid] then
          seen[tid] = true
          table.insert(ordered, tid)
        end
      elseif cfg.BelongTaskGroup then
        local gid = cfg.BelongTaskGroup
        if not seen[gid] then
          seen[gid] = true
          table.insert(ordered, gid)
        end
      end
    end
  end
  return ordered
end

function ActivityRAIDComp:BindTaskRewardEntry()
  if not self.ui or not self.ui.Btn_Reward then
    return
  end
  local para3 = self.activityConfig and self.activityConfig.ActivityPara3
  if not para3 or 0 == #para3 then
    self.binder:SetActive(self.ui.Btn_Reward, false)
    if self.ui.Red_Achieve then
      self.binder:SetActive(self.ui.Red_Achieve, false)
    end
    return
  end
  self._raidAchievementParentTaskIds = self:_CollectRaidAchievementParentTaskIds()
  if not self._raidAchievementParentTaskIds or 0 == #self._raidAchievementParentTaskIds then
    self.binder:SetActive(self.ui.Btn_Reward, false)
    if self.ui.Red_Achieve then
      self.binder:SetActive(self.ui.Red_Achieve, false)
    end
    return
  end
  self.binder:BindToVisible(self.ui.Btn_Reward, function()
    local taskList = self.activityData and self.activityData.taskList
    return taskList and next(taskList) ~= nil
  end)
  self.binder:BindZ1Button(self.ui.Btn_Reward, System.fn(self, self._OnClickTaskReward))
  if self.ui.Red_Achieve then
    self.binder:BindComponent(NewRedCom(self.ui.Red_Achieve)):BindActivityTask(self.activityData)
  end
end

function ActivityRAIDComp:_OnClickTaskReward()
  local taskList = self.activityData and self.activityData.taskList
  if not taskList or next(taskList) == nil then
    return
  end
  UIManager.Instance:Reopen(Urls.ActivityAchievementPanel, self.activityData, self._raidAchievementParentTaskIds, taskList, {
    title = LT.Text("StageRewardsTitle")
  })
end

function ActivityRAIDComp:_EnsureRaidPara3LeafTaskTids()
  if self._raidPara3LeafTaskTids ~= nil then
    return
  end
  self._raidPara3LeafTaskTids = {}
  local para3 = self.activityConfig and self.activityConfig.ActivityPara3
  if not para3 or 0 == #para3 then
    return
  end
  for _, entryTid in ipairs(para3) do
    local entryCfg = DT.Task[entryTid]
    if entryCfg and entryCfg.TaskType == "TaskType_Activity_Main" then
      local rows = {}
      for taskTid, taskCfg in pairs(DT.Task) do
        if taskCfg.BelongTaskGroup == entryTid then
          table.insert(rows, {
            taskTid,
            taskCfg.BaseSortID or 0
          })
        end
      end
      table.sort(rows, function(a, b)
        if a[2] == b[2] then
          return a[1] < b[1]
        end
        return a[2] < b[2]
      end)
      for _, row in ipairs(rows) do
        table.insert(self._raidPara3LeafTaskTids, row[1])
      end
    elseif entryCfg then
      table.insert(self._raidPara3LeafTaskTids, entryTid)
    end
  end
end

function ActivityRAIDComp:GetRaidAchievementProgress()
  local finishCount, totalCount = 0, 0
  self:_EnsureRaidPara3LeafTaskTids()
  local leafList = self._raidPara3LeafTaskTids
  if not leafList or 0 == #leafList then
    return finishCount, totalCount
  end
  totalCount = #leafList
  for _, taskTid in ipairs(leafList) do
    if TaskDataUtils.IsTaskDoneByTaskId(taskTid) then
      finishCount = finishCount + 1
    end
  end
  return finishCount, totalCount
end

function ActivityRAIDComp:ReqStageGroupInfo()
  local stageGroupList = self.activityConfig and self.activityConfig.ActivityPara1 or {}
  for _, stageGroupId in ipairs(stageGroupList) do
    CopyDataUtils.ReqCopyData(nil, stageGroupId, nil, true)
  end
  ActivityRaidUtils.ReqWorldBossKillCount(self.activityTid, System.fn(self, self._OnWorldBossKillCountReady))
end

function ActivityRAIDComp:OnClickChallenge()
  local stageGroupList = self.activityConfig and self.activityConfig.ActivityPara1 or {}
  ActivityController.Instance:OpenActivityRaidStagePanel(self.activityTid, self.resonanceGroupId, stageGroupList)
end

function ActivityRAIDComp:OnClickBtnRank()
  RankController.Instance:OpenRankWorldBossView({
    killRankType = RankDefine.RankType.RaidActivityKill,
    assistRankType = RankDefine.RankType.RaidActivityAssist
  })
end

function ActivityRAIDComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_TeamSchool_Open", callback)
end

function ActivityRAIDComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_TeamSchool_Close", callback)
end

return ActivityRAIDComp
