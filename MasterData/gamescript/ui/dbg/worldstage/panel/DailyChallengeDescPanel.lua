local DailyChallengeDescPanel, Super = System.NewClass("DailyChallengeDescPanel", WorldStageDescPanel)
DailyChallengeDescPanel.uiResCls = UI_Dbgcopy_Item_Target_TitleResource

function DailyChallengeDescPanel:ctor(data)
  Super.ctor(self, data)
end

function DailyChallengeDescPanel:OnBindText(binder)
  binder:SetActive(self.ui.Text_Iayer, true)
  binder:SetActive(self.ui.Text_Introduce, false)
  binder:SetText(self.ui.Text_Iayer, string.format("%s<space=0.4em>%s", LT.Text(self.stageNumber), LT.Text(self.stageName)))
end

function DailyChallengeDescPanel:OnBindStarDetailGroup(binder)
  binder:SetActive(self.ui.Group_Star, false)
end

function DailyChallengeDescPanel:OnBindAchieveGroup(binder)
  binder:SetActive(self.ui.Group_Achievement, false)
  self:OnBindDailyTaskGroup(binder)
end

function DailyChallengeDescPanel:_GetDailyChallengeTaskTidList()
  local stageGroupCfg = DT.StageGroup[self.stageGroupId]
  local taskSortMap = {}
  if stageGroupCfg and stageGroupCfg.IntegralTerm then
    for index, taskTid in ipairs(stageGroupCfg.IntegralTerm) do
      taskSortMap[taskTid] = index
    end
  end
  local stageData = WorldStageManager.Instance:GetCurStageData()
  local stageDataTaskMap = stageData and stageData.ChallengeScore and stageData.ChallengeScore.taskList
  if not stageDataTaskMap then
    return
  end
  print("dung stagedata:", table.tostring(stageData.ChallengeScore))
  local dailyChallengeTaskList = {}
  for _, taskData in pairs(stageDataTaskMap) do
    table.insert(dailyChallengeTaskList, taskData.tid)
  end
  table.sort(dailyChallengeTaskList, function(a, b)
    local sortA = a and taskSortMap[a] or 999
    local sortB = b and taskSortMap[b] or 999
    return sortA < sortB
  end)
  return dailyChallengeTaskList
end

function DailyChallengeDescPanel:OnBindDailyTaskGroup(binder)
  local dailyChallengeTaskList = self:_GetDailyChallengeTaskTidList()
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if not (stageData and stageData.ChallengeScore) or not stageData.ChallengeScore.taskList then
    binder:SetActive(self.ui.Group_Daily_Special_Rate, false)
  else
    binder:SetActive(self.ui.Group_Daily_Special_Rate, true)
    binder:SetText(self.ui.Text_Daily_Special_Rate, LT.Text("SpecialRating"))
    local totalHeight = 0
    local space = 11
    for i = 1, #dailyChallengeTaskList do
      local taskTid = dailyChallengeTaskList[i]
      local uiNode = CS.UnityEngine.GameObject.Instantiate(self.ui.UI_Daily_Task_1, self.ui.UI_Daily_Task_1.transform.parent)
      local showTaskCfg = TaskDataUtils.GetConfig(taskTid)
      binder:SetActive(uiNode, nil ~= showTaskCfg)
      if showTaskCfg then
        local uiRes = UI_Dbgcopy_Panel_Main_New_AchievementResource(uiNode)
        binder:BindToRaw(function(cbinder, taskDesc)
          cbinder:SetText(uiRes.Text_Achievement, taskDesc)
        end, function()
          do return self._GetTaskDesc, self end
          return self._GetTaskDesc, self, taskTid
        end)
        binder:BindToRaw(function(cBinder, taskCount)
          cBinder:SetActive(uiRes.Image_Win, false)
          cBinder:SetActive(uiRes.Image_Lose, false)
          cBinder:SetActive(uiRes.Image_Nor, true)
          local height = StrUtils.SetPreferredHeight(uiRes.Text_Achievement)
          self:_SetItemHeight(uiNode, height)
          totalHeight = totalHeight + height + space
        end, function()
          local curStageData = WorldStageManager.Instance:GetCurStageData()
          local taskMap = curStageData and curStageData.ChallengeScore and curStageData.ChallengeScore.taskList
          return taskMap and taskMap[taskTid] and taskMap[taskTid].count
        end)
        binder:BindToRaw(function(cbinder, isOk)
          cbinder:SetActive(uiRes.Image_Win, true == isOk)
          cbinder:SetActive(uiRes.Image_Lose, false == isOk)
          cbinder:SetActive(uiRes.Image_Nor, nil == isOk)
          local colorType = CommonDefine.ColorType.Normal
          if nil ~= isOk then
            colorType = isOk and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
          end
          cbinder:SetTextColorType(uiRes.Text_Achievement, colorType)
        end, function()
          local _, isTaskOk = self:_GetTaskReplaceContentAndIsOk(taskTid)
          return isTaskOk
        end)
      end
    end
    self:_SetItemHeight(self.ui.Group_AchievementInfo, totalHeight - space)
    totalHeight = totalHeight + 36
    self:_SetItemHeight(self.ui.Group_Special_Rate, totalHeight)
  end
  binder:SetActive(self.ui.Group_Daily_Total_Step, false)
end

function DailyChallengeDescPanel:_GetTaskData(taskTid)
  local curStageData = WorldStageManager.Instance:GetCurStageData()
  local taskMap = curStageData and curStageData.ChallengeScore and curStageData.ChallengeScore.taskList
  return taskMap and taskMap[taskTid]
end

function DailyChallengeDescPanel:_GetTaskDesc(taskTid)
  local taskCfg = TaskDataUtils.GetConfig(taskTid)
  local desc = LT.Text(taskCfg.Desc)
  local taskShowType = taskCfg and taskCfg.ExtraCondPara and taskCfg.ExtraCondPara[1]
  local showTaskCount = taskShowType == CommonDefine.StageTaskShowType.Common
  local taskData = self:_GetTaskData(taskTid)
  local taskCount = taskData and taskData.count or 0
  local isTaskOk = true
  if showTaskCount then
    desc = string.format("%s %s", desc, LT.Textf("DailyChallenge_CurrentProgress", taskCount or 0))
  end
  if string.contains(desc, "s1") then
    local replaceStr, isOk = self:_GetTaskReplaceContentAndIsOk(taskTid)
    desc = string.replace(desc, "{s1}", replaceStr or 0, true)
    isTaskOk = isOk
  end
  return desc, isTaskOk
end

function DailyChallengeDescPanel:_GetTaskReplaceContentAndIsOk(taskTid)
  local taskCfg = TaskDataUtils.GetConfig(taskTid)
  if not taskCfg then
    return 0
  end
  local taskData = self:_GetTaskData(taskTid)
  if taskCfg.CompleteCond == "DailyChallengeGlobalRoundsLeft" then
    local totalRound = taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[1] or 0
    local curStageData = WorldStageManager.Instance:GetCurStageData()
    local curRound = curStageData and curStageData.stats and curStageData.stats.BoutCount or 0
    local leftRound = math.max(0, totalRound - curRound)
    local isOk = leftRound > 0
    return leftRound, isOk
  end
  if taskCfg.CompleteCond == "DailyChallengeDesignationAwaker" then
    local specialAwakerCount = taskData and taskData.count or 0
    local isOk = specialAwakerCount > 0
    return specialAwakerCount, isOk
  end
  if taskCfg.CompleteCond == "DailyChallengeFirstScore" then
    local count = taskData and taskData.count or 0
    local isOk = 1 == count
    return count, isOk
  end
  if taskCfg.CompleteCond == "DailyResurrectionDeductPoints" then
    local curStageData = WorldStageManager.Instance:GetCurStageData()
    return curStageData and curStageData.respawnedNum or 0, nil
  end
  return taskData and taskData.count or 0
end

return DailyChallengeDescPanel
