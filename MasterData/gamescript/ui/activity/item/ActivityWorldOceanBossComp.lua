local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local ActivityWorldOceanBossComp, Super = System.NewClass("ActivityWorldBossComp", ActivityMagicStoryComp)

function ActivityWorldOceanBossComp:ctor(uiNode, activityTid, model)
  self.ui = UI_Events_Panel_WorldBossResource(uiNode)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.activityDefine = ActivityDefine.ActivityCompClsInfo[self.activityConfig.ActivityType]
end

function ActivityWorldOceanBossComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self.binder:BindComponent(UICompRedDotNewVue(self.ui.NewTag_Record, RedDotDefine.DynamicRedDotID.ActivityWorldBossStageGroupEntry, {
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
  self:BindLockState()
  self:ReqStageGroupInfo()
  self:BindChallengeCount()
  self:BindGiftTask()
  self:BindChallengeBtn()
end

function ActivityWorldOceanBossComp:BindChallengeBtn()
  self.binder:BindButtonClick(self.ui.Btn_Challenge, System.fn(self, self.OnClickChallenge))
  self.binder:BindToButtonState(self.ui.Btn_Challenge, function()
    if self:IsFinished() then
      return CS.Z1Client.Z1ButtonState.Unclickable
    end
    local winCount, limitCount = CopyDataUtils.GetStageGroupDailyWinCount(self.stageGroupId)
    if 0 ~= limitCount and limitCount <= winCount then
      return CS.Z1Client.Z1ButtonState.Unclickable
    end
  end)
end

function ActivityWorldOceanBossComp:BindGiftTask()
  local taskTid = self.activityConfig.ActivityPara4
  if type(taskTid) == "table" then
    taskTid = taskTid[1]
  end
  taskTid = tonumber(taskTid)
  if not taskTid then
    self.ui.UI_Summon_GiftTask:SetActive(false)
    return
  end
  self.ui.UI_Summon_GiftTask:SetActive(true)
  self.binder:BindComponent(SummonGiftTask(self.ui.UI_Summon_GiftTask, taskTid, System.fn(self, self.ReqTaskReward)))
end

function ActivityWorldOceanBossComp:ReqTaskReward(taskTid)
  ActivityDataUtils.ReqGainAward(self.activityTid, taskTid)
end

function ActivityWorldOceanBossComp:BindActivitName()
  self.binder:SetText(self.ui.Text_C_Topic, ActivityDataUtils.GetActivityName(self.activityTid))
end

function ActivityWorldOceanBossComp:BindChallengeCount()
  local stageGroupList = self.activityConfig.ActivityPara1
  local stageGroupId = stageGroupList[1]
  self.binder:BindToText(self.ui.Text_ChallengeCount, function()
    local winCount, limitCount = CopyDataUtils.GetStageGroupDailyWinCount(stageGroupId)
    if 0 ~= limitCount then
      local countText = string.format("%d/%d", winCount, limitCount)
      if limitCount <= winCount then
        do return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips4", string.color(countText, "#FF0000") end
        return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips4", string.color(countText, "#FF0000")
      else
        do return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips4" end
        return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips4", countText, string.color(countText, "#FF0000")
      end
    end
  end)
  self.binder:BindToTextColorOld(self.ui.Text_ChallengeCount, function()
    if self:IsMaxChallengeCount() then
      do return ColorUtils.GetColorHexCode, "UXWarning" end
      return ColorUtils.GetColorHexCode, "UXWarning", cd.ColorType.Dark
    end
  end)
end

function ActivityWorldOceanBossComp:IsMaxChallengeCount()
  local winCount, limitCount = CopyDataUtils.GetStageGroupDailyWinCount(self.stageGroupId)
  return 0 ~= limitCount and limitCount <= winCount
end

function ActivityWorldOceanBossComp:SetProgressText()
  local finishCount, totalCount = self:GetProgress()
  self.binder:SetText(self.ui.Text_CurProgress, finishCount)
  self.binder:SetText(self.ui.Text_TotleProgress, "/" .. totalCount)
  local isFinish = self:IsFinished()
  self.binder:SetActive(self.ui.Image_Killed, isFinish)
  if not isFinish then
    self.binder:SetText(self.ui.Text_Tip, LT.Text("DeepSeaInvasionDefensiveActiviityTips1"))
  else
    self.binder:SetText(self.ui.Text_Tip, LT.Text("DeepSeaInvasionDefensiveActiviityTips2"))
  end
end

function ActivityWorldOceanBossComp:GetCurBossAndStageName()
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

function ActivityWorldOceanBossComp:ReqStageGroupInfo()
  local stageGroupList = self.activityConfig.ActivityPara1
  for _, stageGroupId in ipairs(stageGroupList) do
    CopyDataUtils.ReqCopyData(nil, stageGroupId, nil, true)
  end
end

function ActivityWorldOceanBossComp:OnClickChallenge()
  if self:IsFinished() then
    Alert.ShowStr("DeepSeaInvasionDefensiveActiviityTips15")
    return
  end
  local stageGroupList = self.activityConfig.ActivityPara1
  ActivityController.Instance:OpenActivityWorldBossStagePanel(self.activityTid, self.resonanceGroupId, stageGroupList)
end

function ActivityWorldOceanBossComp:IsFinished()
  local finishCount, totalCount = self:GetProgress()
  return totalCount <= finishCount
end

function ActivityWorldOceanBossComp:GetProgress()
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

function ActivityWorldOceanBossComp:OnOpenAnim(callback)
  if self.uiAnimController and self.activityDefine.openAnim then
    self.uiAnimController:PlayState(self.activityDefine.openAnim, callback)
  elseif self.activityDefine.openTimeline then
    self:PlayTimeline(self.activityDefine.openTimeline)
  else
    callback()
  end
end

function ActivityWorldOceanBossComp:OnCloseAnim(callback)
  if self.uiAnimController and self.activityDefine.closeAnim then
    self.uiAnimController:PlayState(self.activityDefine.closeAnim, callback)
  else
    callback()
  end
end

function ActivityWorldOceanBossComp:PlayTimeline(timelinePath)
  self:ClearTimeline()
  self.player = self.ui.uiNode
  self.timelinePlayer = PortraitTimelinePlayer(self.player)
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = timelinePath
  self.timelinePlayer:Play(timelineConfig)
end

function ActivityWorldOceanBossComp:ClearTimeline()
  if self.timelinePlayer then
    self.timelinePlayer:Stop()
    self.timelinePlayer:Dispose()
    self.timelinePlayer = nil
  end
end

function ActivityWorldOceanBossComp:_BindActivityTimer()
  if not (self.activityData and self.binder and self.ui) or not self.ui.Text_Time then
    Logger.Warn("_BindActivityTimer wrong activityData:%s binder:%s Text_Time:%s", self.activityData, self.binder, self.ui and self.ui.Text_Time)
    return
  end
  self.binder:BindTimer(1, 0, nil, System.fn(self, self._BindActivityTimer))
  local hideTs = self.activityData.base.hideTs or 0
  if 0 == hideTs then
    local timeType = ActivityDataUtils.GetTimeType(self.activityData.activityTid)
    if timeType == ActivityDefine.ActivityTimeType.Permanent then
      self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
      return
    end
  end
  self:_TimerFixedUpdate()
end

function ActivityWorldOceanBossComp:_TimerFixedUpdate()
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  local hideTs = self.activityData.base.hideTs or 0
  local leftTime = hideTs - now
  if leftTime < 0 then
    self:_ClearTimer()
  end
  local timeText = ""
  if leftTime >= 0 then
    timeText = TimeUtils.ActivityCountDownFormat(leftTime)
  else
    timeText = LT.Text("ActivityTimeExpired")
  end
  self.binder:SetText(self.ui.Text_Time, timeText)
end

return ActivityWorldOceanBossComp
