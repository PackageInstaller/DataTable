local this = L_BevTree:registClass("logMessage", L_BevTree.action)
local tag = this:getName()

function this:param()
  self.content = L_WordsTpl:getValue("notice_default")
end

function this:parse()
  self.content = self:getParam("content")
end

function this:onEnter()
end

function this:execute()
  printf(tag, self.content)
  return L_BevTree.taskResult.Success
end

return this
