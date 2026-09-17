local this = L_BevTree:registClass("guide.checkOwnItemNum", L_BevTree.action)

function this:param()
  self.itemId = 0
  self.itemNum = 0
end

function this:parse()
  self.itemId = self:getParam("itemId", true)
  self.itemNum = self:getParam("itemNum", true)
end

function this:execute()
  if C_BagMgr:getItemNumByItemId(self.itemId) >= self.itemNum then
    return L_BevTree.taskResult.Success
  end
  return L_BevTree.taskResult.Failure
end

return this
