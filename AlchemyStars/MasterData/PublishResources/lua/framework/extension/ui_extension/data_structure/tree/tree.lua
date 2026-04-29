_class("Tree", Object)
Tree = Tree

function Tree:Constructor(head)
  self.head = head
end

function Tree:DFS(id)
  local head = self.head
  local temp
  if head then
    if id == head.id then
      temp = head
    else
      for i = 1, head:GetChildCount() do
        temp = temp or self:DFS(id)
      end
    end
  end
  return temp
end

function Tree:BFT(func)
  local head = self.head
  local node
  local queue = {}
  head.level = 0
  table.insert(queue, head)
  while table.count(queue) ~= 0 do
    node = queue[1]
    table.remove(queue, 1)
    for i = 1, node:GetChildCount() do
      local child = node.children[i]
      child.level = node.level + 1
      table.insert(queue, child)
      if func then
        func(child)
      end
    end
  end
end

function Tree:Free(head)
  if head ~= nil then
    head = nil
  end
end

_class("TreeNode", Object)
TreeNode = TreeNode

function TreeNode:Constructor(id)
  self.id = id
  self.level = 0
  self.parent = nil
  self.children = {}
end

function TreeNode:AddChild(child)
  child.parent = self
  table.insert(self.children, child)
end

function TreeNode:GetChildCount()
  return table.count(self.children)
end
