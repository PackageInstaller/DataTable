local this = L_BevTree:registClass("guide.componentVisibleControl", L_BevTree.action)

function this:param()
  self.pageName = ""
  self.targetPath = ""
  self.visibleControl = 0
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.targetPath = self:getParam("targetPath")
  self.visibleControl = self:getParam("visibleControl", true)
end

function this:onEnter()
  local page = L_UI:getPage(self.pageName)
  if page ~= nil then
    local isActive = self.visibleControl ~= 0
    if string.isEmpty(self.targetPath) then
      self:saveComponentStatus(page.gameObject)
      page.gameObject:SetActive(isActive)
    else
      local nodePaths = string.split(self.targetPath, "|")
      for k, nodePath in ipairs(nodePaths) do
        local node = page.gameObject.transform:Find(nodePath)
        if node ~= nil then
          self:saveComponentStatus(node.gameObject)
          node.gameObject:SetActive(isActive)
        end
      end
    end
  else
    printf("guide提示", "没找到父节点  ID: " .. self.id)
    self.result = L_BevTree.taskResult.Failure
  end
  self.result = L_BevTree.taskResult.Success
end

function this:saveComponentStatus(node)
  if not self.tree.componentStatus then
    self.tree.componentStatus = {}
  end
  if not self.tree.componentStatus[node.name] then
    self.tree.componentStatus[node.name] = {}
    self.tree.componentStatus[node.name].node = node
    self.tree.componentStatus[node.name].activeSelf = node.activeSelf
  end
end

function this:execute()
  return self.result
end

function this:onReset()
  if self.lastResult == L_BevTree.taskResult.Success and self.tree.componentStatus ~= nil then
    for k, nodeData in pairs(self.tree.componentStatus) do
      if L_CommonUtil.isValid(nodeData.node) then
        nodeData.node:SetActive(nodeData.activeSelf)
      end
    end
    self.tree.componentStatus = nil
  end
end

return this
