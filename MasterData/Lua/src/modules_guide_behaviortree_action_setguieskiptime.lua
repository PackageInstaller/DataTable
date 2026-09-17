local this = L_BevTree:registClass("guide.setGuieSkipTime", L_BevTree.action)
local guideTreeTaskWatch = require("modules.guide.guideTreeTaskWatch")

function this:param()
  self.useDefultSkipTime = 0
  self.forceOverrideSkipTime = 0
end

function this:parse()
  local useDefultSkipTime = self:getParam("useDefultSkipTime", true) or 0
  self.useDefultSkipTime = useDefultSkipTime ~= 0
  self.forceOverrideSkipTime = self:getParam("forceOverrideSkipTime", true) or 0
end

function this:execute()
  local tree = self.tree
  if self.useDefultSkipTime then
    guideTreeTaskWatch.clearSkipThresholdOverride(tree)
  else
    guideTreeTaskWatch.setSkipThresholdOverride(tree, self.forceOverrideSkipTime)
  end
  return L_BevTree.taskResult.Success
end

return this
