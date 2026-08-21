module("OBB", Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    if self.goPoolName then
        self:recover()
    else
        self:destroy()
    end
    LuaPoolMgr:poolRecover(self)
end

function create(self, center, rotation, extents)
    self.colType = "OBB"
    self:updateInfo(center, rotation, extents)
end

function updateInfo(self, center, rotation, extents)
    self.center = center
    self.rotation = rotation
    self.extents = extents
end

function compare(self, other)
    if other.colType == "OBB" then
        local v = MathTool:MV3Subtract(other.center, self.center)
        local vaX = MathTool:QuaternionMuatiplyMV3(self.rotation, MV3:create(1, 0, 0))
        local vaY = MathTool:QuaternionMuatiplyMV3(self.rotation, MV3:create(0, 1, 0))
        local vaZ = MathTool:QuaternionMuatiplyMV3(self.rotation, MV3:create(0, 0, 1))

        local VA = {}
        VA[0] = vaX
        VA[1] = vaY
        VA[2] = vaZ

        local vbX = MathTool:QuaternionMuatiplyMV3(other.rotation, MV3:create(1, 0, 0))
        local vbY = MathTool:QuaternionMuatiplyMV3(other.rotation, MV3:create(0, 1, 0))
        local vbZ = MathTool:QuaternionMuatiplyMV3(other.rotation, MV3:create(0, 0, 1))

        local VB = {}
        VB[0] = vbX
        VB[1] = vbY
        VB[2] = vbZ

        local T = {}
        T[0] = MathTool:MV3Dot(v, vaX)
        T[1] = MathTool:MV3Dot(v, vaY)
        T[2] = MathTool:MV3Dot(v, vaZ)

        local R = {}
        local FR = {}
        local ra
        local rb
        local t
        for i = 0, 3 do
            if (R[i] == nil) then
                R[i] = {}
            end

            for j = 0, 3 do
                R[i][j] = MathTool:MV3Dot(VA[i], VB[j])
                if (FR[i] == nil) then
                    FR[i] = {}
                end
                FR[i][j] = math.abs(R[i][j])
            end
        end

        for i = 0, 3 do
            ra = self.extents[i]
            rb = other.extents[0] * FR[i][0] + other.extents[1] * FR[i][1] + other.extents[2] * FR[i][2]
            t = math.abs(T[i])
            if (t > ra + rb) then
                return false
            end
        end

        for i = 0, 3 do
            ra = self.extents[0] * FR[0][i] + self.extents[1] * FR[1][i] + self.extents[2] * FR[2][i]
            rb = other.extents[i]
            t = math.abs(T[0] * R[0][i] + T[1] * R[1][i] + T[2] * R[2][i])
            if (t > ra + rb) then
                return false
            end
        end
        --A0*B0
        ra = self.extents[1]* FR[2][0] + self.extents[2]* FR[1][0]
        rb = other.extents[1]*FR[0][2] + other.extents[2]*FR[0][1]
        t = math.abs(T[2]*R[1][0] - T[1]*R[2][0])
        if (t > ra + rb) then
            return false
        end
        --A0*B1
        ra = self.extents[1]* FR[2][1] + self.extents[2]* FR[1][1]
        rb = other.extents[0]*FR[0][2] + other.extents[2]*FR[0][0]
        t = math.abs(T[2]*R[1][1] - T[1]*R[2][1])
        if (t > ra + rb) then
            return false
        end
        --A0*B2
        ra = self.extents[1]* FR[2][2] + self.extents[2]* FR[1][2]
        rb = other.extents[0]*FR[0][1] + other.extents[1]*FR[0][0]
        t = math.abs(T[2]*R[1][2] - T[1]*R[2][2])
        if (t > ra + rb) then
            return false
        end
        --A1*B0
        ra = self.extents[0]* FR[2][0] + self.extents[2]* FR[0][0]
        rb = other.extents[1]*FR[1][2] + other.extents[2]*FR[1][1]
        t = math.abs(T[0]*R[2][0] - T[2]*R[0][1])
        if (t > ra + rb) then
            return false
        end
        --A1*B1
        ra = self.extents[0]* FR[2][1] + self.extents[2]* FR[0][1]
        rb = other.extents[0]*FR[1][2] + other.extents[2]*FR[1][0]
        t = math.abs(T[0]*R[2][1] - T[2]*R[0][1])
        if (t > ra + rb) then
            return false
        end
        --A1*B2
        ra = self.extents[0]* FR[2][2] + self.extents[2]* FR[0][2]
        rb = other.extents[0]*FR[1][1] + other.extents[1]*FR[1][0]
        t = math.abs(T[0]*R[2][2] - T[2]*R[0][2])
        if (t > ra + rb) then
            return false
        end
         --A2*B0
         ra = self.extents[0]* FR[1][0] + self.extents[1]* FR[0][0]
         rb = other.extents[1]*FR[2][2] + other.extents[2]*FR[2][1]
         t = math.abs(T[1]*R[0][0] - T[0]*R[1][0])
         if (t > ra + rb) then
             return false
         end
         --A2*B1
         ra = self.extents[0]* FR[1][1] + self.extents[1]* FR[0][1]
         rb = other.extents[0]*FR[2][2] + other.extents[2]*FR[2][0]
         t = math.abs(T[1]*R[0][1] - T[0]*R[1][1])
         if (t > ra + rb) then
             return false
         end
         --A2*B2
         ra = self.extents[0]* FR[1][2] + self.extents[1]* FR[0][2]
         rb = other.extents[0]*FR[2][1] + other.extents[1]*FR[2][0]
         t = math.abs(T[1]*R[0][2] - T[0]*R[1][2])
         if (t > ra + rb) then
             return false
         end
    end
    return false
end

return _M
