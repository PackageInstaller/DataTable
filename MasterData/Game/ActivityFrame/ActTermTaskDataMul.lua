local base = require("Game.ActivityFrame.ActTermTaskData")
local ActTermTaskDataMul = class("ActTermTaskDataMul", base)

function ActTermTaskDataMul:InitTermTask(frameId)
  base.InitTermTask(self, frameId)
  local taskIds = ConfigData.activity_general[frameId].once_quest
  self._cfgs = ConfigData.activity_general_term_task[frameId]
  if taskIds[1] ~= nil then
    self._firstTaskIds = {}
    table.insertto(self._firstTaskIds, taskIds)
    table.insertto(self._firstTaskIds, self._cfgs[1].task)
  end
end

function ActTermTaskDataMul:GetTermTaskStageCount()
  if self._stageCount == nil then
    self._stageCount = #self._cfgs
  end
  return self._stageCount
end

function ActTermTaskDataMul:GetTermTaskIds(term)
  if term == 1 and self._firstTaskIds ~= nil then
    return self._firstTaskIds
  end
  local cfg = self._cfgs[term]
  if cfg == nil then
    return nil
  end
  return cfg.task
end

function ActTermTaskDataMul:GetTermOpenTime(term)
  local cfg = self._cfgs[term]
  if cfg == nil then
    return 0
  end
  return cfg.start_time
end

function ActTermTaskDataMul:IsExitInTermTask(taskId)
  for i = 1, self:GetTermTaskStageCount() do
    if self:GetTermOpenTime(i) > PlayerDataCenter.timestamp then
      break
    end
    local tasks = self:GetTermTaskIds(i)
    if table.contain(tasks, taskId) then
      return true
    end
  end
  return false
end

return ActTermTaskDataMul
