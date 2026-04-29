local TaskState = {
  Running = 1,
  Suspend = 2,
  Stop = 3
}
_enum("TaskState", TaskState)
_class("Task", Object)
Task = Task

function Task:Constructor(id, func, token)
  self.id = id
  self.co = coroutine.create(func)
  self.state = TaskState.Running
  self.token = token
end

function Task:Join(id)
  local task = TaskManager:GetInstance():FindTask(id)
  if not task then
    return
  end
  if not task.joinTasks then
    task.joinTasks = {}
  end
  task.joinTasks[self.id] = 1
  self.joinedTaskID = id
  TaskManager:GetInstance():SuspendTask(self.id)
end

function Task:Update(...)
  local lastTask = TaskManager:GetInstance().curTask
  TaskManager:GetInstance().curTask = self
  local ret, msg = coroutine.resume(self.co, ...)
  TaskManager:GetInstance().curTask = lastTask
  if ret then
    if coroutine.status(self.co) == "dead" then
      if self.finishCallback then
        self.finishCallback(self.data, self.id)
      end
      if self.joinTasks then
        for id, _ in next, self.joinTasks, nil do
          TaskManager:GetInstance():ResumeTask(id)
        end
      end
      self.state = TaskState.Stop
      return false
    end
    return true
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TaskError)
  GameGlobal.GameRecorder():StopRecord()
  msg = debug.traceback(self.co, msg)
  Log.exception(msg)
  return false
end

_class("TaskManager", Singleton)
TaskManager = TaskManager
local unpack = table.unpack

function TaskManager:Constructor()
  self.tasks = {}
  self.runnings = {}
  self.newRunnings = {}
  self.seq = 0
  self.TT = TaskToken:New()
  self.ST = StoppableTaskToken:New()
  self.yieldEvents = {}
  self._coreGameTaskIDs = {}
  self._lastLogTaskListTick = 0
  self._timer = nil
  self.curTask = nil
end

function TaskManager:Update()
  if #self.runnings > 0 then
    local i = 1
    while i <= #self.runnings do
      local id = self.runnings[i]
      local task = self.tasks[id]
      if task then
        local ret = task:Update(task.token)
        self.curTask = nil
        if not ret then
          self.tasks[id] = nil
          table.removev(self.runnings, id)
          table.removev(self._coreGameTaskIDs, id)
          i = i - 1
        elseif task.state == TaskState.Suspend then
          i = i - 1
        end
      else
        table.removev(self.runnings, id)
        i = i - 1
      end
      i = i + 1
    end
  end
  local total = #self.newRunnings
  if 0 < total then
    for i = 1, total do
      table.insert(self.runnings, self.newRunnings[i])
    end
    self.newRunnings = {}
  end
end

function TaskManager:FindTask(id)
  return self.tasks[id]
end

function TaskManager:StartTask(func, ...)
  return self:StartTaskInternal(func, self.TT, ...)
end

function TaskManager:StartStoppableTask(func, ...)
  return self:StartTaskInternal(func, self.ST, ...)
end

function TaskManager:StartTaskInternal(func, token, ...)
  local id = self.seq + 1
  if id < 0 then
    id = 1
  end
  self.seq = id
  local task = Task:New(id, func, token)
  local args = {}
  local index = 1
  local hasParam = true
  if not (...) then
    hasParam = false
  end
  if not hasParam then
    args[index] = token
    index = index + 1
  end
  for i = 1, select("#", ...) do
    args[index] = select(i, ...)
    index = index + 1
    if hasParam and i == 1 then
      args[index] = token
      index = index + 1
    end
  end
  table.insert(self.newRunnings, id)
  self.tasks[id] = task
  local ret = task:Update(unpack(args, 1, table.maxn(args)))
  if not ret then
    table.removev(self.newRunnings, id)
    self.tasks[id] = nil
    return -1
  end
  if EDITOR then
  end
  return id
end

function TaskManager:CoreGameStartTask(func, ...)
  local id = self:StartTask(func, ...)
  if 0 < id then
    table.insert(self._coreGameTaskIDs, id)
  end
  return id
end

function TaskManager:IsAnyCoreGameTask()
  return next(self._coreGameTaskIDs)
end

function TaskManager:KillCoreGameTasks()
  for _, taskid in ipairs(self._coreGameTaskIDs) do
    table.removev(self.runnings, taskid)
    table.removev(self.newRunnings, taskid)
    self.tasks[taskid] = nil
  end
  self._coreGameTaskIDs = {}
  Log.debug("KillCoreGameTasks Finished!!")
end

function TaskManager:KillTask(taskid)
  table.removev(self.runnings, taskid)
  table.removev(self.newRunnings, taskid)
  self.tasks[taskid] = nil
  local found = false
  for id, yieldEvent in pairs(self.yieldEvents) do
    if id == taskid then
      found = true
      GameGlobal.Timer():CancelEvent(yieldEvent)
      break
    end
  end
  if found then
    self.yieldEvents[taskid] = nil
  end
end

function TaskManager:KillAllTasks()
  for _, taskid in ipairs(self.tasks) do
    table.removev(self.runnings, taskid)
    table.removev(self.newRunnings, taskid)
    self.tasks[taskid] = nil
  end
  for id, yieldEvent in pairs(self.yieldEvents) do
    if yieldEvent then
      GameGlobal.Timer():CancelEvent(yieldEvent)
    end
  end
  self.yieldEvents = {}
  self._coreGameTaskIDs = {}
end

function TaskManager:WaitCoreGameTaskFinish(onfinish, ...)
  if #self._coreGameTaskIDs == 0 then
    onfinish(...)
    return -1
  end
  local args = {}
  local index = 1
  for i = 1, select("#", ...) do
    args[index] = select(i, ...)
    index = index + 1
    if i == 1 then
      args[index] = self.TT
      index = index + 1
    end
  end
  return self:StartTask(function(TT)
    local wait_tick = 10000
    local start_tick = GameGlobal:GetInstance():GetCurrentTime()
    while next(self._coreGameTaskIDs) do
      Log.debug("WaitCoreGameTaskFinish tasks: ", table.concat(self._coreGameTaskIDs, " "))
      YIELD(TT)
      if wait_tick <= GameGlobal:GetInstance():GetCurrentTime() - start_tick then
        break
      end
    end
    if #self._coreGameTaskIDs ~= 0 then
      self:KillCoreGameTasks()
    end
    if onfinish then
      onfinish(unpack(args))
    end
  end)
end

function TaskManager:SuspendTask(id)
  local task = self.tasks[id]
  if task then
    table.removev(self.runnings, id)
    table.removev(self.newRunnings, id)
    task.state = TaskState.Suspend
    YIELD()
  end
end

function TaskManager:ResumeTask(id)
  local yieldEvent = self.yieldEvents[id]
  if yieldEvent then
    GameGlobal.Timer():CancelEvent(yieldEvent)
    self.yieldEvents[id] = nil
  end
  local task = self.tasks[id]
  if not task then
    Log.fatal("TaskManager Resume Error!!! cannot find task with id=", id, ", Please Check if called STOP_ST_UNSAFE,", debug.traceback())
  end
  if task and not table.ikey(self.runnings, id) then
    if table.ikey(self.newRunnings) then
      return
    end
    table.insert(self.newRunnings, id)
    task.state = TaskState.Running
    local ret = task:Update(task.token)
    if not ret then
      self.tasks[id] = nil
      table.removev(self._coreGameTaskIDs, id)
      table.removev(self.newRunnings, id)
      return false
    end
  end
  return false
end

function TaskManager:ExpirationYield(token, id, ms)
  if 15 < ms then
    ms = ms - 15
  end
  local event = GameGlobal.Timer():AddEvent(ms, function()
    self.yieldEvents[id] = nil
    ResumeInternal(id)
  end)
  if not self.yieldEvents[id] then
    self.yieldEvents[id] = event
  else
    Log.fatal("TaskManager:ExpirationYield Error, Expiration Yield When Suspend")
  end
  SuspendInternal()
end

function TaskManager:StopTaskUnSafe(ST, id)
  local task = self.tasks[id]
  if not task then
    Log.fatal("StopTaskUnSafe Error, cannot find task,", id, ",", debug.traceback())
    return false
  end
  if task.token then
    local className = task.token._className
    if className ~= "StoppableTaskToken" then
      Log.fatal("StopTaskUnSafe Error, token is not StoppableTaskToken,", className, ",", debug.traceback())
      return false
    end
  end
  local yieldEvent = self.yieldEvents[id]
  if yieldEvent then
    GameGlobal.Timer():CancelEvent(yieldEvent)
    self.yieldEvents[id] = nil
  end
  local joinedTask = self.tasks[task.joinedTaskID]
  if joinedTask then
    joinedTask.joinTasks[id] = nil
  end
  task.state = TaskState.Stop
  self.tasks[id] = nil
  table.removev(self.newRunnings, id)
  return true
end

function GetCurTask()
  return TaskManager:GetInstance().curTask
end

function GetCurTaskId()
  local task = TaskManager:GetInstance().curTask
  return task and task.id or nil
end

function YIELD(TT, ms)
  YieldInternal(TT, ms)
end

function YIELD_FRAME(TT, frame)
  for i = 0, frame do
    YieldInternal(TT)
  end
end

function SUSPEND(TT)
  SuspendInternal()
end

function RESUME(TT, id)
  return ResumeInternal(id)
end

function JOIN(TT, child)
  JoinInternal(child)
end

function YieldInternal(token, ms)
  if not ms then
    coroutine.yield()
  else
    local id = GetCurTaskId()
    if id then
      TaskManager:GetInstance():ExpirationYield(token, id, ms)
    else
      Log.fatal("YIELD Error, current task id is nil")
    end
  end
end

function SuspendInternal()
  local id = GetCurTaskId()
  TaskManager:GetInstance():SuspendTask(id)
end

function ResumeInternal(id)
  return TaskManager:GetInstance():ResumeTask(id)
end

function JoinInternal(child)
  local task = TaskManager:GetInstance().curTask
  task:Join(child)
end

function JOIN_TASK_ARRAY(TT, childArray)
  while not TaskHelper:GetInstance():IsAllTaskFinished(childArray) do
    YIELD(TT)
  end
end
