local this = class("conditionNode_2007", require(L_R.condition .. "conditionNode"))
local _taskTpl = L_GameTpl:getTaskTpl()

function this:ctor(condition)
  this.super.ctor(self, condition)
  self._refreshTaskHandler = self._refreshTaskHandler or handler(self, self.taskRefresh)
  AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
end

function this:onDestroy()
  this.super.onDestroy(self)
  if self._refreshTaskHandler then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
    self._refreshTaskHandler = nil
  end
end

function this:taskRefresh(type, list)
  self:refresh()
end

function this.checkFunc(condition)
  local taskId = condition[2]
  local taskTpl = _taskTpl:getTplById(taskId)
  if not taskTpl then
    return false
  end
  local isFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
  return isFinish
end

function this.descFunc(key, codData)
  local taskId = codData[2]
  local taskTpl = _taskTpl:getTplById(taskId)
  if not taskTpl then
    return ""
  end
  local taskName = _taskTpl:getName(taskTpl)
  return L_Lang:get(key, {name = taskName})
end

return this
