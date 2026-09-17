local this = class("treeNode")

function this:ctor(data)
  self.parent = nil
  self.child = nil
  self.data = data
end

function this:getParent()
  return self.parent
end

function this:getData()
  return self.data
end

function this:isRoot()
  return self.parent == nil
end

function this:isLeaf()
  return table.isEmpty(self.child)
end

function this:insert(child)
  child.parent = self
  self.child = self.child or {}
  table.insert(self.child, child)
end

function this:insertChild(data)
  local child = L_Struct.getTreeNode(data)
  self:insert(child)
  return child
end

function this:set(child)
  child.parent = self
  self.child = self.child or {}
  self.child[child] = child
end

function this:setChild(key, data)
  local child = L_Struct.getTreeNode(data)
  self:set(child)
  return child
end

function this:remove(node)
  table.removeBy(self.child, node, true)
  if next(self.child) == nil then
    self.child = nil
  end
end

function this:removeByKey(key)
  self.child[key] = nil
  if next(self.child) == nil then
    self.child = nil
  end
end

function this:clear()
  self.child = {}
end

return this
