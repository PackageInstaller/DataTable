local this = class("timer")
local _Time = CS.UnityEngine.Time

function this:ctor(func, duration, loop, scale, binder)
  if scale == nil then
    scale = true
  end
  self:reset(func, duration or 1, loop, scale or false, binder)
end

function this:reset(func, duration, loop, scale, binder)
  self.func = func or self.func
  self.duration = duration or self.duration
  self.loop = loop or 1
  if scale == nil then
    self.scale = self.scale
  else
    self.scale = scale
  end
  self.binder = binder or self.binder
  self.consume = self.duration
  self.running = false
  self.paused = nil
end

function this:destroy()
  self:stop()
  self.obj = nil
  self.func = nil
  self.binder = nil
end

function this:start()
  self.running = true
  self.paused = nil
end

function this:stop()
  self.running = false
  self.paused = nil
  self.consume = 0
end

function this:pause()
  self.paused = true
end

function this:resume()
  self.paused = nil
end

function this:onUpdate(dt, udt)
  if self.paused then
    return
  end
  if self.obj and self.obj:IsNull() then
    self:destroy()
    return
  end
  local delta = self.scale and dt or udt
  self.consume = self.consume - delta
  if self.duration == 0 then
    self:_update()
    self.consume = 0
  else
    local count = 0
    while self.consume <= 0 and count < 6 do
      count = count + 1
      if not self:_update() then
        break
      end
      self.consume = self.consume + self.duration
    end
  end
end

function this:_update()
  if self.loop > 0 then
    self.loop = self.loop - 1
  end
  self.func(self.binder)
  if self.loop == 0 then
    if self.autoDestroy then
      self:destroy()
    else
      self:stop()
    end
    return false
  end
  return true
end

return this
