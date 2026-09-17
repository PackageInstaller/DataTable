local this = class("gameActivityTaskGE", L_GameEventStore.baseGameEventCls)
local _GameEventNoviceTpl = L_GameTpl:getGameEventsNoviceTpl()

function this:initData()
  self.data.cur_order = 0
  self.data.finish = false
  self.hasSyncEventData = false
end

function this:populate(protoData)
  local data = protoData.daily_task
  self.data.cur_order = data.cur_order or self.data.cur_order
  self.data.finish = data.finish or self.data.finish
end

function this:getData()
  return self.data
end

function this:isAllTaskFinish(systemId)
  local taskGroupData = _GameEventNoviceTpl:getTplBySystemId(systemId)
  for i, task in pairs(taskGroupData) do
    local taskId = _GameEventNoviceTpl:getTaskId(task)
    local taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
    if not taskFinish then
      return false
    end
  end
  return true
end

function this:tryOpenTaskPage()
  if not L_GameStore:isEntered() then
    return
  end
end

return this
