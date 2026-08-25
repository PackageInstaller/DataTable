local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local ActivityWorldBossComp, Super = System.NewClass("ActivityWorldBossComp", ActivityMagicStoryComp)

function ActivityWorldBossComp:ctor(uiNode, activityTid, model)
  self.ui = UI_Events_Panel_WorldBossResource(uiNode)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
end

function ActivityWorldBossComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  binder:SetImage(self.ui.Image_Bg, ActivityDataUtils.GetBgImage(self.activityTid))
  binder:BindComponent(UICompRedDotNewVue(self.ui.NewTag_Challenge, RedDotDefine.DynamicRedDotID.ActivityWorldBossEntry, {
    activityTid = self.activityTid
  }))
  binder:BindToRaw(function(_, _, _)
    self:SetProgressText()
  end, function()
    do return self.GetProgress end
    return self.GetProgress, self
  end)
  self:BindActivitName()
  self:_SetActivityPlot()
  self:_BindActivityTimer()
  self:BindSubPlotRecord()
  self:BindLockState()
  self:ReqStageGroupInfo()
  self:_BindBtnRank()
  self.binder:BindButtonClick(self.ui.Btn_Challenge, System.fn(self, self.OnClickChallenge))
end

function ActivityWorldBossComp:BindLockState()
  self.ui.Group_UnLock:SetActive(true)
  self.ui.Group_Locked:SetActive(false)
end

function ActivityWorldBossComp:_BindBtnRank()
  self.binder:BindButtonClick(self.ui.Btn_Rank, System.fn(self, self._OnClickBtnRank))
end

function ActivityWorldBossComp:BindSubPlotRecord()
  if self.hasFinishedActivity or not self.activityConfig.ActivityPara4 then
    self.ui.Btn_Record:SetActive(false)
    return
  end
  local subPlotGroupId = table.unpack(self.activityConfig.ActivityPara4)
  self.binder:BindZ1Button(self.ui.Btn_Record, function()
    CopyDataUtils.OnClickSubPlotEntry(subPlotGroupId, self.activityTid, true)
  end)
end

function ActivityWorldBossComp:BindActivitName()
  self.binder:SetText(self.ui.Text_C_Topic, ActivityDataUtils.GetActivityName(self.activityTid))
end

function ActivityWorldBossComp:SetProgressText()
  local finishCount, totalCount = self:GetProgress()
  self.binder:SetText(self.ui.Text_CurProgress, finishCount)
  self.binder:SetText(self.ui.Text_TotleProgress, "/" .. totalCount)
  local isFinish = self:IsFinished()
  self.binder:SetActive(self.ui.Image_Killed, isFinish)
  if not isFinish then
    local bossName, stageName = self:GetCurBossAndStageName()
    if bossName and stageName then
      self.binder:SetActive(self.ui.Text_Tip, true)
      self.binder:SetText(self.ui.Text_Tip, LT.Textf("WorldBossDoing", bossName, stageName))
    else
      self.binder:SetActive(self.ui.Text_Tip, false)
    end
  else
    self.binder:SetText(self.ui.Text_Tip, LT.Text("WorldBossDone"))
  end
  AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Tip, 0, 0, 0, nil, true)
  self.binder:SetText(self.ui.Text_C_Challenge, LT.Text("TextFightBoss"))
end

function ActivityWorldBossComp:GetCurBossAndStageName()
  local finishTaskId = self.activityConfig.ActivityPara2
  local finishTaskCfg = TaskDataUtils.GetTaskConfigByTid(finishTaskId)
  if not finishTaskCfg then
    return
  end
  local subBossTaskList = finishTaskCfg.CompleteCondPara
  for _, subBossTaskId in ipairs(subBossTaskList) do
    if not TaskDataUtils.IsTaskDoneByTaskId(subBossTaskId) then
      local subBossTaskCfg = TaskDataUtils.GetTaskConfigByTid(subBossTaskId)
      local _, bossStageId = table.unpack(subBossTaskCfg.CompleteCondPara)
      if bossStageId and DT.StageGroup[bossStageId] then
        local bossCfg = DT.StageGroup[bossStageId]
        local bossName = LT.Text(bossCfg.Name)
        local relatedTaskList = {subBossTaskId}
        for _, taskCfg in pairs(DT.Task) do
          if taskCfg.CompleteCond == "CompleteTask" and taskCfg.CompleteCondPara[1] == subBossTaskId then
            table.insert(relatedTaskList, taskCfg.ID)
          end
        end
        local stageName = ""
        for _, stageCfg in pairs(DT.Stage) do
          if stageCfg.UnlockCondition and stageCfg.UnlockCondition[1] and table.contains(relatedTaskList, stageCfg.UnlockCondition[1]) then
            stageName = LT.Text(stageCfg.NameNumber or "")
            break
          end
        end
        return bossName, stageName
      end
    end
  end
end

function ActivityWorldBossComp:ReqStageGroupInfo()
  local stageGroupList = self.activityConfig.ActivityPara1
  for _, stageGroupId in ipairs(stageGroupList) do
    CopyDataUtils.ReqCopyData(nil, stageGroupId, nil, true)
  end
end

function ActivityWorldBossComp:OnClickChallenge()
  local stageGroupList = self.activityConfig.ActivityPara1
  ActivityController.Instance:OpenActivityWorldBossStagePanel(self.activityTid, self.resonanceGroupId, stageGroupList)
end

function ActivityWorldBossComp:IsFinished()
  local finishCount, totalCount = self:GetProgress()
  return totalCount <= finishCount
end

function ActivityWorldBossComp:GetProgress()
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

function ActivityWorldBossComp:OnOpenAnim(callback)
  if self.uiAnimController then
    self.uiAnimController:PlayState("UI_Events_Panel_WorldBoss_Open", callback)
  else
    callback()
  end
end

function ActivityWorldBossComp:OnCloseAnim(callback)
  if self.uiAnimController then
    self.uiAnimController:PlayState("UI_Events_Panel_WorldBoss_Close", callback)
  else
    callback()
  end
end

function ActivityWorldBossComp:_OnClickBtnRank()
  RankController.Instance:OpenRankWorldBossView()
end

return ActivityWorldBossComp
