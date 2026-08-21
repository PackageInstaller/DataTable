module("QuadTree", Class.impl())

function initTree(self, minX, maxX, minY, maxY, depth, parent)
    self.parent = parent
    self.depth = depth
    self.maxDepth = 8 -- 最大深度
    self.maxCapacity = 4 -- 分列容量
    self.rect = LuaPoolMgr:poolGet(Rectangle)
    self.rect:create(minX, maxX, minY, maxY, depth)
    self.objs = {} -- 对象列表
    self.children = nil
end

function insert(self, worldVo)
    local rect = worldVo:getRectangle()
    if not self.rect:hits(rect) then
        return
    end

    if self.children ~= nil then
        for k, v in pairs(self.children) do
            v:insert(worldVo)
        end
    else
        table.insert(self.objs, worldVo)
        if self.depth <= self.maxDepth and #self.objs >= self.maxCapacity then
            self:splitNode()
        end
    end
end

function updateWorld(self, worldVo)
    self:remove(worldVo)
    self:insert(worldVo)
end

function remove(self, worldVo)
    local index = table.indexof01(self.objs, worldVo)
    if index > 0 then
        table.remove(self.objs,index)
        if self.parent ~= nil then
            local c = 0
            if self.parent.children ~= nil then
                for k, v in pairs(self.parent.children) do
                    c = c + #v.objs
                end
    
                if c < self.maxCapacity then
                    local list = {}
                    for k, v in pairs(self.parent.children) do
                        for i = 1, #v.objs do
                            table.insert(list, v.objs[i])
                        end
                    end
                    self.parent.objs = list
                    self.parent.children = nil
                end
            end
        end
    end
    -- if self.objs
    if self.children ~= nil then
        for k, v in pairs(self.children) do
            v:remove(worldVo)
        end
    end
end

function query(self, worldVo)
    local rect = worldVo:getRectangle()
    if not self.rect:hits(rect) then
        return {}
    end

    local result = {}
    if (self.children ~= nil) then
        for k, v in pairs(self.children) do
            table.insert(result, v:query(worldVo))
        end
    else
        for k, v in pairs(self.objs) do
            if v:getRectangle():hits(rect) then
                table.insert(result, v)
            end
        end
    end
    return result
end

function splitNode(self)
    local r1 = LuaPoolMgr:poolGet(QuadTree)
    local r2 = LuaPoolMgr:poolGet(QuadTree)
    local r3 = LuaPoolMgr:poolGet(QuadTree)
    local r4 = LuaPoolMgr:poolGet(QuadTree)
    -- 左上
    r1:initTree(self.rect.minX, (self.rect.maxX - self.rect.minX) / 2, (self.rect.maxY - self.rect.minY) / 2,
        self.rect.maxY, self.depth + 1, self)
    -- 右上
    r2:initTree((self.rect.maxX - self.rect.minX) / 2, self.rect.maxX, (self.rect.maxY - self.rect.minY) / 2,
        self.rect.maxY, self.depth + 1, self)
    -- 右下
    r3:initTree((self.rect.maxX - self.rect.minX) / 2, self.rect.maxX, self.rect.minY,
        (self.rect.maxY - self.rect.minY) / 2, self.depth + 1, self)
    -- 左下
    r4:initTree(self.rect.minX, (self.rect.maxX - self.rect.minX) / 2, self.rect.minY,
        (self.rect.maxY - self.rect.minY) / 2, self.depth + 1, self)
    self.children = {}
    self.children[1] = r1
    self.children[2] = r2
    self.children[3] = r3
    self.children[4] = r4

    for k, v in pairs(self.children) do
        for i = 1, #self.objs do
            v:insert(self.objs[i])
        end
    end
    self.objs = {}
end

return _M
