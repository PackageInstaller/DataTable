local this = class("conditionNode_3", require(L_R.condition .. "conditionNode"))

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
  AzurWorld.TaskMgr:HasExecuteTaskById(condition[2])
end

return this
