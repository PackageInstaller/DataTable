local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local ActivitySubplotComp, Super = System.NewClass("ActivitySubplotComp", ActivityBaseComp)

function ActivitySubplotComp:ctor(res, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Events_Panel_BranchResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.prizePreviewList = {}
  self.stageGroupTids = self:_GetStageGroupTids(activityTid)
end

function ActivitySubplotComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:_BindActivityTimer()
  binder:BindToImageSync(self.ui.Image_Map, System.fn(self, self._GetBgImage))
  local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
  binder:SetText(self.ui.Text_Mock, activityName)
  local unlockConditionDesc = ActivityDataUtils.GetUnlockConditionDesc(self.activityTid)
  binder:SetText(self.ui.Text_Condition, unlockConditionDesc)
  local activityPlotInfo = ActivityDataUtils.GetActivityPlot(self.activityTid)
  binder:SetText(self.ui.Text_Info, activityPlotInfo)
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetPrizePreviewList), System.fn(self, self._UpdatePrizeItem))
  binder:BindToVisible(self.ui.UI_Common_Btn_Level1, System.fn(self, self._HasUnlocked))
  binder:BindToVisible(self.ui.Text_Over, System.fn(self, self._HasGotAllPrize))
  binder:BindToVisible(self.ui.Text_Title, function()
    return not self:_HasGotAllPrize()
  end)
  binder:BindToVisible(self.ui.Disable, function()
    return not self:_HasUnlocked()
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Level1, System.fn(self, self._OnClickChallenge), nil, function()
    do return LT.Text end
    return LT.Text, "SubplotJumpButton"
  end)
  binder:SetText(self.ui.Text_Limit_Free, LT.Text("SubplotFreeTips"))
  self:_BindPassReward(binder)
  self:_BindStageReward(binder)
  self:_BindPortraitComp()
end

function ActivitySubplotComp:_GetBgImage()
  do return ActivityDataUtils.GetBgImage end
  return ActivityDataUtils.GetBgImage, self.activityTid
end

function ActivitySubplotComp:_GetStageGroupTids(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  return config and config.ActivityPara1 or {}
end

function ActivitySubplotComp:_HasUnlocked()
  if not self.activityData then
    return false
  end
  do return self.model.CheckCondition, self.model end
  return self.model.CheckCondition, self.model, self.activityData
end

function ActivitySubplotComp:_HasGotAllPrize()
  if not self.stageGroupTids or not self:_HasUnlocked() then
    return false
  end
  for _, stageGroupTid in pairs(self.stageGroupTids) do
    local hasGotAllPrize = MainCopyDataUtils.HasGotAllSubplotPrize(stageGroupTid)
    if not hasGotAllPrize then
      return false
    end
  end
  return true
end

function ActivitySubplotComp:_GetPrizePreviewList()
  local config = ActivityDataUtils.GetConfig(self.activityTid)
  if config and config.RewardPreview then
    self.prizePreviewList = config.RewardPreview
  end
  return self.prizePreviewList
end

function ActivitySubplotComp:_UpdatePrizeItem(childBinder, go, index)
  local tid = self.prizePreviewList[index]
  local itemData = {itemTid = tid}
  childBinder:BindComponent(CommonIconItemType2(go, itemData))
end

function ActivitySubplotComp:_OnClickChallenge()
  if not self.stageGroupTids then
    return
  end
  local targetGroupTid
  local LargeSubplotNormal = CommonDefine.StageGroupType.LargeSubplotNormal
  local SmallSubplotNormal = CommonDefine.StageGroupType.SmallSubplotNormal
  for _, stageGroupTid in ipairs(self.stageGroupTids) do
    if stageGroupTid then
      local config = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
      if config and (config.Type == SmallSubplotNormal or config.Type == LargeSubplotNormal) then
        targetGroupTid = stageGroupTid
        break
      end
    end
  end
  if nil ~= targetGroupTid then
    if CopyDataUtils.IsStageGroupNeedUnlockItem(targetGroupTid) then
      local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(targetGroupTid)
      if not hasUseUnlockItem then
        local hasOpenningSubplotActivity = ActivityManager.Instance:HasOpeningSubplotActivity(targetGroupTid)
        if hasOpenningSubplotActivity then
          CopyDataUtils.ReqUnlockStageGroup(targetGroupTid, true)
        end
      end
    end
    CopyDataUtils.OpenSubPlotGroupPanel(targetGroupTid)
  end
end

function ActivitySubplotComp:OnUnbind()
end

function ActivitySubplotComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_Try_Open", callback)
end

function ActivitySubplotComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_Try_Close", callback)
end

function ActivitySubplotComp:_SetActive(isActive)
  local uiNode = self.ui and self.ui.uiNode
  local binder = self.binder
  if not uiNode or not binder then
    return
  end
  binder:SetActive(uiNode, isActive)
end

function ActivitySubplotComp:_BindPassReward(binder)
  local activityCfg = DT.Activity[self.activityTid]
  local taskTid = activityCfg.ActivityPara2
  if taskTid then
    local taskData = self.activityData.taskList[taskTid]
    if taskData then
      self.ui.Image_Pass_Award:SetActive(true)
      local taskCfg = DT.Task[taskData.tid]
      local awardTid = taskCfg.CompleteAward[1]
      local awardCfg = DT.Item[awardTid]
      binder:SetImage(self.ui.Image_Icon_2, awardCfg.Icon)
      binder:BindToRaw(function(_, state)
        local progress = state == CommonDefine.TaskCommonState.Running and 0 or 1
        binder:SetText(self.ui.Text_Clearance, string.format("（%s/1）", progress))
        self.ui.Com_RedDot_2:SetActive(state == CommonDefine.TaskCommonState.CanFinish)
        self.ui.Image_Finish:SetActive(state == CommonDefine.TaskCommonState.Finish)
      end, function()
        return taskData.state
      end)
      binder:BindZ1Button(self.ui.Btn_Pass_1, function()
        if taskData.state == CommonDefine.TaskCommonState.CanFinish then
          self:_OnGainPrize(taskData)
          return
        end
        UIManager.Instance:Reopen(Urls.ActivitySubplotPassTaskPanel, taskData, self.activityData.endTime, function()
          if not self:_HasUnlocked() then
            local unlockDesc = ActivityDataUtils.GetUnlockConditionDesc(self.activityTid)
            Alert.ShowStr(unlockDesc)
          else
            self:_OnClickChallenge()
          end
        end)
      end)
    else
      self.ui.Image_Pass_Award:SetActive(false)
    end
  else
    self.ui.Image_Pass_Award:SetActive(false)
  end
end

function ActivitySubplotComp:_BindStageReward(binder)
  local activityCfg = DT.Activity[self.activityTid]
  local taskTidList = activityCfg.ActivityPara3
  if taskTidList and #taskTidList > 0 then
    self.ui.Image_Limit_Award:SetActive(true)
    binder:BindToRaw(function(_, finishCount)
      local totalCount = #taskTidList
      binder:SetText(self.ui.Text_Stage, string.format("（%s/%s）", finishCount, totalCount))
    end, function()
      local finishCount = 0
      local taskList = self.activityData.taskList
      for _, taskTid in ipairs(taskTidList) do
        local taskData = taskList[taskTid]
        if taskData and taskData.state ~= CommonDefine.TaskCommonState.Running then
          finishCount = finishCount + 1
        end
      end
      return finishCount
    end)
    binder:BindToRaw(function(_, show)
      self.ui.Com_RedDot_1:SetActive(show)
    end, function()
      local taskList = self.activityData.taskList
      for _, taskTid in ipairs(taskTidList) do
        local taskData = taskList[taskTid]
        if taskData and taskData.state == CommonDefine.TaskCommonState.CanFinish then
          return true
        end
      end
      return false
    end)
    binder:BindToRaw(function(_, finishCount)
      local totalCount = #taskTidList
      self.ui.Image_Finish_1:SetActive(finishCount == totalCount)
    end, function()
      local finishCount = 0
      local taskList = self.activityData.taskList
      for _, taskTid in ipairs(taskTidList) do
        local taskData = taskList[taskTid]
        if taskData and taskData.state == CommonDefine.TaskCommonState.Finish then
          finishCount = finishCount + 1
        end
      end
      return finishCount
    end)
    binder:BindZ1Button(self.ui.Btn_Limit_1, function()
      UIManager.Instance:Reopen(Urls.ActivitySubplotStageTaskPanel, taskTidList, self.activityData.taskList, self.activityData.endTime, function(taskData)
        self:_OnGainPrize(taskData)
      end)
    end)
  else
    self.ui.Image_Limit_Award:SetActive(false)
  end
end

function ActivitySubplotComp:_OnGainPrize(taskData)
  if not taskData then
    return
  end
  local taskListActivityData = self.activityData
  local taskListActivityBaseData = taskListActivityData and taskListActivityData.base or {}
  if taskListActivityBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  if taskData.state ~= CommonDefine.TaskCommonState.CanFinish then
    return
  end
  
  local function ToReqGainAward(extraParams, onRequestCallback)
    extraParams = extraParams or {}
    ActivityDataUtils.ReqGainAward(self.activityTid, taskData.tid, extraParams, function(result)
      if result then
        taskListActivityData.taskList[taskData.tid].state = CommonDefine.TaskCommonState.Finish
        ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
        if onRequestCallback then
          onRequestCallback()
        end
      end
    end, true)
  end
  
  local taskConfig = DT.Task[taskData.tid]
  
  local function GainPrize()
    if taskConfig and taskConfig.CompleteAward then
      ToReqGainAward()
    end
  end
  
  if GetEnergyCheckUtils.TaskConfigCheckEnergyOver(taskConfig) then
    GetEnergyCheckUtils.TipsShow(GainPrize)
  else
    GainPrize()
  end
end

return ActivitySubplotComp
