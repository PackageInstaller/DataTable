local TaskState = CommonDefine.TaskState
local MAX_REWARD_NUM = 2
local CompBpTaskItem, Super = NewViewComponent("CompBpTaskItem")

function CompBpTaskItem:ctor(uiNode, view, uid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Passport_Task_DescriptionResource(uiNode)
  self.uid = uid
  local taskData = TaskDataUtils.GetTaskData(self.uid)
  self.tid = taskData and taskData.tid or 0
end

function CompBpTaskItem:OnEnterComponent()
  self:_InitUIElements()
  self:_RefreshUIState()
end

function CompBpTaskItem:_InitUIElements()
  self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self.OnReceiveClick))
  self:SetButtonState(self.ui.Btn_Receive, CommonDefine.BtnType.Normal)
  self:AddButtonClickListener(self.ui.Btn_Location, System.fn(self, self.OnLocationClick))
  self:SetText(self.ui.Text_Desc, LT.Text(TaskDataUtils.GetTaskDesc(self.tid)))
  self.countDownTimer = self:BindTimer(1, -1, function()
    if self and self.ui and self.ui.Text_Time then
      self:SetText(self.ui.Text_Time, BpTaskModel.Instance:GetTaskCountDown(self.uid))
    end
  end)
  self:_OnBindRewards()
end

function CompBpTaskItem:_RefreshUIState()
  local newState = BpTaskModel.Instance:GetTaskState(self.uid)
  self:SetText(self.ui.Text_Count, LT.Text(BpTaskModel.Instance:GetTaskProgress(self.uid)))
  self:SetActive(self.ui.Btn_Receive, newState == TaskState.Receive)
  self:SetActive(self.ui.Btn_Location, self:CheckBtnLocationState())
  self:SetActive(self.ui.Image_State, newState == TaskState.Done)
  self:SetActive(self.ui.Group_Tab_Special, BpTaskModel.Instance:GetTaskCountDown(self.uid) ~= "")
  self:SetActive(self.ui.Notclaimed, newState ~= TaskState.Done)
  self:SetActive(self.ui.Toclaim, newState == TaskState.Done)
end

function CompBpTaskItem:_OnBindRewards()
  local rewardGroup = TaskDataUtils.GetTaskCompleteAward(self.tid)
  if BattlePassDataUtils.IsDoubleEx() then
    for i = 1, #rewardGroup do
      local itemInfo = table.clone(rewardGroup[i])
      itemInfo.isDouble = true
      table.insert(rewardGroup, itemInfo)
    end
  end
  for i = 1, MAX_REWARD_NUM do
    local itemObj = self.ui["Article_" .. i]
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

function CompBpTaskItem:OnReceiveClick()
  if BattlePassDataUtils.GetWeeklyExp() >= DT.GetConstant("BPExpWeeklyLimit") and DT.Task[self.tid].TaskType ~= CommonDefine.TaskType.TaskType_Period then
    Alert.ShowStr(LT.Text("BPExpWeeklyLimitTxt"))
  end
  TaskDataUtils.TaskComplete(self.uid)
end

function CompBpTaskItem:OnLocationClick()
  FuncJumpManager.Instance:JumpFunc(TaskDataUtils.GetTaskJumpTo(self.tid))
end

function CompBpTaskItem:CheckBtnLocationState()
  local taskCfg = DT.Task[self.tid]
  if BpTaskModel.Instance:GetTaskState(self.uid) == TaskState.Doing then
    return taskCfg and taskCfg.JumpTo and taskCfg.JumpTo[1] or false
  end
  return false
end

function CompBpTaskItem:OnExitComponent()
  if self.countDownTimer then
    self:StopTimer(self.countDownTimer)
    self.countDownTimer = nil
  end
  Super.OnExitComponent(self)
end

return CompBpTaskItem
