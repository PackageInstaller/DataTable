local this = L_BevTree:registClass("guide.openWindow", L_BevTree.action)
local tag = this:getName()

function this:param()
  self.windowName = ""
end

function this:parse()
  self.windowName = self:getParam("windowName")
end

function this:onEnter()
  if not string.isEmpty(self.windowName) then
    L_UI:open(self.windowName)
  end
end

function this:execute()
  local st = L_UI:getPageStatus(self.windowName)
  if st and st == "shown" then
    return L_BevTree.taskResult.Success
  end
  return L_BevTree.taskResult.Running
end

return this
