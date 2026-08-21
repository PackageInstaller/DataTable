module('build.BuildWorldVo', Class.impl())

-- 解析并初始化一个碰撞世界对象，保存显示对象、碰撞形状、分组和回调信息
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

-- 根据配置的碰撞形状创建实际碰撞类实例；当前支持球形、轴对齐包围盒和有向包围盒
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
    local uiRootScale = GameView.stage:GetComponent(ty.RectTransform).localScale
    if self.selfGroup == build.BuildGroup.Groud then
        self.radius = 15 * self.scale.x * uiRootScale.x
    else
        self.radius = 26 * self.scale.x * uiRootScale.x
    end
    
end

-- 更新轴对齐包围盒数据；当前使用固定尺寸，原本按 Collider2D bounds 计算的方案保留为备用
function updateAABBInfo(self)
    self:getComInfo()
    -- 备用方案：使用缩放后的碰撞盒尺寸
    -- local x = self.scale.x * self.colliderShape.size.x
    -- local y = self.scale.y * self.colliderShape.size.y
    -- local z = self.scale.z * self.colliderShape.size.z

    -- 调试输出：查看当前缩放和碰撞盒尺寸
    -- cusLog(self.scale)
    -- cusLog(self.colliderShape.size)

    local v3 = {x= 6.66, y = 7.65, z = 0} -- 备用对象池写法：LuaPoolMgr:poolGet(MV3)
    --v3:create(x, y, z)
    self.size = v3
    -- return v3:create(x, y, z)
end

-- 更新有向包围盒数据，根据对象缩放和碰撞形状计算三个轴向半长
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

-- 按当前形状重新计算碰撞数据，并同步更新底层碰撞类实例
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

-- 回收底层碰撞类并清空引用，防止对象池复用时携带上一轮数据
function clearAll(self)
    if self.worldClass then
        LuaPoolMgr:poolRecover(self.worldClass)
        self.worldClass = nil
    end
    -- 备用清理方式：由碰撞类自己实现回收
    --self.worldClass:poolRecover()
    -- key 保留由外部字典管理，必要时可在这里清空
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

function debugCenter(self)
   
    return "x:"..self.cur.x.." y:"..self.cur.y.." z:"..self.cur.z
end

return _M
