local this = L_BevTree:registClass("guide.checkCloseWindow", L_BevTree.action)

function this:param()
  self.windowName = ""
  self.isReverse = 0
  self.isQuickCheck = 0
end

function this:parse()
  self.windowName = self:getParam("windowName")
  local isReverse = self:getParam("isReverse", true) or 0
  self.isReverse = isReverse ~= 0
  local isQuickCheck = self:getParam("isQuickCheck", true) or 0
  self.isQuickCheck = isQuickCheck ~= 0
end

function this:onEnter()
  if self.isReverse then
    L_UI:addListener(L_UI.pageEvent.closed, self.onPageClosed, self)
  end
  self.result = L_BevTree.taskResult.Running
end

function this:onDestroy()
  if self.isReverse then
    L_UI:removeListener(L_UI.pageEvent.closed, self.onPageClosed, self)
  end
end

function this:onFinish()
  if self.isReverse then
    L_UI:removeListener(L_UI.pageEvent.closed, self.onPageClosed, self)
  end
end

function this:onPageClosed(pageName)
  if self.isReverse and pageName ~= self.windowName then
    self.result = L_BevTree.taskResult.Success
  end
end

function this:execute()
  if not self.isReverse and not string.isEmpty(self.windowName) then
    local st = L_UI:getPageStatus(self.windowName)
    if st == nil or st == "hided" or st == "closed" then
      self.result = L_BevTree.taskResult.Success
    end
  end
  if self.isQuickCheck and not self.isReverse and self.result ~= L_BevTree.taskResult.Success then
    self.result = L_BevTree.taskResult.Failure
  end
  return self.result
end

return this
