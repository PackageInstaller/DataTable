local timerManager = class("timerManager")
local tag = timerManager:getName()

function timerManager:ctor()
  self._timerMap = setmetatable({}, {__mode = "k"})
end

function timerManager:dispose()
  for _, objTimers in pairs(self._timerMap) do
    for _, timer in pairs(objTimers) do
      timer:destroy()
    end
  end
  self._timerMap = setmetatable({}, {__mode = "k"})
end

function timerManager:newOrResetTimer(obj, key, ...)
  if not self._timerMap[obj] then
    self:_cleanUp()
    self._timerMap[obj] = setmetatable({}, table.weakMetatable)
  end
  local timer = self._timerMap[obj][key]
  if not timer then
    timer = Timer.new(...)
  else
    timer:stop()
    timer:reset(...)
  end
  self._timerMap[obj][key] = timer
  timer:start()
end

function timerManager:_cleanUp()
  for obj, tbl in pairs(self._timerMap) do
    local csType = typeof(obj)
    if csType and obj:IsNull() then
      self:clearTimer(obj)
    elseif next(tbl) == nil then
      self._timerMap[obj] = nil
    end
  end
end

function timerManager:stopTimer(obj, key)
  local timer = self._timerMap[obj] and self._timerMap[obj][key]
  if timer then
    timer:destroy()
    self._timerMap[obj][key] = nil
  end
end

function timerManager:clearTimer(obj)
  if not self._timerMap[obj] then
    return
  end
  for _, timer in pairs(self._timerMap[obj]) do
    timer:destroy()
  end
  self._timerMap[obj] = nil
end

return timerManager
