--
-- Author:luqucheng
-- Date: 2019-11-07 10:33:23
--
local Tree = Class("Tree")
Tree.root = nil

function  Tree:__init( root )
    self.children = {}
    self.root = root
end

return  Tree