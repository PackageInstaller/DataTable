local this = class("loadingBehavior", G_UIPartBase)

function this:open(options)
  self.mode = options.mode
  self.callback = nil
  self.autoClose = true
  self.closeDelayTime = 0.1
  self.timerDic = {}
  self.callback = options.callback
  if options.autoClose == nil then
    self.autoClose = true
  else
    self.autoClose = options.autoClose
  end
  self.isFinish = false
  self.isClosing = false
end

function this:blend(nextMode, options)
  return false
end

function this:close()
  self:cancelPendingClose()
  if self.callback then
    self.callback()
  end
end

function this:update()
end

function this:start()
end

function this:getMode()
  return self.mode
end

function this:onUpdateProgress(options)
  local progress = self:regulateProgress(options.progress, options.finish)
  self:updateProgress(progress)
  if 1 <= progress and not self.isFinish then
    self.isFinish = true
    self.isClosing = true
    self:updateProgressMax(options)
  end
end

function this:updateProgress(progress, options)
end

function this:cancelPendingClose()
  local wasClosing = self.isClosing == true
  for _, v in pairs(self.timerDic) do
    Timer.remove(v)
  end
  self.timerDic = {}
  self.isFinish = false
  self.isClosing = false
  return wasClosing
end

function this:updateProgressMax(options)
  self.timerDic.max = Timer.once(self.closeDelayTime, self.complete, self, self.gameObject)
end

function this:complete()
  L_LoadingManager:shotDownLoading()
end

function this:regulateProgress(progress, isFinish)
  if isFinish then
    progress = 1
  elseif not self.autoClose then
    progress = math.clamp(progress, 0, 0.99)
  end
  return progress
end

function this:checkProgressMax(options)
  local val = self.isFinish == true
  self.isFinish = true
  return val
end

function this:getCompleteDelayTime()
  return self.closeDelayTime
end

return this
