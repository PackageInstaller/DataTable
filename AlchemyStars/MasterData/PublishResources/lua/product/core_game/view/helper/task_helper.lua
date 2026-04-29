_class("TaskHelper", Singleton)
TaskHelper = TaskHelper

function TaskHelper:Constructor()
  self._taskList = {}
  self._exceptionTaskList = {}
end

function TaskHelper:IsAllTaskFinished(taskIDs, notCheckTimeOut)
  if not taskIDs then
    return true
  end
  for _, taskID in ipairs(taskIDs) do
    if not self:IsTaskFinished(taskID, notCheckTimeOut) then
      return false
    end
  end
  return true
end

function TaskHelper:IsTaskFinished(taskID, notCheckTimeOut)
  if taskID and type(taskID) ~= "number" then
    Log.fatal("TaskID Type Invalid ", Log.traceback())
  end
  local task = TaskManager:GetInstance():FindTask(taskID)
  if task ~= nil then
    if not notCheckTimeOut then
      local timeNow = GameGlobal:GetInstance():GetCurrentTime()
      if not self._taskList[taskID] then
        self._taskList[taskID] = timeNow
      end
      if timeNow - self._taskList[taskID] > BattleConst.CoroutineMaxWaitTime and not self._exceptionTaskList[taskID] then
        self._exceptionTaskList[taskID] = 1
        if EDITOR then
          Log.exception("Coroutine ", taskID, "  Wait TimeOut Trace: ", Log.traceback())
        else
          Log.fatal("Coroutine ", taskID, "  Wait TimeOut Trace: ", Log.traceback())
        end
      end
    end
    return false
  else
    if not notCheckTimeOut and self._taskList[taskID] then
      if self._exceptionTaskList[taskID] then
        local timeNow = GameGlobal:GetInstance():GetCurrentTime()
        local duration = timeNow - self._taskList[taskID]
        Log.fatal("Coroutine :", taskID, " Wait TimeOut  DurationTime:", duration, " Trace:", Log.traceback())
        self._exceptionTaskList[taskID] = nil
      end
      self._taskList[taskID] = nil
    end
    return true
  end
end
