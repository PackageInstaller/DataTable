local base = require("ui/pages/task/moduleTaskInfoBase")
local this = class("moduleMainTaskInfo", base)
local _taskTpl = L_GameTpl:getTaskTpl()

function this:bind()
  return {
    txtName = "",
    activeName = false,
    txtNameOn = "",
    activeNameOn = false,
    txtMap = "",
    activeMap = false,
    targetList = {
      moduleName = "pages/task/cellTaskTargetInfo"
    },
    txtDes = "",
    activeSign = false,
    txtSign = "",
    selectedRewardTabId = 0,
    rewardList = L_Const.ModuleInfo.CellIconBag,
    activeRewardTab = false,
    activeRewardTitle = false,
    txtRewardTitle = "",
    activeReward = false,
    activeLimit = false,
    txtLimit = "",
    activePic = false,
    picTask = "",
    activeTraceIcon = false,
    activeNoTraceIcon = false
  }
end

function this:methods()
  return {
    onSelectRewardTab = function(self, tabId, a)
      self:onSelectRewardTab(tabId)
    end
  }
end

function this:playShowAnim()
  self.bindComponents.animation:Stop()
  if self.isShow then
    self.bindComponents.animation:Play("anim_task_m1_fresh")
  else
    self.bindComponents.animation:Play("anim_task_m1_switch")
  end
end

function this:refreshTaskByType(typeId)
  self.super.refreshTaskByType(self, typeId)
  local taskIds = AzurWorld.TaskMgr:GetTaskUIModule():GetCurTaskIdsByTabType(self.typeId)
  local taskId = taskIds[0]
  if taskId then
    self:refreshTask(taskId)
    return true
  end
  return false
end

function this:refreshTaskTraceInfo()
  local tplTask = _taskTpl:getTplById(self.taskId)
  if AzurWorld.TaskMgr:GetTraceTaskList():Contains(self.taskId) then
    self.bind.txtNameOn = _taskTpl:getName(tplTask)
    self.bind.activeName = false
    self.bind.activeNameOn = true
    self.bind.activeTraceIcon = true
    self.bind.activeNoTraceIcon = false
  else
    self.bind.txtName = _taskTpl:getName(tplTask)
    self.bind.activeName = true
    self.bind.activeNameOn = false
    self.bind.activeTraceIcon = false
    self.bind.activeNoTraceIcon = true
  end
end

function this:refreshTask(taskId)
  self.super.refreshTask(self, taskId)
  local tplTask = _taskTpl:getTplById(taskId)
  if tplTask == nil then
    return
  end
  local pic = _taskTpl:getPic(tplTask)
  if string.isEmpty(pic) then
    self.bind.activePic = false
  else
    self.bind.picTask = pic
    self.bind.activePic = true
  end
end

function this:showRewards(rewards)
  self.super.showRewards(self, rewards)
  self.bindComponents.content.localPosition = L_Vector3.zero
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.content)
end

return this
