module("QuadTreeItem", Class.impl())

function create(self,worldVo,rect)
    self.worldVo = worldVo
    self.rect = rect
end

return _M