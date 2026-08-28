--
-- Author:luqucheng
-- Date: 2019-11-07 10:36:47
--
local TreeNode = Class("TreeNode")

TreeNode.data = nil
TreeNode.children = nil
TreeNode.parent = nil


function  TreeNode:__init(data)
    self.data = data
    self.children = {}
end

function TreeNode:AddChild( treeNode )
    table.insert( self.children,treeNode )
    treeNode.parent = self
end


function TreeNode:ToData(  )
    if self.data then
        self.data = self.data:ToData()
    end

    for i,node in ipairs(self.children) do
        node:ToData()
    end

    for k,v in pairs(self) do
        if k ~= 'children' and k ~= 'data' then
            self[k] = nil
        end
    end
end

return  TreeNode