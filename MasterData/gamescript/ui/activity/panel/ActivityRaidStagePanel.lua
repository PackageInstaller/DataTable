local ActivityRaidStagePanel, Super = System.NewClass("ActivityRaidStagePanel", ActivityStageGroupPanel)
ActivityRaidStagePanel.uiResCls = UI_Events_RAID_StageGroupResource

local function FindChildGameObjectRecursively(rootGo, childName)
  if not rootGo or not childName then
    return nil
  end
  local transform = rootGo.transform
  if not transform then
    return nil
  end
  local childCount = transform.childCount - 1
  for i = 0, childCount do
    local childTransform = transform:GetChild(i)
    if childTransform and childTransform.gameObject and childTransform.gameObject.name == childName then
      return childTransform.gameObject
    end
  end
  for i = 0, childCount do
    local childTransform = transform:GetChild(i)
    local found = childTransform and FindChildGameObjectRecursively(childTransform.gameObject, childName)
    if found then
      return found
    end
  end
  return nil
end

function ActivityRaidStagePanel:ctor(viewData)
  Super.ctor(self, viewData)
  self._clickStageGroupId = nil
  self._raidStageGroupItems = {}
end

function ActivityRaidStagePanel:BindCoinList()
  if self.ui.Group_Coin then
    self.ui.Group_Coin:SetActive(false)
  end
end

function ActivityRaidStagePanel:_BindActivityHeader()
  if self.ui.Text_C_Title then
    self.binder:SetText(self.ui.Text_C_Title, ActivityDataUtils.GetActivityName(self.activityTid))
  end
  if self.ui.Text_C_Introduction then
    self.binder:SetText(self.ui.Text_C_Introduction, ActivityDataUtils.GetActivityPlot(self.activityTid) or "")
  end
end

function ActivityRaidStagePanel:OnBind(binder)
  self.binder = binder
  self.activityConfig = ActivityDataUtils.GetConfig(self.activityTid)
  self:BindCoinList()
  self:_BindActivityHeader()
  self:BindStageGroupList(self.stageGroupList)
  self:_BindActivityTimer()
  self:_BindRaidProgressBlock()
  self:_ReqRaidStageGroupInfo()
  binder:BindEvent(EventMgr.Instance.OnActivityDataSynced, System.fn(self, self._OnActivityDataSyncedRefreshRaidKill))
  binder:BindEvent(EventMgr.Instance.OnActivityWorldBossKillSynced, System.fn(self, self._OnActivityWorldBossKillSynced))
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self._OnClickClose)))
end

function ActivityRaidStagePanel:_OnWorldBossKillCountReady()
  for _, item in ipairs(self._raidStageGroupItems) do
    item:RefreshKillCount()
  end
  self:_EnsureRaidMilestoneCells()
  self:_ApplyRaidProgressVisual(self:_GetRaidWorldKillTotal())
end

function ActivityRaidStagePanel:_OnActivityDataSyncedRefreshRaidKill(syncMap)
  if not self.activityTid or not syncMap then
    return
  end
  if not syncMap[self.activityTid] and not syncMap[tostring(self.activityTid)] then
    return
  end
  self:_OnWorldBossKillCountReady()
end

function ActivityRaidStagePanel:_OnActivityWorldBossKillSynced(activityTid)
  if not self.activityTid or not activityTid then
    return
  end
  if activityTid ~= self.activityTid and activityTid ~= tonumber(self.activityTid) then
    return
  end
  self:_OnWorldBossKillCountReady()
end

function ActivityRaidStagePanel:OnUnbind()
  self:_ClearTimer()
  Super.OnUnbind(self)
end

function ActivityRaidStagePanel:_ReqRaidStageGroupInfo()
  local stageGroupList = self.activityConfig and self.activityConfig.ActivityPara1 or {}
  for _, stageGroupId in ipairs(stageGroupList) do
    CopyDataUtils.ReqCopyData(nil, stageGroupId, nil, true)
  end
  ActivityRaidUtils.ReqWorldBossKillCount(self.activityTid, System.fn(self, self._OnWorldBossKillCountReady))
end

function ActivityRaidStagePanel:_BindActivityTimer()
  if not (self.activityTid and self.binder and self.ui) or not self.ui.Text_Time then
    if self.ui and self.ui.Text_Time then
      self.ui.Text_Time:SetActive(false)
    end
    return
  end
  local timeType = ActivityDataUtils.GetTimeType(self.activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
    return
  end
  self:_ClearTimer()
  self:_RaidStageGroupTimerTick()
  self.activityTimer = self.binder:BindTimer(1, -1, System.fn(self, self._RaidStageGroupTimerTick), nil)
end

function ActivityRaidStagePanel:_RaidStageGroupTimerTick()
  if not (self.binder and self.ui) or not self.ui.Text_Time then
    return
  end
  local activityData = ActivityDataUtils.GetActivityData(self.activityTid)
  self.binder:SetActive(self.ui.Text_Time, true)
  self.binder:SetText(self.ui.Text_Time, ActivityRaidUtils.GetActivityTimeText(activityData, self.activityConfig))
  local endTime = activityData and activityData.endTime
  if endTime and endTime > 0 and endTime < TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime()) then
    self:_ClearTimer()
  end
end

function ActivityRaidStagePanel:_EnsureRaidPara3LeafTaskTids()
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

function ActivityRaidStagePanel:_GetRaidAchievementProgress()
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

function ActivityRaidStagePanel:_GetRaidWorldKillTotal()
  do return ActivityRaidUtils.ResolveWorldKillDisplayCount, self.activityTid end
  return ActivityRaidUtils.ResolveWorldKillDisplayCount, self.activityTid, self.activityConfig
end

function ActivityRaidStagePanel:_GetRaidWorldMilestoneRows()
  if self._raidWorldMilestoneRows == nil then
    self._raidWorldMilestoneRows = ActivityRaidUtils.ResolveWorldMilestoneRows(self.activityConfig)
  end
  return self._raidWorldMilestoneRows
end

function ActivityRaidStagePanel:_GetRaidWorldProgressCap()
  do return ActivityRaidUtils.GetWorldProgressCap, self:_GetRaidWorldMilestoneRows() end
  return ActivityRaidUtils.GetWorldProgressCap, self:_GetRaidWorldMilestoneRows()
end

function ActivityRaidStagePanel:_EnsureRaidMilestoneCells()
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

function ActivityRaidStagePanel:_ApplyRaidProgressVisual(totalCount)
  if not self._progressGroupRes or not self.binder then
    return
  end
  totalCount = totalCount or 0
  local bar = self._progressGroupRes.Image_ProgressBar
  if bar then
    local fillAmount = ActivityRaidUtils.GetWorldMilestoneFillAmount(totalCount, self:_GetRaidWorldMilestoneRows())
    self.binder:SetImageFillAmount(bar, fillAmount)
  end
  local textKill = self._progressGroupRes.Text_C_Kill or self._progressGroupRes.Text_CurProgress
  if textKill then
    self.binder:SetText(textKill, tostring(totalCount))
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
      self.binder:SetText(itemRes.Text_Count, ActivityRaidUtils.FormatWorldCount(milestone))
    end
    local reached = totalCount >= milestone
    if itemRes.Group_High then
      self.binder:SetActive(itemRes.Group_High, reached)
    end
    if itemRes.Group_Normal then
      self.binder:SetActive(itemRes.Group_Normal, not reached)
    end
  end
end

function ActivityRaidStagePanel:_BindRaidProgressBlock()
  if not self.ui.UI_Events_Item_RAIDProgressGroup then
    return
  end
  self._raidWorldMilestoneRows = nil
  self._progressGroupRes = UI_Events_Item_RAIDProgressGroupResource(self.ui.UI_Events_Item_RAIDProgressGroup)
  self._raidMilestoneReady = false
  self.binder:BindToRaw(function(cbinder, _)
    self:_EnsureRaidMilestoneCells()
    self:_ApplyRaidProgressVisual(self:_GetRaidWorldKillTotal())
  end, function()
    do return ActivityRaidUtils.GetWorldProgressRawKey, self.activityTid end
    return ActivityRaidUtils.GetWorldProgressRawKey, self.activityTid, self.activityConfig
  end)
  self.binder:BindTimer(5, -1, System.fn(self, self._OnRaidProgressTimerTick), nil)
end

function ActivityRaidStagePanel:_OnRaidProgressTimerTick()
  local totalCount = self:_GetRaidWorldKillTotal()
  self:_EnsureRaidMilestoneCells()
  self:_ApplyRaidProgressVisual(totalCount)
end

function ActivityRaidStagePanel:_OnClickClose()
  self:Close()
end

function ActivityRaidStagePanel:_OnClickStageGroup(stageGroupId)
  self._clickStageGroupId = stageGroupId
  self:_OpenClickedStageGroup()
end

function ActivityRaidStagePanel:_OpenClickedStageGroup()
  if not self._clickStageGroupId then
    return
  end
  self:OpenStageGroup(self._clickStageGroupId)
end

function ActivityRaidStagePanel:_GetStageGroupChildObject(ui, itemGo, childName)
  if ui and ui[childName] then
    return ui[childName]
  end
  do return FindChildGameObjectRecursively, itemGo end
  return FindChildGameObjectRecursively, itemGo, childName
end

function ActivityRaidStagePanel:BindGroupsItem(cBinder, itemGo, index, childGroupList, _)
  local UIResCfg = ActivityDefine.StageGroupDefine[self.activityType]
  local groupUiNodeName = UIResCfg.StageGroupChildUINodeName
  local ui = UIResCfg.StageGroupUIResCls(itemGo)
  for idx, groupTid in ipairs(childGroupList) do
    local obj = self:_GetStageGroupChildObject(ui, itemGo, groupUiNodeName .. idx)
    if obj and groupTid then
      local stageNum = index * 2 + (idx - 2)
      local groupItem = cBinder:BindComponent(ActivityRaidStageGroupItem(obj, UIResCfg.StageGroupChildUIResCls, stageNum, groupTid, self.activityTid, ActivityDefine.StageGroupDefine[self.activityType], System.fn(self, self._OnClickStageGroup)))
      if groupItem and groupItem.IsStageGroupOpen and groupItem:IsStageGroupOpen() and not self._firstOpenedStageItem then
        self._firstOpenedStageItem = groupItem
      end
      if groupItem then
        table.insert(self._raidStageGroupItems, groupItem)
      end
    end
  end
  for i = #childGroupList + 1, UIResCfg.StageGroupDiffPosNum do
    local obj = self:_GetStageGroupChildObject(ui, itemGo, groupUiNodeName .. i)
    if obj then
      obj:SetActive(false)
    end
  end
end

return ActivityRaidStagePanel
