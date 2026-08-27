local Timer = class("Timer")

function Timer:ctor(delay, func, obj, one_shot, use_frame, unscaled)
  if delay and func then
    self:Init(delay, func, obj, one_shot, use_frame, unscaled)
  end
end

function Timer:Init(delay, func, obj, one_shot, use_frame, unscaled)
  assert(type(delay) == "number" and 0 <= delay)
  assert(func ~= nil)
  self.delay = delay
  self.func = func
  self.obj = obj
  self.one_shot = one_shot
  self.use_frame = use_frame
  self.unscaled = unscaled
  self.started = false
  self.left = delay
  self.over = false
  self.obj_not_nil = obj and true or false
  self.start_frame_count = Time.frameCount
end

function Timer:Update(is_fixed)
  if not self.started or self.over then
    return
  end
  local timeup = false
  if self.use_frame then
    timeup = Time.frameCount >= self.start_frame_count + self.delay
  else
    local delta
    if is_fixed then
      delta = Time.fixedDeltaTime
    else
      delta = not self.unscaled and Time.deltaTime or Time.unscaledDeltaTime
    end
    self.left = self.left - delta
    timeup = self.left <= 0
  end
  if timeup then
    if self.func ~= nil then
      if not self.one_shot then
        if not self.use_frame then
          self.left = self.delay + self.left
        end
        self.start_frame_count = Time.frameCount
      else
        self.over = true
      end
      local status, err
      if self.obj_not_nil then
        status, err = xpcall(self.func, debug.traceback, self.obj)
      else
        status, err = xpcall(self.func, debug.traceback)
      end
      if not status then
        self.over = true
        error(err)
      end
    else
      self.over = true
    end
  end
end

function Timer:Start()
  if self.over then
    error("You can't start a overed timer, try add a new one!")
  end
  if not self.started then
    self.left = self.delay
    self.started = true
    self.start_frame_count = Time.frameCount
  end
  return self
end

function Timer:Pause()
  self.started = false
end

function Timer:Resume()
  self.started = true
end

function Timer:Stop()
  self.left = 0
  self.one_shot = false
  self.func = nil
  self.obj = nil
  self.use_frame = false
  self.unscaled = false
  self.started = false
  self.over = true
end

function Timer:Reset()
  self.left = self.delay
  self.start_frame_count = Time.frameCount
end

function Timer:IsOver()
  if self.func == nil then
    return true
  end
  if self.obj_not_nil and self.func == nil then
    return true
  end
  return self.over
end

return Timer
