_class("GuideLerp", Object)

function GuideLerp:LineLerp(startValue, targetValue, t)
  return startValue + (targetValue - startValue) * t
end

function GuideLerp:SlowDown(startValue, targetValue)
  local t = GameGlobal:GetInstance():GetCurrentTime() - self.startTime
  t = t / self.duration
  local value = -(targetValue - startValue) * t * (t - 2) + startValue
  return value
end

local lerpFuncMap = {
  line = GuideLerp.LineLerp,
  slowDown = GuideLerp.SlowDown
}

function GuideLerp:Constructor(startValue, targetValue, duration, lerpType)
  self.startValue = startValue
  self.targetValue = targetValue
  self.duration = duration
  self.lerpFunc = lerpFuncMap[lerpType or "line"]
  if self.lerpFunc == nil then
    if error then
      error("lerpType not support : " .. lerpType)
    end
    self.lerpFunc = self.LineLerp
  end
  self.startTime = GameGlobal:GetInstance():GetCurrentTime()
end

function GuideLerp:Reset()
  self.startTime = GameGlobal:GetInstance():GetCurrentTime()
end

function GuideLerp:Lerp()
  local t = (GameGlobal:GetInstance():GetCurrentTime() - self.startTime) / self.duration
  if 1 < t then
    t = 1
  end
  return self:lerpFunc(self.startValue, self.targetValue, t), t == 1
end
