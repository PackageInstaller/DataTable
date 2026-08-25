local ActivityWorldBossStagePanel, Super = System.NewClass("ActivityWorldBossStagePanel", ActivityStageGroupPanel)
ActivityWorldBossStagePanel.uiResCls = UI_Events_WorldBoss_StageGroupResource

function ActivityWorldBossStagePanel:ctor(...)
  Super.ctor(self, ...)
  self.activityData = ActivityDataUtils.GetActivityData(self.activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(self.activityTid)
  self.stageGroup2Task = self:GetStageTaskMap()
  self.activityDefine = ActivityDefine.StageGroupDefine[self.activityType]
end

function ActivityWorldBossStagePanel:_GetUIResCls()
  return self.activityDefine.PanelResCls
end

function ActivityWorldBossStagePanel:GetStageTaskMap()
  do return ActivityCfgUtils.GetStageTaskMap end
  return ActivityCfgUtils.GetStageTaskMap, self.activityTid
end

function ActivityWorldBossStagePanel:OnBind(binder)
  self.binder = binder
  Super.OnBind(self, binder)
  self:BindChallengeCount()
end

function ActivityWorldBossStagePanel:ShowProgress()
  local finishCount, totalCount = self:GetProgress()
  self.binder:SetText(self.ui.Text_Progress, LT.Textf("TextBossProgress", finishCount, totalCount))
end

function ActivityWorldBossStagePanel:BindChallengeCount()
  local stageGroupList = self.activityConfig.ActivityPara1
  local stageGroupId = stageGroupList[1]
  local _, limitCount = CopyDataUtils.GetStageGroupDailyWinCount(stageGroupId)
  self.binder:BindToText(self.ui.Text_Progress, function()
    local winCount, lmtCount = CopyDataUtils.GetStageGroupDailyWinCount(stageGroupId)
    if 0 ~= lmtCount then
      local countText = string.format("%d/%d", winCount, lmtCount)
      if lmtCount <= winCount then
        do return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips4", string.color(countText, "#FF0000") end
        return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips4", string.color(countText, "#FF0000")
      else
        do return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips4" end
        return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips4", countText, string.color(countText, "#FF0000")
      end
    end
  end)
  self.binder:BindToTextColorOld(self.ui.Text_Progress, function()
    local winCount, lmtCount = CopyDataUtils.GetStageGroupDailyWinCount(stageGroupId)
    if 0 ~= lmtCount and lmtCount <= winCount then
      do return ColorUtils.GetColorHexCode, "UXWarning" end
      return ColorUtils.GetColorHexCode, "UXWarning", cd.ColorType.Dark
    end
  end)
  if 0 == limitCount then
    self.binder:BindToRaw(function(binder, _, _)
      self:ShowProgress()
    end, function()
      do return self.GetProgress end
      return self.GetProgress, self
    end)
  end
end

function ActivityWorldBossStagePanel:BindCoinList()
  self.ui.Group_Coin:SetActive(false)
end

function ActivityWorldBossStagePanel:GetProgress()
  local finishCount, totalCount = 0, 0
  local finishTaskId = self.activityConfig.ActivityPara2
  local finishTaskCfg = TaskDataUtils.GetTaskConfigByTid(finishTaskId)
  if not finishTaskCfg then
    return finishCount, totalCount
  end
  local subBossTaskList = finishTaskCfg.CompleteCondPara
  for _, subBossTaskId in ipairs(subBossTaskList) do
    if TaskDataUtils.IsTaskDoneByTaskId(subBossTaskId) then
      finishCount = finishCount + 1
    end
  end
  totalCount = #subBossTaskList
  return finishCount, totalCount
end

function ActivityWorldBossStagePanel:BindGroupsItem(cBinder, itemGo, index, childGroupList, uiResCfg)
  local groupUiNodeName = uiResCfg.StageGroupChildUINodeName
  local ui = uiResCfg.StageGroupUIResCls(itemGo)
  for idx, groupTid in ipairs(childGroupList) do
    local obj = ui[groupUiNodeName .. idx]
    if obj and groupTid then
      local stageNum = index * 2 + (idx - 2)
      cBinder:BindComponent(ActivityBossStageItem(obj, uiResCfg.StageGroupChildUIResCls, stageNum, groupTid, self.activityTid, ActivityDefine.StageGroupDefine[self.activityType], function(stageGroupId)
        self:OpenStageGroup(stageGroupId)
      end, self.stageGroup2Task[groupTid]))
    end
  end
  for i = #childGroupList + 1, uiResCfg.StageGroupDiffPosNum do
    local obj = ui[groupUiNodeName .. i]
    obj:SetActive(false)
  end
end

function ActivityWorldBossStagePanel:OpenStageGroup(stageGroupId)
  local activityCfg = ActivityDefine.StageGroupDefine[self.activityType]
  local extraData = table.clone(activityCfg)
  extraData.taskId = self.stageGroup2Task[stageGroupId]
  CopyDataUtils.PrepareActivityChallengeStageData(stageGroupId, function()
    UIManager.Instance:Reopen(Urls.ActivityChallengePanel, stageGroupId, self.activityTid, nil, extraData)
  end)
end

return ActivityWorldBossStagePanel
