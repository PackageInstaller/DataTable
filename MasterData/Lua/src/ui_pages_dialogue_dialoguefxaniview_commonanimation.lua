local commonAnimation = class("commonAnimation", G_UIModuleBase)

function commonAnimation.bind()
  return {aniNodeActive = false}
end

function commonAnimation.methods()
  return {
    onEnd = function(self)
      self:doEnd()
    end
  }
end

function commonAnimation:open()
end

function commonAnimation:doAnimation(params)
  self.isEnd = false
  if self.bindComponents.animation == nil then
    self:doEnd()
    return
  end
  local aniName
  local aniTime = 0
  for i, v in pairs(self.bindComponents.animation) do
    aniName = v.name
    aniTime = v.length
  end
  if aniTime <= 0 then
    self:doEnd()
    return
  end
  self.bind.aniNodeActive = true
  self.waitTimer = Timer.once(aniTime, self.doEnd, self)
  self.bindComponents.animation:Play(aniName)
end

function commonAnimation:doEnd()
  if self.isEnd then
    return
  end
  self.isEnd = true
  self.bind.aniNodeActive = false
  if self.waitTimer then
    Timer.remove(self.waitTimer)
  end
  self.waitTimer = nil
  if self.callback then
    self.callback()
  end
  self.callback = nil
end

function commonAnimation:doSkip()
  if self.waitTimer then
    Timer.remove(self.waitTimer)
  end
  self.bind.aniNodeActive = false
  self.isEnd = true
  self.callback = nil
end

function commonAnimation:dispose()
  if self.waitTimer then
    Timer.remove(self.waitTimer)
  end
  self.waitTimer = nil
  self.isEnd = true
  self.callback = nil
end

return commonAnimation
