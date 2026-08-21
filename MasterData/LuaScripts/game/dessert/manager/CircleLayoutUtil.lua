-- -- CircleLayoutUtil.lua
-- -- 圆形布局算法工具类

-- local CircleLayoutUtil = {}

-- -- 计算两个向量的点积
-- function CircleLayoutUtil.Dot(lhs, rhs)
--     return lhs.x * rhs.x + lhs.y * rhs.y
-- end

-- -- 计算两个向量的夹角（度数）
-- function CircleLayoutUtil.Angle(from, to)
--     local num = math.sqrt(from.x * from.x + from.y * from.y) * math.sqrt(to.x * to.x + to.y * to.y)
--     if num < 0.00000000001 then return 0 end
--     local dot = CircleLayoutUtil.Dot(from, to)
--     local cos = math.max(-1, math.min(1, dot / num))
--     return math.acos(cos) * 57.29578
-- end

-- -- 带符号的有向角度（度数）
-- function CircleLayoutUtil.SignedAngle(from, to)
--     local angle = CircleLayoutUtil.Angle(from, to)
--     local sign = math.sign(from.x * to.y - from.y * to.x)
--     return angle * sign
-- end

-- -- 角度差（带符号，范围 -180 到 180）
-- function CircleLayoutUtil.DeltaAngle(fromDeg, toDeg)
--     local diff = (toDeg - fromDeg) % 360
--     if diff > 180 then diff = diff - 360 end
--     return diff
-- end

-- -- 根据弦长和半径计算圆心角（弧度）
-- function CircleLayoutUtil.ChordToAngle(chord, radius)
--     if chord <= 0 then return 0 end
--     local half = chord / (2 * radius)
--     if half > 1 then half = 1 end
--     return 2 * math.asin(half)
-- end

-- -- 根据半径缩放比例（基础半径50）
-- function CircleLayoutUtil.ScaleFromRadius(radius, baseRadius)
--     baseRadius = baseRadius or 50
--     return radius / baseRadius
-- end

-- -- 计算物体在圆上的位置（根据圆心、半径和角度）
-- function CircleLayoutUtil.PointOnCircle(center, radius, angleRad)
--     return gs.Vector2(
--         center.x + math.cos(angleRad) * radius,
--         center.y + math.sin(angleRad) * radius
--     )
-- end

-- -- 计算从圆心指向某点的角度（弧度）
-- function CircleLayoutUtil.AngleToPoint(center, point)
--     local dx = point.x - center.x
--     local dy = point.y - center.y
--     return math.atan2(dy, dx)
-- end

-- return CircleLayoutUtil