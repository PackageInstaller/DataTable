local PVPSeasonTaskItem, Super = System.NewComponent("PVPSeasonTaskItem")

function PVPSeasonTaskItem:ctor(obj, taskTid, preTaskTid, nextTaskTid, accWinCount, clickCallback)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_VictoryResource(obj)
  self.taskTid = taskTid
  self.preTaskTid = preTaskTid
  self.nextTaskTid = nextTaskTid
  self.accWinCount = accWinCount
  self.clickCallback = clickCallback
end

function PVPSeasonTaskItem:OnBind(binder)
  self.binder = binder
  self:SetTaskAward()
  self:SetTaskState()
end

function PVPSeasonTaskItem:SetTaskAward()
  local taskCfg = DT.Task[self.taskTid] or {}
  local awardId = table.unpack(taskCfg.CompleteAward or {})
  local taskData = TaskDataUtils.GetTaskData(self.taskTid) or {}
  if awardId then
    local awakerItemData = {
      itemTid = awardId,
      isGot = taskData.state == CommonDefine.TaskState.Done,
      tipPosY = -600
    }
    if self.clickCallback then
      function awakerItemData.clickFunc()
        if self.clickCallback then
          self.clickCallback(self.taskTid)
        end
      end
    end
    self.binder:BindComponent(CommonIconItemType2(self.ui.UI_Common_Item_WuPin_Type2, awakerItemData))
    self.ui.Effect_VX:SetActive(taskData.state == CommonDefine.TaskState.Receive)
  end
  self.binder:SetText(self.ui.Text_Victory, LT.Text(taskCfg.Name or ""))
end

function PVPSeasonTaskItem:SetTaskState()
  local curTaskData = TaskDataUtils.GetTaskData(self.taskTid)
  local preTaskData = self.preTaskTid and TaskDataUtils.GetTaskData(self.preTaskTid)
  local nextTaskData = self.nextTaskTid and TaskDataUtils.GetTaskData(self.nextTaskTid)
  self.ui.Image_Finish:SetActive(true)
  self.ui.Image_Finish_Next:SetActive(false)
  self:SetProgress(curTaskData, preTaskData, nextTaskData)
end

function PVPSeasonTaskItem:SetProgress(curTaskData, preTaskData, nextTaskData)
  local startFillAmount = 0
  local fillAmount = startFillAmount
  local preCount, curCount, nextCount = self:GetTaskCount()
  if curTaskData and curTaskData.state >= CommonDefine.TaskState.Receive then
    startFillAmount = 0.555
    if not nextTaskData or nextTaskData.state >= CommonDefine.TaskState.Receive then
      fillAmount = 1
    else
      fillAmount = startFillAmount + (self.accWinCount - curCount) / (nextCount - curCount) / 2
    end
  else
    startFillAmount = 0
    if not preTaskData then
    end
    if preTaskData then
      local miniStartFillAmount = 0
      if preTaskData.state >= CommonDefine.TaskState.Receive then
        fillAmount = startFillAmount + (self.accWinCount - preCount) / (curCount - preCount) / 2
      else
        fillAmount = startFillAmount
      end
      fillAmount = math.max(miniStartFillAmount, fillAmount)
    end
  end
  self.binder:SetImageFillAmount(self.ui.Image_Finish, math.min(1, fillAmount))
end

function PVPSeasonTaskItem:GetTaskCount()
  local curTaskCfg = DT.Task[self.taskTid]
  local curCount = curTaskCfg.CompleteCondPara and curTaskCfg.CompleteCondPara[1] or 0
  local preTaskCfg = DT.Task[self.preTaskTid] or {}
  local preCount = preTaskCfg.CompleteCondPara and preTaskCfg.CompleteCondPara[1] or curCount
  local preHalfCount = curCount - (curCount - preCount) / 2
  local nextTaskCfg = DT.Task[self.nextTaskTid] or {}
  local nextCount = nextTaskCfg.CompleteCondPara and nextTaskCfg.CompleteCondPara[1] or curCount
  local nextHalfCount = curCount + (nextCount - curCount) / 2
  return preHalfCount, curCount, nextHalfCount
end

return PVPSeasonTaskItem
