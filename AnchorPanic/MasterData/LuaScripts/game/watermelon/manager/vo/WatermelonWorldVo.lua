module('watermelon.WatermelonWorldVo', Class.impl())

function parseData(self, key, level, obj, colType, selfGroup, colGroup, motion, scale, enterCallback,
    stayCallback, exitCallback)
    self.key = key
    self.level = level
    self.obj = obj
    self.colType = colType
    self.selfGroup = selfGroup
    self.colGroup = colGroup
    self.motion = motion
    self.scale = scale
    --self.thisArg = thisArg
    self.enterCallback = enterCallback
    self.stayCallback = stayCallback
    self.exitCallback = exitCallback
    self:initColType()
end

function initColType(self)
    if self.colType == "Sphere" then
        self:updateSphereInfo()
        self.worldClass = LuaPoolMgr:poolGet(Sphere)
        self.worldClass:create(self.cur, self.radius)
    elseif self.colType == "AABB" then
        self:updateAABBInfo()
        self.worldClass = LuaPoolMgr:poolGet(AABB)
        self.worldClass:create(self.cur, self.size)
    elseif self.colType == "OBB" then
        self:updateOBBInfo()
        self.worldClass = LuaPoolMgr:poolGet(OBB)
        self.worldClass:create(self.cur, self.obj.transform.rotation, self.extents)
    end
end

function getComInfo(self)
    self.pos = MathTool:V3ToMV3(self.obj.transform.position)
    self.scale = MathTool:V3ToMV3(self.obj.transform.localScale)
    self.collider = self.obj:GetComponent(ty.Collider2D)
    --self.colliderShape = self.collider.bounds
    -- self.offset = MathTool:V2ToMV3(self.collider.offset.x, self.collider.offset.y)
    -- self.cur = MathTool:MV3Add(self.pos, self.offset)
    --self.offset = {x = 0,y = 0,z = 0}
    self.cur = self.pos
end

function updateSphereInfo(self)
    self:getComInfo()

    self.radius = 1.10 * self.scale.x
end

function updateAABBInfo(self)
    self:getComInfo()
    -- local x = self.scale.x * self.colliderShape.size.x
    -- local y = self.scale.y * self.colliderShape.size.y
    -- local z = self.scale.z * self.colliderShape.size.z

    -- cusLog(self.scale)
    -- cusLog(self.colliderShape.size)

    local v3 = {x= 6.66, y = 7.65, z = 0} -- LuaPoolMgr:poolGet(MV3)
    --v3:create(x, y, z)
    self.size = v3
    -- return v3:create(x, y, z)
end

function updateOBBInfo(self)
    self:getComInfo()
    local x = self.scale.x * self.colliderShape.x
    local y = self.scale.y * self.colliderShape.y
    local z = self.scale.z * self.colliderShape.z
    self.extents = {}
    self.extents[1] = x / 2
    self.extents[2] = y / 2
    self.extents[3] = z / 2
end

function getRectangle(self)
    local rect = LuaPoolMgr:poolGet(Rectangle)
    if self.colType == "Sphere" then
        rect:create(self.cur.x - self.radius, self.cur.y - self.radius, self.cur.x + self.radius,
            self.cur.y + self.radius)
    elseif self.colType == "AABB" then
        rect:create(self.cur.x - self.size.x / 2, self.cur.y - self.size.y / 2, self.cur.x + self.size.x / 2,
            self.cur.y + self.size.y / 2)
    elseif self.colType == "OBB" then
    end
    return rect
end

function updateWordlInfo(self)
    if self.colType == "Sphere" then
        if self.scale then
            self:updateSphereInfo()
        end
        self.worldClass:updateInfo(self.pos, self.radius)
    elseif self.colType == "AABB" then
        if self.scale then
            self:updateAABBInfo()
        end
        self.worldClass:updateInfo(self.pos, self.size)
    elseif self.colType == "OBB" then
        if self.scale then
            self:updateAABBInfo()
        end
        self.worldClass:updateInfo(self.pos, self.obj.transform.rotation, self.extents)
    end
end

function compare(self, otherworld)
    return self.worldClass:compare(otherworld.worldClass)
end

function enterCallFunc(self, otherworld)
    if self.enterCallback and otherworld then
        self.enterCallback(otherworld)
    end
end

function stayCallFunc(self, otherworld)
    if self.stayCallback and otherworld then
        self.stayCallback(otherworld)
    end
end

function exitCallFunc(self, otherworld)
    if self.exitCallback and otherworld then
        self.exitCallback(otherworld)
    end
end

function clearAll(self)
    if self.worldClass then
        LuaPoolMgr:poolRecover(self.worldClass)
        self.worldClass = nil
    end
    --self.worldClass:poolRecover()
    --self.key = nil
    self.level = nil
    self.obj = nil
    self.colType = nil
    self.selfGroup = nil
    self.colGroup = nil
    self.motion = nil
    self.scale = nil
    self.thisArg = nil
    self.enterCallback = nil
    self.stayCallback = nil
    self.exitCallback = nil
end

return _M
