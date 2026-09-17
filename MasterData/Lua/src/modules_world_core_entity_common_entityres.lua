local this = class("resEntity")

function this:ctor(resId)
  self.resId = resId
  self.go = nil
  self.entity = nil
  self.delayTime = nil
end

function this:setDelayDestroyTime(delayTime)
  self.delayTime = delayTime
end

function this:getDelayDestroyTime()
  return self.delayTime
end

function this:destroy()
  if self.delayTime then
    Timer.once(self.delayTime, self._destroy, self)
  else
    self._destroy()
  end
end

function this:_destroy()
  self:_destroyEntity()
  self:_destroyRes()
end

function this:_destroyEntity()
  if self.entity == nil then
    return
  end
  self.entity:onDestroy()
end

function this:_destroyRes()
end

return this
