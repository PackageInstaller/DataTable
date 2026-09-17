local this = L_BevTree:registClass("guide.checkGuideTreeComplete", L_BevTree.action)

function this:param()
  self.guideTreeId = 0
  self.isQuickCheck = 0
end

function this:parse()
  self.guideTreeId = self:getParam("guideTreeId", true)
  local isQuickCheck = self:getParam("isQuickCheck", true) or 0
  self.isQuickCheck = isQuickCheck ~= 0
end

function this:execute()
  if L_GuideStore:isGuideComplete(self.guideTreeId) == true then
    return L_BevTree.taskResult.Success
  end
  if self.isQuickCheck then
    return L_BevTree.taskResult.Failure
  end
  return L_BevTree.taskResult.Running
end

return this
