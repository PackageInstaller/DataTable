local this = L_BevTree:registClass("guide.setGuideStepFinish", L_BevTree.action)
local tag = this:getName()

function this:param()
  self.guideStep = -1
end

function this:parse()
  self.guideStep = self:getParam("guideStep", true)
end

function this:onEnter()
  if self.guideStep > -1 and not L_GuideManager:isOnDebugMode() then
    L_GuideManager:saveStepId(self.tree.param.guideId, self.guideStep)
  end
end

function this:execute()
  return L_BevTree.taskResult.Success
end

return this
