local this = class("gameEventManager", G_EventManagerBase)

function this:ctor()
  this.super.ctor(self)
end

function this:initialize()
  self.onTaskCompleteHandle = self.onTaskCompleteHandle or handler(self, self.onTaskComplete)
  AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.TaskServerTaskDeleteSync, self.onTaskCompleteHandle)
end

function this:dispose()
  if self.onTaskCompleteHandle ~= nil then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.TaskServerTaskDeleteSync, self.onTaskCompleteHandle)
  end
end

function this:onTaskComplete(type, deleteList)
  L_GameEventStore:onEventTaskAllExecuteOver(type, deleteList)
end

return this
