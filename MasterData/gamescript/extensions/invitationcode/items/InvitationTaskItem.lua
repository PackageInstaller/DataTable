local InvitationTaskItem, Super = NewClass("InvitationTaskItem", ViewComponent)
local UIAnimationController = typeof(CS.Z1Client.UIAnimationController)

function InvitationTaskItem:ctor(uiNode, view, taskId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_InvitationCode_Item_AwardResource(uiNode)
  self.taskId = taskId
end

function InvitationTaskItem:RegisterNotifications()
end

function InvitationTaskItem:RegisterEvents()
  self:BindEvent(EventMgr.Instance.TaskInfoUpdated, System.fn(self, self.UpdateTaskState))
end

function InvitationTaskItem:OnBuildComponent()
  Super.OnBuildComponent(self)
end

function InvitationTaskItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:UpdateTaskState()
end

function InvitationTaskItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function InvitationTaskItem:GetRewardTidAndCount()
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(self.taskId)
  local rewardInfo = taskCfg.CompleteAward
  local rewardTid = rewardInfo[1]
  local rewardCount = rewardInfo[2]
  return rewardTid, rewardCount
end

function InvitationTaskItem:GetNeedCount()
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(self.taskId)
  return taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[1] or 0
end

function InvitationTaskItem:SetRewardItem()
  local rewardTid, rewardCount = self:GetRewardTidAndCount()
  local viewData = {
    itemTid = rewardTid,
    itemCount = rewardCount,
    clickFunc = System.fn(self, self.OnClickReward),
    isGot = TaskDataUtils.TaskFinshAndGetedAward(self.taskId),
    isShowRing = TaskDataUtils.IsCanGetRward(self.taskId)
  }
  self:AddViewComponentOnce(self.ui.rewardItem, CompPublicIconItemType2, viewData)
  self:SetText(self.ui.Text_Count, self:GetNeedCount())
end

function InvitationTaskItem:UpdateTaskState()
  local isTaskDone = TaskDataUtils.IsTaskDoneByTaskId(self.taskId)
  local isTaskGot = TaskDataUtils.TaskFinshAndGetedAward(self.taskId)
  self:SetActive(self.ui.State_Get, isTaskDone)
  self:SetActive(self.ui.Image_Mask, isTaskGot)
  local progress = isTaskDone and 100 or 0
  self:SetImageFillAmount(self.ui.Image_Progress, progress)
  self:SetRewardItem()
end

function InvitationTaskItem:OnClickReward()
  local isCanGet = TaskDataUtils.IsCanGetRward(self.taskId)
  if not isCanGet then
    local itemTid = self:GetRewardTidAndCount()
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, itemTid)
    return
  end
  self:ReqReward()
end

function InvitationTaskItem:ReqReward()
  TaskDataUtils.TaskComplete(self.taskId, nil, false)
end

return InvitationTaskItem
