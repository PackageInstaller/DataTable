--两个π的数值
local M_PI2 = math.pi*2
--π/2的数值
local M_HPI = math.pi*0.5
--1弧度=180/π度
local M_RADIAN = 180/math.pi
--1度=π/180弧度
local M_ANGLE = math.pi/180


-- 通过两点获取角度
function math.get_angle_ignoreY(v,v2)
    local deg = math.deg(math.Vector3.angle(v,v2))
    local temp = v.x*v2.z - v2.x*v.z
    return temp > 0 and (360 - deg) or deg
end

-- 两点距离
function math.v3Distance(v3_1,v3_2)
    local tmp = math.Vector3.sub(v3_1, v3_2, math.Vector3())
    return tmp:length()
end
-- 两点距离(大体距离, 通常用于比较判断的情况下, 性能更高)
function math.v3DistanceNoSqrt(v3_1,v3_2)
    local tmp = math.Vector3.sub(v3_1, v3_2, math.Vector3())
    return (tmp.x * tmp.x + tmp.y * tmp.y + tmp.z * tmp.z)
end

--[[_s 判断点目标点是否在扇形范围内
faceAngle:朝向的角度(360)
rangeAngle:范围的角度(360)
centerX, centerY 中心点
targetX, targetY 判断的目标点
radiusMin, radiusMax 范围半径的最小、最大值, radiusMin默认为0， 即从圆心出发
targetOffsetRange 偏移半径, 即目标自身可以带有触发半径, 默认为0
]]
function math.isInSector(faceAngle, rangeAngle, centerX, centerY, targetX, targetY, radiusMax, targetOffsetRange, radiusMin)
    faceAngle = math.formatAngle(faceAngle)
    rangeAngle = math.formatAngle(rangeAngle)
    local dis = math.distanceXY(centerX, centerY, targetX, targetY)
    targetOffsetRange = targetOffsetRange or 0
    radiusMin = radiusMin or 0
    if ( (dis+targetOffsetRange)<radiusMin or (dis-targetOffsetRange)>radiusMax ) then
        return false
    end
    local angle = math.getTargeAngle(centerX, centerY, targetX, targetY)
    local halfRangeAngle = rangeAngle*0.5
    if math.abs(angle-faceAngle)<=halfRangeAngle then
        return true
    end
    local disAngle = faceAngle-halfRangeAngle
    local formatAngle = math.formatAngle(disAngle)
    if disAngle<0 or angle>=formatAngle then
        return true
    end
    if disAngle>360 or angle<=formatAngle then
        return true
    end
    return false
end

-- 格式化角度到0-360
function math.formatAngle(angle)
    while (angle < 0) do 
        angle = angle+360
    end
    while (angle > 360) do
        angle = angle-360
    end
    return angle
end

function math.distanceXY(fromX, fromY, toX, toY)
    local diffLogicX = toX - fromX
    local diffLogicY = toY - fromY
    return math.sqrt(diffLogicX * diffLogicX + diffLogicY * diffLogicY)
end

-- 获取目标与中心点的角度
function math.getTargeAngle(centerX, centerY, targetX, targetY, n)
    if (targetX == centerX and targetY > centerY) then
        -- 在y轴负方向上
        return 180
    elseif (targetX > centerX and targetY == centerY) then
        -- 在x轴正方向上
        return 90
    elseif (targetX < centerX and targetY == centerY) then
        -- 在x轴负方向
        return 270
    end
    -- 获得人物中心和目标坐标连线，与y轴正半轴之间的夹角
    local y = math.abs(centerY-targetY)
    local cos = 0
    if (y~=0) then
        local x = math.abs(centerX-targetX)
        local z = math.sqrt(math.pow(x, 2) + math.pow(y, 2))
        cos = y / z
    end
    local radina = math.acos(cos) -- 用反三角函数求弧度
    local angle =  M_RADIAN * radina -- 将弧度转换成角度
    if(n ~= nil and n > 0)then
        local count = 1
        for i = 1, n do
            count = count * 10
        end
        angle = math.floor( angle * count) / count
    end
    
    if (targetX > centerX and targetY > centerY) then
        -- 在第四象限
        angle = 180 - angle
    elseif (targetX < centerX and targetY > centerY) then
        -- 在第三象限
        angle = 180 + angle
    elseif (targetX < centerX and targetY < centerY) then
        -- 在第二象限
        angle = 360 - angle
    end
    return angle
end

--[[ 背后滑动
startPos 滑动的开始位置
startAngle 滑动的开始角度
disMeter 滑动距离
--]]
function math.slideBack(startPos, startAngle, disMeter)
    if disMeter == 0 then return end

    local tempAngle = - startAngle - 90
    local x = math.cos(tempAngle * M_ANGLE)
    local z = math.sin(tempAngle * M_ANGLE)
    local v3Nor = math.Vector3(x,0,z):normalize()
    return math.slideDir(startPos, v3Nor, disMeter)
end

--[[ 获取向某个方向移动的最终目标位置
startPos 滑动的开始位置
v3Nor 方向向量
disMeter 滑动距离
--]]
function math.slideDir(startPos, v3Nor, disMeter)
    local toX = startPos.x + v3Nor.x * disMeter;
    local toZ = startPos.z + v3Nor.z * disMeter;
    return math.Vector3(toX,0,toZ)
end

--[[判断点是否在矩形内
 (x1, y1)为最左的点，(x2, y2)为最上的点，(x3, y3)为最下的点，(x4, y4)为最右的点
矩形的边平行于坐标轴
（x1, y1）为左上角的点，（x2, y2）为右上角的点，（x3, y3）为左下角的点，（x4, y4)为右下角的点
]]
function math.isInRect(x,y, x1,y1, x2,y2, x3,y3, x4,y4)
    if y1==y2 then
        return math.isInNorRect(x,y, x1,y1, x4,y4)
    end
    local dx = x4 - x3
    local dy = y4 - y3
    local ds = math.sqrt(dx * dx + dy * dy)
    local sint = dy / ds;
    local cost = dx / ds;

    local x1r = cost * x1 + sint * y1
    local y1r = -x1 * sint + y1 * cost
    local x4r = cost * x4 + sint * y4
    local y4r = -x4 * sint + y4 * cost
    local xr = cost * x + sint * y
    local yr = -x * sint + y * cost
    return math.isInNorRect(xr, yr, x1r, y1r, x4r, y4r)
end

function math.isInNorRect(x,y, x1,y1, x4,y4)
    if (x <= x1) then return false end
    if (x >= x4) then return false end
    if (y >= y1) then return false end
    if (y <= y4) then return false end
    return true
end

-- 线段与线段交点
function math.pointSegments(x1, y1, x2, y2, x3, y3, x4, y4)
    local s10_x = x2 - x1
    local s10_y = y2 - y1
    local s32_x = x4 - x3
    local s32_y = y4 - y3

    local denom = s10_x * s32_y - s32_x * s10_y
    if (denom == 0) then--平行或共线
        return
    end
    local denomPositive = denom > 0
    local s02_x = x1 - x3
    local s02_y = y1 - y3
    local s_numer = s10_x * s02_y - s10_y * s02_x;
    if (s_numer < 0) == denomPositive then --参数是大于等于0且小于等于1的，分子分母必须同号且分子小于等于分母
        return -- 无交点
    end
    local t_numer = s32_x * s02_y - s32_y * s02_x
    if (t_numer < 0) == denomPositive then
        return -- 无交点
    end

    if math.abs(s_numer) > math.abs(denom) or math.abs(t_numer) > math.abs(denom) then
        return -- 无交点
    end
    -- 有交点
    local t = t_numer / denom
    return x1 + (t * s10_x), y1 + (t * s10_y)
end

-- 线段与矩形交点
function math.pointLineRectangular (x1,y1, x2,y2, xr1, yr1, xr2, yr2, xr3, yr3)
    -- 接下来依次求解直线与构成矩形的四条线段的交点
    -- 设置是否有交点的标志
    local rx, ry = math.pointSegments(x1,y1, x2,y2, xr1, yr1, xr2, yr2)
    if rx then
        return rx, ry
    end
    rx, ry = math.pointSegments(x1,y1, x2,y2, xr2, yr2, xr3, yr3)
    if rx then
        return rx, ry
    end
    --定义矩形第四个点的横纵坐标
    local xr4 = xr1 + xr3 - xr2
    local yr4 = yr1 + yr3 - yr2
    rx, ry = math.pointSegments(x1,y1, x2,y2, xr3, yr3, xr4, yr4)
    if rx then
        return rx, ry
    end
    rx, ry = math.pointSegments(x1,y1, x2,y2, xr4, yr4, xr1, yr1)
    if rx then
        return rx, ry
    end
end

