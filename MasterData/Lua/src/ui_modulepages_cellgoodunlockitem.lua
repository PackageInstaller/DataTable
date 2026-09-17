local this = class("cellGoodUnlockItem", G_UIModuleBase)

function this.bind()
  return {progressText = "", unlockTip = ""}
end

function this.methods()
  return {}
end

function this:open()
  self:disposeTimer()
  if self.bind.startTime and self.bind.startTime > 0 then
    self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  end
end

function this:repeatShowTime()
  local str = C_TimeUtility.LeftCountdownShow(self.bind.startTime)
  self.bind.unlockTip = str
end

function this:close()
  self:disposeTimer()
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return this
