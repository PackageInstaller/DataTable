local this = L_BevTree:registClass("guide.setWorldPauseAction", L_BevTree.action)
local tag = this:getName()

function this:param()
  self.isResume = 0
end

function this:parse()
  self.isResume = self:getParam("isResume", true) ~= 0
end

function this:execute()
  L_GuideManager:setWorldPause(not self.isResume, self.tree.param.guideId)
  return L_BevTree.taskResult.Success
end

return this
