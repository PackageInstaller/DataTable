local ActivityPermanentRailWayTabItem, Super = System.NewClass("ActivityPermanentRailWayTabItem", ActivityPermanentTabItem)
local SeasonGameplayType = CommonDefine.SeasonGameplayType

function ActivityPermanentRailWayTabItem:_OnBindEvent(binder)
  Super._OnBindEvent(self, binder)
  binder:BindEvent(EventMgr.Instance.OnCareerLevelDataChanged, System.fn(self, self._OnCareerLevelDataChanged))
  binder:BindEvent(EventMgr.Instance.TaskInfoUpdated, System.fn(self, self._OnTaskInfoUpdated))
end

function ActivityPermanentRailWayTabItem:_OnCareerLevelDataChanged()
  self:_RefreshRedDot()
end

function ActivityPermanentRailWayTabItem:_OnTaskInfoUpdated(taskData)
  local taskType = TaskCfgUtils.GetCfgField("TaskType", taskData.tid)
  if taskType == cd.TaskType.TaskType_RailWay then
    self:_RefreshRedDot()
    return
  end
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway)
  if seasonId and 0 ~= seasonId then
    local seasonTaskTid = SeasonRotationCfgUtils.GetSeasonTaskId(seasonId, SeasonGameplayType.ConsciousnessRailway)
    if seasonTaskTid and 0 ~= seasonTaskTid and taskData.tid == seasonTaskTid then
      self:_RefreshRedDot()
    end
  end
end

function ActivityPermanentRailWayTabItem:_RefreshView(activityTid)
  Super._RefreshView(self, activityTid)
  self:_RefreshRedDot()
end

function ActivityPermanentRailWayTabItem:_RefreshRedDot()
  self.binder:BindComponent(UICompRedDotNewVue(self.ui.Red_Com, RedDotDefine.DynamicRedDotID.RailWayEntry))
end

return ActivityPermanentRailWayTabItem
