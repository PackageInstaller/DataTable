local TaskState = CommonDefine.TaskState
local MAX_REWARD_NUM = 3
local BP_EXP_ITEM_TID = DT.GetConstant("BPExpItemTid")
local CompGuideNoteTaskItem, Super = NewViewComponent("CompGuideNoteTaskItem")

function CompGuideNoteTaskItem:ctor(uiNode, view, uid, taskSvrIndex)
  Super.ctor(self, uiNode, view)
  self.ui = UIBaseResource(uiNode)
  self.uid = uid
  self.taskSvrIndex = taskSvrIndex
  local taskData = TaskDataUtils.GetTaskData(self.uid)
  if taskData and taskData.tid then
    self.tid = taskData.tid
  else
    self.tid = 0
  end
end

function CompGuideNoteTaskItem:RegisterEvents()
  self:BindEvent(EventMgr.Instance.TaskViewUpdate, System.fn(self, self._OnTaskViewUpdate))
end

function CompGuideNoteTaskItem:_OnTaskViewUpdate(taskSvrIdx)
  if taskSvrIdx and self.taskSvrIndex and taskSvrIdx ~= self.taskSvrIndex then
    return
  end
  self:_RefreshUIState()
end

function CompGuideNoteTaskItem:OnEnterComponent()
  self:_InitUIElements()
  self:_RefreshUIState()
end

function CompGuideNoteTaskItem:_InitUIElements()
  self:AddButtonClickListener(self.ui.Btn_Get, System.fn(self, self.OnReceiveClick))
  self:AddButtonClickListener(self.ui.Image_Location, System.fn(self, self.OnLocationClick))
  self:SetText(self.ui.Text_Task, LT.Text(TaskDataUtils.GetTaskDesc(self.tid)))
  self:_OnBindRewards()
end

function CompGuideNoteTaskItem:_RefreshUIState()
  local newState = self:_GetDisplayTaskState()
  self:SetText(self.ui.Text_Progress, LT.Text(BpTaskModel.Instance:GetTaskProgress(self.uid)))
  self:SetActive(self.ui.Btn_Get, newState == TaskState.Receive)
  self:SetActive(self.ui.Image_Location, self:CheckBtnLocationState())
  self:SetActive(self.ui.Group_Over, newState == TaskState.Done)
  if self.ui.RedDot then
    self:SetActive(self.ui.RedDot, newState == TaskState.Receive)
  end
end

function CompGuideNoteTaskItem:_IsGuideNoteActivityFull()
  if not GuideNoteModel or not GuideNoteModel.Instance then
    return false
  end
  local rewardLevelType, tierRewardConstKey
  if self.taskSvrIndex == CommonDefine.TaskServerIndex.Daily then
    rewardLevelType = GuideNoteDefine.LevelType.Daily
    tierRewardConstKey = "GuideNoteDailyActivityTierRewards"
  elseif self.taskSvrIndex == CommonDefine.TaskServerIndex.Weekly then
    rewardLevelType = GuideNoteDefine.LevelType.Weekly
    tierRewardConstKey = "GuideNoteWeeklyActivityTierRewards"
  else
    return false
  end
  local maxNeed = 0
  local raw = DT.GetOriginalConstant(tierRewardConstKey, {}) or {}
  for i = 1, #raw, 2 do
    local need = tonumber(raw[i]) or 0
    if maxNeed < need then
      maxNeed = need
    end
  end
  return maxNeed > 0 and maxNeed <= GuideNoteModel.Instance:GetActivityExp(rewardLevelType)
end

function CompGuideNoteTaskItem:_GetDisplayTaskState()
  if self:_IsGuideNoteActivityFull() then
    return TaskState.Done
  end
  do return BpTaskModel.Instance.GetTaskState, BpTaskModel.Instance end
  return BpTaskModel.Instance.GetTaskState, BpTaskModel.Instance, self.uid
end

function CompGuideNoteTaskItem:_OnBindRewards()
  local sourceRewardGroup = TaskDataUtils.GetTaskCompleteAward(self.tid) or {}
  local rewardGroup = {}
  local isDoubleEx = BattlePassDataUtils.IsDoubleEx()
  for i = 1, #sourceRewardGroup do
    local rewardInfo = sourceRewardGroup[i]
    rewardInfo.sortIndex = i
    table.insert(rewardGroup, rewardInfo)
    if isDoubleEx and rewardInfo.tid == BP_EXP_ITEM_TID then
      local doubleRewardInfo = table.clone(rewardInfo)
      doubleRewardInfo.isDouble = true
      doubleRewardInfo.sortIndex = i
      table.insert(rewardGroup, doubleRewardInfo)
    end
  end
  local High, Middle, Low = 1, 2, 3
  
  local function getWeight(rewardInfo)
    if rewardInfo.tid == BP_EXP_ITEM_TID then
      return rewardInfo.isDouble and High or Middle
    end
    return Low + (rewardInfo.sortIndex or 0)
  end
  
  table.sort(rewardGroup, function(a, b)
    return getWeight(a) < getWeight(b)
  end)
  for i = 1, MAX_REWARD_NUM do
    local itemObj = self.ui["Reward_" .. MAX_REWARD_NUM - i + 1]
    self:SetActive(itemObj, i <= #rewardGroup)
    if i <= #rewardGroup then
      local rewardInfo = rewardGroup[i]
      local itemId = rewardInfo.tid
      local itemNum = rewardInfo.num
      
      local function clickFunc()
        ItemDataUtils.ShowItemDetailTips(self.binder, itemObj, nil, itemId, true)
      end
      
      local viewData = {
        itemTid = itemId,
        itemCount = itemNum,
        clickFunc = clickFunc
      }
      if rewardInfo.isDouble then
        viewData.extraDesc = LT.Text("DoubleExperience_02")
      end
      self:AddViewComponentOnce(itemObj, CompPublicIconItemType2, viewData)
    end
  end
end

function CompGuideNoteTaskItem:OnReceiveClick()
  if self:_IsGuideNoteActivityFull() then
    return
  end
  local weeklyExp = BattlePassDataUtils.GetWeeklyExp()
  local weeklyLimit = DT.GetConstant("BPExpWeeklyLimit")
  local taskCfg = TaskDataUtils.GetConfig(self.tid)
  local taskType = taskCfg and taskCfg.TaskType or nil
  Logger.Debug("[CompGuideNoteTaskItem] OnReceiveClick uid =", self.uid, "tid =", self.tid, "weeklyExp =", weeklyExp, "weeklyLimit =", weeklyLimit, "taskCfg.TaskType =", taskType or "nil")
  if weeklyExp >= weeklyLimit and taskType and taskType ~= CommonDefine.TaskType.TaskType_Period then
    Logger.Debug("[CompGuideNoteTaskItem] OnReceiveClick 已达周经验上限，拦截领奖")
    Alert.ShowStr(LT.Text("BPExpWeeklyLimitTxt"))
  end
  local taskSvrIdx = self.taskSvrIndex or 0
  Logger.Debug("[CompGuideNoteTaskItem] OnReceiveClick taskSvrIdx =", taskSvrIdx)
  if taskSvrIdx == CommonDefine.TaskServerIndex.Daily or taskSvrIdx == CommonDefine.TaskServerIndex.Weekly then
    Logger.Debug("[CompGuideNoteTaskItem] OnReceiveClick ReqOnTaskGainAllPrize taskSvrIdx =", taskSvrIdx)
    TaskController.Instance:ReqOnTaskGainAllPrize(taskSvrIdx)
  else
    Logger.Debug("[CompGuideNoteTaskItem] OnReceiveClick TaskComplete uid =", self.uid)
    TaskDataUtils.TaskComplete(self.uid)
  end
end

function CompGuideNoteTaskItem:OnLocationClick()
  FuncJumpManager.Instance:JumpFunc(TaskDataUtils.GetTaskJumpTo(self.tid))
end

function CompGuideNoteTaskItem:CheckBtnLocationState()
  local taskCfg = DT.Task[self.tid]
  if self:_GetDisplayTaskState() == TaskState.Doing then
    return taskCfg and taskCfg.JumpTo and taskCfg.JumpTo[1] or false
  end
  return false
end

return CompGuideNoteTaskItem
