local this = L_BevTree:registClass("guide.checkOnMount", L_BevTree.action)

function this:param()
  self.isReverse = 0
end

function this:parse()
  local isReverse = self:getParam("isReverse", true) or 0
  self.isReverse = isReverse ~= 0
end

function this:onEnter()
end

function this:execute()
  if self.isReverse then
    if L_PlayerStore:playerInMountStatus() then
      return L_BevTree.taskResult.Running
    end
    return L_BevTree.taskResult.Success
  else
    if L_PlayerStore:playerInMountStatus() then
      return L_BevTree.taskResult.Success
    end
    return L_BevTree.taskResult.Running
  end
end

return this
