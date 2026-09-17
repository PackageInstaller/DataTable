local this = L_BevTree:registClass("guide.closeWindow", L_BevTree.action)
local tag = this:getName()

function this:param()
  self.windowName = ""
end

function this:parse()
  self.windowName = self:getParam("windowName")
end

function this:onEnter()
  self:closeWindow()
end

function this:closeWindow()
  if not string.isEmpty(self.windowName) and L_UI:checkPageOpen(self.windowName) then
    L_UI:close(self.windowName)
  end
end

function this:execute()
  local st = L_UI:getPageStatus(self.windowName)
  if st == nil or st == "hided" or st == "closed" then
    return L_BevTree.taskResult.Success
  end
  return L_BevTree.taskResult.Running
end

function this:onReset()
  if self.lastResult ~= L_BevTree.taskResult.Success then
    self:closeWindow()
  end
end

return this
