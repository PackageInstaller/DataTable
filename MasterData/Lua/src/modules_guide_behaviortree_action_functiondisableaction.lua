local this = L_BevTree:registClass("guide.functionDisableAction", L_BevTree.action)

function this:param()
  self.resumeJumpTo = 0
  self.resumeTransferTo = 0
end

function this:parse()
  self.resumeJumpTo = self:getParam("resumeJumpTo", true) or 0
  self.resumeTransferTo = self:getParam("resumeTransferTo", true) or 0
end

function this:execute()
  L_GuideManager:changeJumpToFuncStatus(self.resumeJumpTo ~= 0)
  L_GuideManager:changeTransferToFuncStatus(self.resumeTransferTo ~= 0)
  return L_BevTree.taskResult.Success
end

return this
