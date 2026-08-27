local base = require("Game.ActivityFrame.ActTermTaskData")
local ActTermTaskDataOne = class("ActTermTaskDataOne", base)

function ActTermTaskDataOne:InitTermTask(frameId)
  base.InitTermTask(self, frameId)
  self._taskIds = ConfigData.activity_general[frameId].once_quest
end

function ActTermTaskDataOne:GetTermTaskStageCount()
  return 1
end

function ActTermTaskDataOne:GetTermTaskIds(term)
  return self._taskIds
end

function ActTermTaskDataOne:GetTermOpenTime(term)
  return 0
end

function ActTermTaskDataOne:IsExitInTermTask(taskId)
  return table.contain(self._taskIds, taskId)
end

return ActTermTaskDataOne
