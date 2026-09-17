local this = L_BevTree:registClass("guide.finishGuideTree", L_BevTree.action)
local tag = this:getName()

function this:param()
  self.time = 0.5
end

function this:parse()
  self.time = self:getParam("time", true)
  if self.time == nil then
    self.time = 0.5
  end
end

function this:onEnter()
  self.isDestroy = false
  self.wait = true
  self.timer = Timer.once(self.time, function()
    self.wait = false
  end, self)
end

function this:execute()
  if self.wait or self.isDestroy then
    return L_BevTree.taskResult.Running
  end
  self.isDestroy = true
  L_GuideManager:clearAllControl()
  L_GuideManager:forceEndGuide(self.tree.param.guideId)
  L_GuideManager:saveStepId(self.tree.param.guideId, 0)
  return L_BevTree.taskResult.Running
end

function this:onFinish()
  self:disposeTimer()
end

function this:onDestroy()
  self:disposeTimer()
end

function this:onReset()
  self:disposeTimer()
end

function this:disposeTimer()
  if self.timer ~= nil then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return this
