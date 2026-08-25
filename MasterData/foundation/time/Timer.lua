local Timer, Super = System.NewClass("Timer")

function Timer:ctor(duration, repeatTimes)
  Super.ctor(self)
  self.duration = duration
  self.repeatTimes = repeatTimes
end

function Timer:play()
  self.start = true
  self.last = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
  self.num = 0
end

function Timer:Update()
  if not self.start then
    return
  end
  if -1 == self.repeatTimes and (not self.duration or self.duration <= 0 or self.duration and CS.Framework.TimeUtil.GetRealtimeSinceStartup() - self.last >= self.duration) then
    self.last = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
    if self.on_key_frame then
      self.on_key_frame()
    end
  end
  if 0 == self.repeatTimes and (not self.duration or self.duration <= 0 or self.duration and CS.Framework.TimeUtil.GetRealtimeSinceStartup() - self.last >= self.duration) and self.on_end then
    self.on_end()
  end
  if self.repeatTimes > 0 then
    if self.num >= self.repeatTimes then
      if self.on_end then
        self.on_end()
      end
      return
    end
    if self.duration > 0 and CS.Framework.TimeUtil.GetRealtimeSinceStartup() - self.last >= self.duration then
      self.num = self.num + 1
      self.last = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
      if self.on_key_frame then
        self.on_key_frame(nil, self.num)
      end
    end
  end
end

function Timer:isRunning()
  return self.start
end

function Timer:stop()
  self.start = false
end

return Timer
