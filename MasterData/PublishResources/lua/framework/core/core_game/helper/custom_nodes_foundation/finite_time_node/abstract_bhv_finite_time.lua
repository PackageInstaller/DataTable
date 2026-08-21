_class("FiniteTimeBhv", CustomNode)
FiniteTimeBhv = FiniteTimeBhv

function FiniteTimeBhv:Constructor()
  self.mDuration = 0
  self.mIsEnd = false
  self.mHasStart = false
end

function FiniteTimeBhv:Reset()
  self.mDuration = 0
  self.mIsEnd = false
  self.mHasStart = false
end

function FiniteTimeBhv:Update(dt)
  if not self:IsDurationEnd() then
    local duration = self.mDuration
    if 0 < duration and dt > duration then
      self:innerUpdate(duration)
    else
      self:innerUpdate(dt)
    end
    self.mDuration = duration - dt
  end
  if self:IsDurationEnd() and self.mIsEnd == false then
    self.mIsEnd = true
    self:OnDurationEnd()
  end
end

function FiniteTimeBhv:innerUpdate(dt)
  if not self.mHasStart then
    self.mHasStart = true
    self:OnBegin()
  end
  self:OnUpdate(dt)
end

function FiniteTimeBhv:Destroy()
  self.mDuration = 0
  self.mIsEnd = false
  self.mHasStart = false
end

function FiniteTimeBhv:OnBegin()
end

function FiniteTimeBhv:OnUpdate(dt)
end

function FiniteTimeBhv:OnDurationEnd()
end

function FiniteTimeBhv:IsDurationEnd()
  return self.mDuration < 0
end

function FiniteTimeBhv:GetDuration()
  if self.mDuration < 0 then
    return 0
  end
  return self.mDuration
end

function FiniteTimeBhv:InitDuration(duration)
  self.mDuration = duration
end

function FiniteTimeBhv:CanStop()
  return self.mIsEnd
end
