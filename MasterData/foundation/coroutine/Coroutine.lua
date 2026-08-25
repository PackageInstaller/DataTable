local Coroutine = System.NewClass("Coroutine")
Coroutine.pool = setmetatable({}, {__mode = "kv"})

function Coroutine.Create(f)
  local co = table.remove(Coroutine.pool)
  if nil == co then
    co = coroutine.create(function(...)
      f(...)
      while true do
        f = nil
        Coroutine.pool[#Coroutine.pool + 1] = co
        f = Coroutine.Yield()
        f(Coroutine.Yield())
      end
    end)
  else
    Coroutine.Resume(co, f)
  end
  return co
end

function Coroutine.WaitForSecond(timeout)
  local co = coroutine.running()
  local timer
  local timerFinish = false
  if timeout then
    timer = TimerManager.Instance:CreateTimer(timeout, 0, nil, function()
      local err = {
        code = 0,
        msg = "sleep timeout"
      }
      timerFinish = true
      Coroutine.Resume(co, err, nil)
    end)
  end
  local error, data = Coroutine.Yield()
  if not timerFinish then
    TimerManager.Instance:StopTimer(timer)
  end
  return error, data
end

function Coroutine.Resume(co, ...)
  local ret, msg = coroutine.resume(co, ...)
  if not ret then
    Logger.Error("coroutine resume failed", ret, msg)
  end
  return ret, msg
end

function Coroutine.Yield(...)
  do return coroutine.yield, ... end
  return coroutine.yield, ...
end

function Coroutine.IsRunning(co)
  return coroutine.status(co) == "running"
end

function Coroutine.IsSuspended(co)
  return coroutine.status(co) == "suspended"
end

function Coroutine.IsDead(co)
  return coroutine.status(co) == "dead"
end

return Coroutine
