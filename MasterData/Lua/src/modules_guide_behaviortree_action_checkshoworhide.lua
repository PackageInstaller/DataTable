local this = L_BevTree:registClass("guide.checkShowOrHide", L_BevTree.action)

function this:param()
  self.pageName = ""
  self.targetPath = ""
  self.isDetectHide = false
  self.isQuickCheck = 0
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.targetPath = self:getParam("targetPath")
  local isDetectHide = self:getParam("isDetectHide", true) or 0
  self.isDetectHide = isDetectHide ~= 0
  local isQuickCheck = self:getParam("isQuickCheck", true) or 0
  self.isQuickCheck = isQuickCheck ~= 0
end

function this:execute()
  if L_GuideManager:checkPageOpen(self.pageName) then
    local page = L_UI:getPage(self.pageName)
    local node = page.gameObject.transform:Find(self.targetPath)
    if self.isDetectHide then
      if node == nil or not node.gameObject.activeInHierarchy then
        return L_BevTree.taskResult.Success
      end
    elseif node ~= nil and node.gameObject.activeInHierarchy then
      return L_BevTree.taskResult.Success
    end
  end
  if self.isQuickCheck then
    return L_BevTree.taskResult.Failure
  end
  return L_BevTree.taskResult.Running
end

return this
