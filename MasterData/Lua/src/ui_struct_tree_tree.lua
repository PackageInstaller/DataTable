local this = class("tree")

function this:ctor()
  self.root = nil
end

function this:createDefaultRoot(data)
  self.root = L_Struct.getTreeNode(data)
  return self.root
end

function this:getRoot()
  return self.root
end

function this:setRoot(root)
  self.root = root
end

function this:exist(math, serchMethod)
  if serchMethod == nil then
    serchMethod = self.bfs
  end
  local node = serchMethod(self, math)
  return node ~= nil
end

function this:bfs(match)
  local queue = {
    self.root
  }
  local node = queue[1]
  while node do
    if node.data and math(node.data) then
      return node
    elseif node.child then
      for _, v in pairs(node.child) do
        table.insert(queue, v)
      end
    end
    table.remove(queue, 1)
    node = queue[1]
  end
end

function this:dfs_preorder(match)
end

function this:dfs_inorder(match)
end

function this:dfs_postorder(match)
end

return this
