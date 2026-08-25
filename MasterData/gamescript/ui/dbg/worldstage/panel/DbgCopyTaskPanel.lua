local UIAnimationController = CS.Z1Client.UIAnimationController
local DbgCopyTaskPanel, Super = System.NewClass("DbgCopyTaskPanel", UIBasePanel)
DbgCopyTaskPanel.uiResCls = UI_Dbgcopy_Item_TaskResource

function DbgCopyTaskPanel:ctor(taskList)
  Super.ctor(self)
  self.taskList = Vue.reactive(taskList)
end

function DbgCopyTaskPanel:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.Image_Task:GetComponent(typeof(UIAnimationController))
  local isFold = MobileFileDataManager.Instance:GetPlayerFileValue(CommonDefine.LocalSaveKey.DbgCopyTaskFold, false)
  if isFold then
    self:FoldTask()
  else
    self:UnFoldTask()
  end
  binder:BindButtonClick(self.ui.Btn_Harvest, function()
    self:FoldTask()
  end)
  binder:BindButtonClick(self.ui.Btn_Sheet, function()
    self:UnFoldTask()
  end)
  binder:BindToRaw(function(binder, isAllComplete, old)
    if isAllComplete then
      self:Close()
    end
  end, function()
    do return self.IsAllComplete end
    return self.IsAllComplete, self
  end)
  binder:BindToText(self.ui.Text_level_1, function()
    do return self.GetProgressContent end
    return self.GetProgressContent, self
  end)
  binder:BindToText(self.ui.Text_level_2, function()
    do return self.GetProgressContent end
    return self.GetProgressContent, self
  end)
  binder:BindToText(self.ui.Text_Title, function()
    do return self.GetCurTaskName end
    return self.GetCurTaskName, self
  end)
  binder:BindToText(self.ui.Text_Introduce, function()
    do return self.GetCurTaskDesc end
    return self.GetCurTaskDesc, self
  end)
end

function DbgCopyTaskPanel:FoldTask()
  self.uiAnimController:PlayState("UI_Dbgcopy_Image_Task_Bg_Withdraw")
  MobileFileDataManager.Instance:SetPlayerFileValue(CommonDefine.LocalSaveKey.DbgCopyTaskFold, true)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
end

function DbgCopyTaskPanel:UnFoldTask()
  self.uiAnimController:PlayState("UI_Dbgcopy_Image_Task_Bg_Gold")
  MobileFileDataManager.Instance:SetPlayerFileValue(CommonDefine.LocalSaveKey.DbgCopyTaskFold, false)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
end

function DbgCopyTaskPanel:GetCurTaskId()
  local TaskState = CommonDefine.TaskState
  for _, v in pairs(self.taskList) do
    if not v.lock and (v.state == TaskState.UnDone or v.state == TaskState.Doing) then
      return v.tid
    end
  end
end

function DbgCopyTaskPanel:GetProgressContent()
  local finishCount = 0
  local totalCount = 0
  for i, v in pairs(self.taskList) do
    totalCount = totalCount + 1
    if v.state == CommonDefine.TaskState.Done and not v.lock then
      finishCount = finishCount + 1
    end
  end
  local curIndex = math.min(finishCount + 1, totalCount)
  do return string.format, "%s/%s", curIndex end
  return string.format, "%s/%s", curIndex, totalCount, nil, v.lock, CommonDefine.TaskState.Done
end

function DbgCopyTaskPanel:GetCurTaskCfg()
  local taskId = self:GetCurTaskId()
  local taskCfg = DT.Task[taskId]
  return taskCfg or {}
end

function DbgCopyTaskPanel:GetCurTaskDesc()
  local taskCfg = self:GetCurTaskCfg()
  return taskCfg.Desc
end

function DbgCopyTaskPanel:GetCurTaskName()
  local taskCfg = self:GetCurTaskCfg()
  return taskCfg.Name
end

function DbgCopyTaskPanel:IsAllComplete()
  for i, task in pairs(self.taskList) do
    if task.state ~= CommonDefine.TaskState.Done then
      return false
    end
  end
  return true
end

return DbgCopyTaskPanel
