local coUtils = {}
local create = coroutine.create
local running = coroutine.running

local function safeResume(co, ...)
  local flag, msg = coroutine.resume(co, ...)
  if not flag then
    error(debug.traceback(co, msg))
  end
end

local yield = coroutine.yield
local unpack = table.unpack
coUtils.phase = {
  scaled = 1,
  unscaled = 2,
  inGame = 3
}
local timerMap = {}
setmetatable(timerMap, table.weakMetatable)
local cbMap = {}
setmetatable(cbMap, table.weakMetatable)

function coUtils.start(f, ...)
  local co = create(f)
  if running() == nil then
    safeResume(co, ...)
  else
    local args = {
      ...
    }
    local timer
    
    local function action()
      timerMap[co] = nil
      timer:destroy()
      safeResume(co, unpack(args))
    end
    
    timer = Timer.new(action, 0, 1)
    timerMap[co] = timer
    timer:start()
  end
  return co
end

function coUtils.wait(t, phase)
  local co = running()
  if co == nil then
    error("cannot call in main thread!")
  end
  if t <= 0 then
    return -t
  end
  local timer
  
  local function action()
    timerMap[co] = nil
    local consume = timer.consume
    timer:destroy()
    safeResume(co, -consume)
  end
  
  if phase == coUtils.phase.inGame then
    timer = L_GameTimer.new(action, t, 1)
  elseif phase == coUtils.phase.unscaled then
    timer = Timer.new(action, t, 1, false)
  else
    timer = Timer.new(action, t, 1, true)
  end
  timerMap[co] = timer
  timer:start()
  return yield()
end

function coUtils.step(n)
  local co = running()
  if co == nil then
    error("cannot call in main thread!")
  end
  n = n or 1
  local timer
  if Timer.frameCount ~= C_Time.frameCount then
    n = n + 1
  end
  
  local function action()
    if timer.loop > 0 then
      return
    end
    timerMap[co] = nil
    timer:destroy()
    safeResume(co)
  end
  
  timer = Timer.new(action, 0, n)
  timerMap[co] = timer
  timer:start()
  return yield()
end

function coUtils.callback(...)
end

local function replaceCallback(params, callback)
  for k, v in pairs(params) do
    if v == coUtils.callback then
      params[k] = callback
      break
    end
  end
  return params
end

function coUtils.call(f, ...)
  local co = running()
  if co == nil then
    error("cannot call in main thread!")
  end
  local rets
  
  local function callback(...)
    if cbMap[co] then
      cbMap[co] = nil
      safeResume(co, ...)
    else
      rets = {
        ...
      }
    end
  end
  
  local params = replaceCallback({
    ...
  }, callback)
  f(unpack(params))
  if not rets then
    cbMap[co] = callback
    return yield()
  else
    return unpack(rets)
  end
end

function coUtils.waitUntil(cond, timeout, phase)
  local co = running()
  if co == nil then
    error("cannot call in main thread!")
  end
  local timer
  local checkTime = timeout and 0 < timeout
  
  local function action()
    local res = cond()
    if not res then
      if checkTime then
        timeout = timeout + timer.consume
        if timeout <= 0 then
          return
        end
      else
        return
      end
    end
    timerMap[co] = nil
    timer:destroy()
    safeResume(co, res)
  end
  
  if phase == coUtils.phase.inGame then
    timer = L_GameTimer.new(action, 0, -1)
  elseif phase == coUtils.phase.unscaled then
    timer = Timer.new(action, 0, -1, false)
  else
    timer = Timer.new(action, 0, -1, true)
  end
  timerMap[co] = timer
  timer:start()
  return yield()
end

function coUtils.stop(co)
  local timer = timerMap[co]
  if timer ~= nil then
    timerMap[co] = nil
    timer:destroy()
    return
  end
  local cb = cbMap[co]
  if cb ~= nil then
    cbMap[co] = nil
    return
  end
end

return coUtils
