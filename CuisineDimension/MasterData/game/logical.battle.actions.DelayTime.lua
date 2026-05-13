local DelayTime = class("DelayTime")

function DelayTime:ctor(params)
  self.duration = params.duration
  self.firstTick = true
  self.elapsed = 0
end

function DelayTime:step(dt)
  if self.firstTick then
    self.firstTick = false
    self.elapsed = 0
  else
    self.elapsed = self.elapsed + 0.016666666666666666
  end
end

function DelayTime:isDone()
  return self.elapsed >= self.duration
end
