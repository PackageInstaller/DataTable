local this = class("timerController")
local _timer = require("core.timer.timer")

function this:ctor()
  self.timerList = {}
  self.stoppedTimers = setmetatable({}, table.weakMetatable)
end

function this:getTimer(func, duration, loop, scale, binder)
  local timer = _timer.new(func, duration, loop, scale, binder)
  table.insert(self.timerList, timer)
  return timer
end

function this:once(time, func, binder, obj, scale)
  local timer = self:getTimer(func, time, 1, scale)
  timer.binder = binder
  timer.obj = obj
  timer.autoDestroy = true
  timer:start()
  return timer
end

function this:repeated(time, func, binder, obj)
  local timer = self:getTimer(func, time, -1)
  timer.binder = binder
  timer.obj = obj
  timer:start()
  return timer
end

function this:start()
  for _, v in ipairs(self.timerList) do
    v:start()
  end
  for k, _ in pairs(self.stoppedTimers) do
    k:start()
  end
end

function this:stop()
  for _, v in ipairs(self.timerList) do
    v:stop()
  end
  for k, _ in pairs(self.stoppedTimers) do
    k:stop()
  end
end

function this:pause()
  for _, v in ipairs(self.timerList) do
    v:pause()
  end
  for k, _ in pairs(self.stoppedTimers) do
    k:pause()
  end
end

function this:resume()
  for _, v in ipairs(self.timerList) do
    v:resume()
  end
  for k, _ in pairs(self.stoppedTimers) do
    k:resume()
  end
end

function this:remove(timer)
  timer:destroy()
end

function this:clear()
  table.resize(self.timerList, 0)
  self.stoppedTimers = setmetatable({}, table.weakMetatable)
end

local function timerErrorHandler(err)
  error(tostring(err) .. debug.traceback())
end

function this:onUpdate(dt, udt)
  for timer, _ in pairs(self.stoppedTimers) do
    if timer.running then
      table.insert(self.timerList, timer)
      self.stoppedTimers[timer] = nil
    end
  end
  local length = #self.timerList
  for i = 1, length do
    local timer = self.timerList[i]
    if timer.running then
      do
        local ok = xpcall(function()
          timer:onUpdate(dt, udt)
        end, timerErrorHandler)
        if not ok then
          timer.running = false
        end
      end
    end
  end
  length = #self.timerList
  local empty = 0
  for i = 1, length do
    local timer = self.timerList[i]
    if not timer.running then
      if timer.func then
        self.stoppedTimers[timer] = true
      end
      self.timerList[i] = nil
      empty = empty + 1
    elseif 0 < empty then
      self.timerList[i - empty] = timer
      self.timerList[i] = nil
    end
  end
end

return this
