local frameScheduler = {}
FrameScheduler = frameScheduler
frameScheduler._nextTaskId = 1
frameScheduler._frameCount = 0
frameScheduler._tasks = {}

function frameScheduler.add(taskFunc, delayFrameCount, param)
  if type(taskFunc) ~= "function" then
    errorf("Invalid param taskFunc")
    return
  end
  if delayFrameCount == nil then
    delayFrameCount = 1
  end
  local taskId = frameScheduler.fetchTaskId()
  frameScheduler._tasks[taskId] = {
    frame = frameScheduler._frameCount + delayFrameCount,
    func = taskFunc,
    param = param
  }
  return taskId
end

function frameScheduler.remove(taskId)
  frameScheduler._tasks[taskId] = nil
end

function frameScheduler.fetchTaskId()
  local ret = frameScheduler._nextTaskId
  frameScheduler._nextTaskId = frameScheduler._nextTaskId + 1
  return ret
end

function frameScheduler._errorHandler(msg)
  errorf(msg)
end

function frameScheduler.frameTick()
  for id, v in pairs(frameScheduler._tasks) do
    if v.frame <= frameScheduler._frameCount then
      xpcall(v.func, frameScheduler._errorHandler, v.param)
      frameScheduler._tasks[id] = nil
    end
  end
  frameScheduler._frameCount = frameScheduler._frameCount + 1
end

return frameScheduler
