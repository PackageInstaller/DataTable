local this = L_BevTree:registClass("guide.checkPlayerGender", L_BevTree.action)

function this:param()
  self.playerGenderId = 0
end

function this:parse()
  self.playerGenderId = self:getParam("playerGenderId", true)
end

function this:execute()
  if L_PlayerStore:getSex() == self.playerGenderId then
    return L_BevTree.taskResult.Success
  end
  return L_BevTree.taskResult.Failure
end

return this
