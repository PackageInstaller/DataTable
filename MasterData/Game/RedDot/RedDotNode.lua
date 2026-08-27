local RedDotNode = class("RedDotNode")

function RedDotNode:ctor(nodeId, parent, nodePath)
  self.nodeId = nodeId
  self.__dotCount = 0
  self.__blueDotCount = 0
  self.__childs = {}
  self.__childCount = 0
  self.__parent = parent
  if nodeId == nil then
    return
  end
  if nodePath ~= nil then
    self.nodePath = nodePath
  elseif self.__parent == nil then
    self.nodePath = nil
  elseif self.__parent.nodePath == nil then
    self.nodePath = tostring(self.nodeId)
  else
    self.nodePath = tostring(self.__parent.nodePath) .. "." .. tostring(self.nodeId)
  end
end

function RedDotNode:GetParentNode()
  return self.__parent
end

function RedDotNode:GetParentNodeId()
  if self.__parent == nil then
    return nil
  end
  return self.__parent.nodeId
end

function RedDotNode:GetChild(nodeId)
  return self.__childs[nodeId]
end

function RedDotNode:AddChild(nodeId)
  local node = self:GetChild(nodeId)
  if node ~= nil then
    return node
  end
  node = RedDotNode.New(nodeId, self)
  self.__childs[nodeId] = node
  self.__childCount = self.__childCount + 1
  return node
end

function RedDotNode:AddChildWithPath(nodeId, nodePath)
  local node = self:GetChild(nodeId)
  if node ~= nil then
    return node
  end
  node = RedDotNode.New(nodeId, self, nodePath)
  self.__childs[nodeId] = node
  self.__childCount = self.__childCount + 1
  return node
end

function RedDotNode:RemoveChild(nodeId, update)
  local node = self.__childs[nodeId]
  if node == nil then
    return false
  end
  update = update == nil and true or update
  self.__childs[nodeId] = nil
  self.__childCount = self.__childCount - 1
  self:ChangeRedDotCount(true)
  self:ChangeBlueDotCount(true)
  return true
end

function RedDotNode:RemoveFromParent()
  if self.__parent == nil then
    return false
  end
  return self.__parent:RemoveChild(self.nodeId)
end

function RedDotNode:ClearChild()
  if self.__childCount == 0 then
    return
  end
  self.__childs = {}
  self.__childCount = 0
  self:SetRedDotCount(0)
  self:SetBlueDotCount(0)
end

function RedDotNode:GetRedDotCount()
  return self.__dotCount
end

function RedDotNode:SetRedDotCount(num)
  assert(self.__childCount == 0, "红点数量只能设置叶子节点，请检查代码!!!")
  if self.__dotCount == num then
    return
  end
  self.__dotCount = num
  RedDotController:Broadcast(self.nodePath, self)
  if self.__parent ~= nil then
    self.__parent:ChangeRedDotCount()
  end
end

function RedDotNode:OffsetRedDotCount(offsetNum)
  self:SetRedDotCount(self.__dotCount + offsetNum)
end

function RedDotNode:ChangeRedDotCount(ignoreCheck)
  if not ignoreCheck then
    assert(self.__childCount > 0, "红点数量更新只能是非叶子节点，请检查代码!!!")
  end
  if self.nodeId == nil then
    return
  end
  local num = 0
  for k, node in pairs(self.__childs) do
    num = num + node:GetRedDotCount()
  end
  if num == self.__dotCount then
    return
  end
  self.__dotCount = num
  RedDotController:Broadcast(self.nodePath, self)
  if self.__parent ~= nil then
    self.__parent:ChangeRedDotCount()
  end
end

function RedDotNode:GetBlueDotCount()
  return self.__blueDotCount
end

function RedDotNode:SetBlueDotCount(num)
  assert(self.__childCount == 0, "蓝点数量只能设置叶子节点，请检查代码!!!")
  if self.__blueDotCount == num then
    return
  end
  self.__blueDotCount = num
  if self.__parent ~= nil then
    self.__parent:ChangeBlueDotCount()
  end
  RedDotController:Broadcast(self.nodePath, self)
end

function RedDotNode:OffsetBlueDotCount(offsetNum)
  self:SetBlueDotCount(self.__blueDotCount + offsetNum)
end

function RedDotNode:ChangeBlueDotCount(ignoreCheck)
  if not ignoreCheck then
    assert(self.__childCount > 0, "蓝点数量更新只能是非叶子节点，请检查代码!!!")
  end
  if self.nodeId == nil then
    return
  end
  local num = 0
  for k, node in pairs(self.__childs) do
    num = num + node:GetBlueDotCount()
  end
  if num == self.__blueDotCount then
    return
  end
  self.__blueDotCount = num
  if self.__parent ~= nil then
    self.__parent:ChangeBlueDotCount()
  end
  RedDotController:Broadcast(self.nodePath, self)
end

return RedDotNode
