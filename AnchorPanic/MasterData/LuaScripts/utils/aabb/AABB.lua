module("AABB", Class.impl())

function create(self, pos, size)
    self.colType = "AABB"
    self:updateInfo(pos, size)
end

function updateInfo(self, pos, size)
    local mv3min = {x = pos.x - size.x / 2, y = pos.y - size.y / 2, z = pos.z - size.z / 2} -- LuaPoolMgr:poolGet(MV3)
    --mv3min:create(pos.x - size.x / 2, pos.y - size.y / 2, pos.z - size.z / 2)
    self.min = mv3min
    local mv3max =  {x = pos.x + size.x / 2, y = pos.y + size.y / 2, z = pos.z + size.z / 2} -- LuaPoolMgr:poolGet(MV3)
    --mv3max:create(pos.x + size.x / 2, pos.y + size.y / 2, pos.z + size.z / 2)
    self.max = mv3max
end

function compare(self, other)
    if other.colType == "AABB" then
        if self.max.x < other.min.x or self.min.x > other.max.x then
            return false
        end
        if self.max.y < other.min.y or self.min.y > other.max.y then
            return false
        end
        if self.max.z < other.min.z or self.min.z > other.max.z then
            return false
        end
    elseif other.colType == "OBB" then
        -- 暂不需要实现
        return false
    elseif other.colType == "Sphere" then
        local x = other.center.x
        local y = other.center.y
        --local z = other.center.z
        if x > self.max.x then
            x = self.max.x
        end
        if x < self.min.x then
            x = self.min.x
        end
        if y > self.max.y then
            y = self.max.y
        end
        if y < self.min.y then
            y = self.min.y
        end
        -- if z > self.max.z then
        --     z = self.max.z
        -- end
        -- if z < self.min.z then
        --     z = self.min.z
        -- end
        local distance = (x - other.center.x) * (x - other.center.x) + (y - other.center.y) * (y - other.center.y) 
                            --+(z - other.center.z) * (z - other.center.z)
        if other.radius * other.radius >= distance then
            return true
        end
    end
    return false
end

return _M
