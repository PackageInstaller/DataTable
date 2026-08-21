
---@class Bezier
local Bezier = {}
--二次贝塞尔
---@param t number 进度0-1
---@param p0 Vector2 起始点
---@param p1 Vector2 控制点
---@param p2 Vector2 结束点
---@return Vector2 坐标
function Bezier:GetBezierPoint(t, p0, p1, p2)
    local p0p1 = p0 * (1 - t) + p1 * t
    local p1p2 = p1 * (1 - t) + p2 * t
    local result = p0p1 * (1 - t) + p1p2 * t
    return result
end

--三次贝塞尔
function Bezier:GetTwoBezierPoint(t, p0, p1, p2,p3)
    local p0_1 = Vector3.Lerp(p0,p1,t)
    local p1_2 = Vector3.Lerp(p1,p2,t)
    local p2_3 = Vector3.Lerp(p2,p3,t)
    local p0_1_1_2 = Vector3.Lerp(p0_1,p1_2,t)
    local p1_2_2_3 = Vector3.Lerp(p1_2,p2_3,t)
    local p0_1_1_2_1_2_2_3 = Vector3.Lerp(p0_1_1_2,p1_2_2_3,t)
    return p0_1_1_2_1_2_2_3
end

return Bezier


