local TaskMgr, Super = System.NewClass("TaskMgr", Manager, IUpdater)

function TaskMgr:ctor()
  Super.ctor(self)
  self.SleepSession = {}
end

function TaskMgr:Awake()
  Super.Awake(self)
  self.updaters = {}
  self.temp = {}
end

function TaskMgr:WaitForUpdate()
  local co = coroutine.running()
  if IsMainCoroutine(co) then
    Logger.Error("意图在主协程里面执行yield")
    return
  end
  table.insert(self.updaters, co)
  coroutine.yield()
end

function TaskMgr:Update()
  table.clear(self.temp)
  table.mergeWithoutGc(self.temp, self.updaters)
  table.clear(self.updaters)
  for i, co in ipairs(self.temp) do
    local ok, err = coroutine.resume(co)
    if false == ok then
      error(debug.traceback(co, err))
    end
  end
end

function TaskMgr.Fork(f, ...)
  assert(type(f) == "function", "argument type is not function, this is a static function")
  local co = Coroutine.Create(f)
  Coroutine.Resume(co, ...)
  return co
end

function TaskMgr:IsSleep(co)
  return self.SleepSession[co] ~= nil
end

function TaskMgr:StartSleep(co)
  self.SleepSession[co] = true
end

function TaskMgr:StopSleep(co)
  self.SleepSession[co] = nil
end

return TaskMgr
