local this = class("pageNetworkWaiting", G_UIPageBase)

function this.bind()
  return {goJiuJiu = false}
end

function this.methods()
  return {}
end

function this:preOpen(options)
  self._invisible = options and options.invisible
  if options and options.lockTime then
    self.lockTime = options.lockTime
  else
    self.lockTime = 2
  end
  self.time = 0
end

function this:update()
  self.time = self.time + C_Time.unscaledDeltaTime
  if self.time >= 2 and not self.bind.goJiuJiu then
    self:switchMaskView(true)
  end
  if self.time >= self.lockTime then
    self:switchLockState(true)
  end
end

function this:escHandle()
end

function this:close(options)
  self:switchMaskView(false)
  self:switchLockState(false)
end

function this:switchMaskView(isShow)
  self.bind.goJiuJiu = isShow
end

function this:switchLockState(isShow)
  C_UIMgr.uiListenerMiddleware:ControlCameraLock(self.pageName, isShow)
  C_UIMgr.uiListenerMiddleware:ControlInputMapLock(self.pageName, isShow)
end

return this
