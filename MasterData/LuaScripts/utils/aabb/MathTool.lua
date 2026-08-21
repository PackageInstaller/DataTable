module("MathTool", Class.impl())

function V2ToMV3(self, x, y)
    local mv3 = {
        x = x,
        y = y,
        z = 0
    } -- LuaPoolMgr:poolGet(MV3)
    -- mv3:create(x, y, 0)
    return mv3
end

function V3ToMV3(self, v3)
    local mv3 = {
        x = v3.x,
        y = v3.y,
        z = v3.z
    } -- LuaPoolMgr:poolGet(MV3)
    -- mv3:create(v3.x, v3.y, v3.z)
    return mv3
end

function MV3ToV3(self, mv3)
    return gs.Vector3(mv3.x, mv3.y, mv3.z)
end

function MV3Dot(self, a, b)
    return a.x * b.x + a.y * b.y
    -- + a.z * b.z
end

function MV3Add(self, a, b)
    local mv3 = {
        x = a.x + b.x,
        y = a.y + b.y,
        z = a.z + b.z
    } -- LuaPoolMgr:poolGet(MV3)
    -- mv3:create(a.x + b.x, a.y + b.y, a.z + b.z)
    return mv3
end

function MV3Subtract(self, a, b)
    local mv3 = {
        x = a.x - b.x,
        y = a.y - b.y,
        z = a.z - b.z
    } -- LuaPoolMgr:poolGet(MV3)
    -- mv3:create(a.x - b.x, a.y - b.y, a.z - b.z)
    return mv3
end

function MV2Subtract(self, a, b)
    local mv3 = {
        x = a.x - b.x,
        y = a.y - b.y,
        0
    } -- LuaPoolMgr:poolGet(MV3)
    -- mv3:create(a.x - b.x, a.y - b.y, a.z - b.z)
    return mv3
end

function MV3Multiply(self, a, b)
    local mv3 = LuaPoolMgr:poolGet(MV3)
    mv3:create(a.x * b.x, a.y * b.y, a.z * b.z)
    return mv3
end

function MV3Divide(self, a, b)
    local mv3 = LuaPoolMgr:poolGet(MV3)
    mv3:create(a.x / b.x, a.y / b.y, a.z / b.z)
    return mv3
end

function MV3SqrMagnitude(self, a, b)
    return a.x * a.x + a.y * a.y + a.z * a.z
end

function MV3Equal(self, a, b)
    return self:SqrMagnitude(a, b) < 9.99999944e-11
end

function MV3Distance(self, a, b)
    local v3 = LuaPoolMgr:poolGet(MV3):create(a.x - b.x, a.y - b.y, a.z - b.z)
    v3:create(a.x - b.x, a.y - b.y, a.z - b.z)
    return math.sqrt(v3.x * v3.x + v3.y * v3.y + v3.z * v3.z)
end

function MV3DistanceNoSqrt(self, a, b)
    local v3 = LuaPoolMgr:poolGet(MV3)
    v3:create(a.x - b.x, a.y - b.y, a.z - b.z)
    return v3.x * v3.x + v3.y * v3.y + v3.z * v3.z
end

function MM4Multiply(self, a, b)
    local mv4 = LuaPoolMgr:poolGet(MV4)
    mv4:create(a.m00 * b.m00 + a.m01 * b.m10 + a.m02 * b.m20 + a.m03 * b.m30,

        a.m00 * b.m01 + a.m01 * b.m11 + a.m02 * b.m21 + a.m03 * b.m31,

        a.m00 * b.m02 + a.m01 * b.m12 + a.m02 * b.m22 + a.m03 * b.m32,

        a.m00 * b.m03 + a.m01 * b.m13 + a.m02 * b.m23 + a.m03 * b.m33,

        a.m10 * b.m00 + a.m11 * b.m10 + a.m12 * b.m20 + a.m13 * b.m30,

        a.m10 * b.m01 + a.m11 * b.m11 + a.m12 * b.m21 + a.m13 * b.m31,

        a.m10 * b.m02 + a.m11 * b.m12 + a.m12 * b.m22 + a.m13 * b.m32,

        a.m10 * b.m03 + a.m11 * b.m13 + a.m12 * b.m23 + a.m13 * b.m33,

        a.m20 * b.m00 + a.m21 * b.m10 + a.m22 * b.m20 + a.m23 * b.m30,

        a.m20 * b.m01 + a.m21 * b.m11 + a.m22 * b.m21 + a.m23 * b.m31,

        a.m20 * b.m02 + a.m21 * b.m12 + a.m22 * b.m22 + a.m23 * b.m32,

        a.m20 * b.m03 + a.m21 * b.m13 + a.m22 * b.m23 + a.m23 * b.m33,

        a.m30 * b.m00 + a.m31 * b.m10 + a.m32 * b.m20 + a.m33 * b.m30,

        a.m30 * b.m01 + a.m31 * b.m11 + a.m32 * b.m21 + a.m33 * b.m31,

        a.m30 * b.m02 + a.m31 * b.m12 + a.m32 * b.m22 + a.m33 * b.m32,

        a.m30 * b.m03 + a.m31 * b.m13 + a.m32 * b.m23 + a.m33 * b.m33)
    return mv4
end

function QuaternionMuatiplyMV3(self, rotation, point)
    local num = rotation.x * 2
    local num2 = rotation.y * 2
    local num3 = rotation.z * 2

    local num4 = rotation.x * num
    local num5 = rotation.y * num2
    local num6 = rotation.z * num3

    local num7 = rotation.x * num2
    local num8 = rotation.y * num3
    local num9 = rotation.z * num3

    local num10 = rotation.w * num
    local num11 = rotation.w * num2
    local num12 = rotation.w * num3
    local v3 = LuaPoolMgr:poolGet(MV3)
    local result = v3:create(0, 0, 0)

    result.x = (1 - (num5 + num6)) * point.x + (num7 - num12) * point.y + (num8 + num11) * point.z
    result.y = (num7 + num12) * point.x + (1 - (num4 + num6)) * point.y + (num9 - num10) * point.z
    result.z = (num8 - num11) * point.x + (num9 + num10) * point.y + (1 - (num4 + num5)) * point.z

    return result
end

function QuaternionMuatiplyV3(self, rotation, point)
    return self:MV3ToV3(self:QuaternionMuatiplyMV3(rotation, point))

end

return _M
