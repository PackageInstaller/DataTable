local this = L_BevTree:registClass("guide.heroAnimChangedTrigger", L_BevTree.action)

function this:param()
  self.animState = ""
  self.animName = ""
end

function this:parse()
  self.animState = self:getParam("animState")
  self.animName = self:getParam("animName")
  self.isDestroy = false
end

function this:onEnter()
  if self.isDestroy then
    self.result = L_BevTree.taskResult.Failure
    return
  end
  self.onHeroAnimChangedEnterHandle = self.onHeroAnimChangedEnterHandle or handler(self, self.onHeroAnimChangedEnter)
  C_GuideEvent.instance:Listen(C_EGuideEvents.HeroAnimStateChangedEnter, self.onHeroAnimChangedEnterHandle)
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  return self.result
end

function this:onHeroAnimChangedEnter(_, varList)
  local name = varList:GetString(0)
  if name == self.animName and self.animState == "Enter" then
    self.result = L_BevTree.taskResult.Success
  end
end

function this:onReset()
  self.isDestroy = true
  self.result = L_BevTree.taskResult.Failure
  self:dealDestroy()
end

function this:onFinish()
  self.isDestroy = true
  self:doDestroy()
end

function this:onDestroy()
  self.isDestroy = true
  self:doDestroy()
end

function this:doDestroy()
  self:dealDestroy()
end

function this:dealDestroy()
  if self.onHeroAnimChangedEnterHandle ~= nil then
    C_GuideEvent.instance:Cancel(C_EGuideEvents.HeroAnimStateChangedEnter, self.onHeroAnimChangedEnterHandle)
    self.onHeroAnimChangedEnterHandle = nil
  end
end

return this
