local this = L_BevTree:registClass("guide.checkReachLevel", L_BevTree.action)

function this:param()
  self.level = 0
  self.isQuickCheck = 0
end

function this:parse()
  self.level = self:getParam("level", true)
  local isQuickCheck = self:getParam("isQuickCheck", true) or 0
  self.isQuickCheck = isQuickCheck ~= 0
end

function this:execute()
  local nowLevel = L_PlayerStore:getLv()
  if nowLevel >= self.level then
    return L_BevTree.taskResult.Success
  end
  if self.isQuickCheck then
    return L_BevTree.taskResult.Failure
  end
  return L_BevTree.taskResult.Running
end

return this
