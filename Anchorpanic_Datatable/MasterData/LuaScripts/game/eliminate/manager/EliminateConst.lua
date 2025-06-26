-- 方向类型
eliminate.DirType = {
    Top = 1,            -- 上
    Botoom = 2,         -- 下
    Left = 3,           -- 左
    Right = 4,          -- 右

    LeftTop = 5,        -- 左上
    LeftBotoom = 6,     -- 左下
    RightTop = 7,       -- 右上
    RightBotoom = 8,    -- 右下

    Vertical  = 9,      -- 垂直向
    Horizontal = 10,    -- 水平向
}

-- 物件类型
eliminate.ThingType = {
    Empty = 0,              -- 无

    Tile = 10,              -- 网格：普通瓦片
    TileIce_1 = 11,         -- 网格：冰瓦片1
    TileIce_2 = 12,         -- 网格：冰瓦片2
    TileIce_3 = 13,         -- 网格：冰瓦片3

    ObstacleForbid = 20,    -- 物件：障碍物，不可操作、消除、置放
    ObstacleNormal = 21,    -- 物件：障碍物，不可操作、置放，可消除

    Candy_1 = 30,           -- 物件：糖果1
    Candy_2 = 31,           -- 物件：糖果2
    Candy_3 = 32,           -- 物件：糖果3
    Candy_4 = 33,           -- 物件：糖果4
    Candy_5 = 34,           -- 物件：糖果5
    Candy_6 = 35,           -- 物件：糖果6

    ClearSame = 40,         -- 物件：消除同类
    ClearRange = 41,        -- 物件：炸弹（范围消除）
    ClearRow = 42,          -- 物件：消除整行
    ClearCol = 43,          -- 物件：消除整列
    ClearRowCol = 44,       -- 物件：消除整行整列
}

-- 方块大小
eliminate.GetTileSize = function()
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    return stageConfigVo.tileSize
end

-- 根据行列获取key
eliminate.GetTileIdByRowCol = function(row, col)
    return row * 10000 + col
end

-- 地图网格大小
eliminate.GetMapSize = function(rowCount, colCount)
    local sizeX = colCount * eliminate.GetTileSize()
    local sizeY = rowCount * eliminate.GetTileSize()
    return sizeX, sizeY
end

-- 获取格子位置
eliminate.GetTileLocalPos = function(rowCount, colCount, rowIndex, colIndex)
    if(rowCount and colCount and rowIndex and colIndex)then
        local sizeX, sizeY = eliminate.GetMapSize(rowCount, colCount)
        local localPosX = colIndex * eliminate.GetTileSize() - eliminate.GetTileSize() / 2 - sizeX / 2
        local localPosY = rowIndex * eliminate.GetTileSize() - eliminate.GetTileSize() / 2 - sizeY / 2
        return localPosX, localPosY
    else
        return nil, nil
    end
end

-- 获取格子行列
eliminate.GetTileRowCol = function(rowCount, colCount, localPosition)
    local sizeX, sizeY = eliminate.GetMapSize(rowCount, colCount)
    local colIndex = math.floor((localPosition.x + sizeX / 2) / eliminate.GetTileSize()) + 1
    local rowIndex = math.floor((localPosition.y + sizeY / 2) /  eliminate.GetTileSize()) + 1
    return rowIndex, colIndex
end

-- 获取炸弹物件的清楚范围
eliminate.GetClearRangeCount = function()
    return 1
end

-- 获取是否道具
eliminate.GetIsProp = function(thingType)
    return thingType == eliminate.ThingType.ClearSame or thingType == eliminate.ThingType.ClearRange or thingType == eliminate.ThingType.ClearRow or thingType == eliminate.ThingType.ClearCol or thingType == eliminate.ThingType.ClearRowCol
end

-- 获取是否糖果
eliminate.GetIsCandy = function(thingType)
    return thingType == eliminate.ThingType.Candy_1 or thingType == eliminate.ThingType.Candy_2 or thingType == eliminate.ThingType.Candy_3 or thingType == eliminate.ThingType.Candy_4 or thingType == eliminate.ThingType.Candy_5 or thingType == eliminate.ThingType.Candy_6
end

-- 是否可移动
eliminate.GetIsCanMove = function(thingType)
    return thingType ~= eliminate.ThingType.Empty and thingType ~= eliminate.ThingType.Tile and thingType ~= eliminate.ThingType.TileIce_1 and thingType ~= eliminate.ThingType.TileIce_2 and thingType ~= eliminate.ThingType.TileIce_3 and thingType ~= eliminate.ThingType.ObstacleForbid and thingType ~= eliminate.ThingType.ObstacleNormal
end

-- 获取随机物件
eliminate.GetRandomThingType = function()
    local list = nil
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    if(stageConfigVo and not table.empty(stageConfigVo.dropThingTypeList))then
        list = stageConfigVo.dropThingTypeList
    else
        table.insert(list, eliminate.ThingType.Candy_1)
        table.insert(list, eliminate.ThingType.Candy_2)
        table.insert(list, eliminate.ThingType.Candy_3)
        table.insert(list, eliminate.ThingType.Candy_4)
        table.insert(list, eliminate.ThingType.Candy_5)
        table.insert(list, eliminate.ThingType.Candy_6)
    end
    
    -- local randomThingType = math.random(eliminate.ThingType.ClearSame, eliminate.ThingType.ClearSame + 10)
    -- if(randomThingType <= eliminate.ThingType.ClearRowCol)then
    --     table.insert(list, randomThingType)
    -- end

    local randowmIdnex = math.random(1, #list)
    return list[randowmIdnex]
end

-- 物件是否允许被打乱
eliminate.GetIsCanShuffle = function(thingType)
    if(eliminate.GetIsCandy(thingType) or eliminate.GetIsProp(thingType))then
        return true
    else
        return false
    end
end

-- 两个格子类型是否可匹配
eliminate.GetIsCanMatch = function(thingType1, thingType2)
    if(thingType1 and thingType2)then
        if(eliminate.GetIsCandy(thingType1) and eliminate.GetIsCandy(thingType2))then
            return thingType1 == thingType2
        end
    else
        return false
    end
end

-- 两个格子是否可以交换
eliminate.GetIsCanSwap = function(thingType, adjoinThingType)
    if(thingType and adjoinThingType)then
        if(not eliminate.GetIsCanMove(thingType) or not eliminate.GetIsCanMove(adjoinThingType))then
            return false
        end
        if(eliminate.GetIsProp(thingType) and eliminate.GetIsCandy(adjoinThingType))then
            return true
        end
        if(eliminate.GetIsCandy(thingType) and eliminate.GetIsProp(adjoinThingType))then
            return true
        end
        if(eliminate.GetIsProp(thingType) and eliminate.GetIsProp(adjoinThingType) and (thingType ~= eliminate.ThingType.ClearSame or adjoinThingType ~= eliminate.ThingType.ClearSame))then
            return true
        end
        if(eliminate.GetIsCandy(thingType) and eliminate.GetIsCandy(adjoinThingType))then
            return true
        end
    end
    return false
end

-- 检查是否相邻
eliminate.GetIsAdjoin = function(startThingVo, endThingVo)
    if(startThingVo and endThingVo)then
        if(startThingVo ~= endThingVo)then
            if(startThingVo.rowIndex == endThingVo.rowIndex and math.abs(startThingVo.colIndex - endThingVo.colIndex) == 1)then
                return true
            end
            if(startThingVo.colIndex == endThingVo.colIndex and math.abs(startThingVo.rowIndex - endThingVo.rowIndex) == 1)then
                return true
            end
        end
    end
    return false
end

-- 获取波及区域
eliminate.GetAffectRowColArea = function(...)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    if select("#", ...) > 0 then
        local thingVoList = {...}
        local minRowIndex, minColIndex, maxRowIndex, maxColIndex = nil, nil, nil, nil
        for _, thingVo in pairs(thingVoList) do
            minRowIndex = minRowIndex and math.min(minRowIndex, thingVo.rowIndex) or thingVo.rowIndex
            minColIndex = minColIndex and math.min(minColIndex, thingVo.colIndex) or thingVo.colIndex
            
            maxRowIndex = maxRowIndex and math.max(maxRowIndex, thingVo.rowIndex) or thingVo.rowIndex
            maxColIndex = maxColIndex and math.max(maxColIndex, thingVo.colIndex) or thingVo.colIndex
        end
        return math.max(minRowIndex - 2, 1), math.max(minColIndex - 2, 1), math.min(maxRowIndex + 2, stageConfigVo.mapRow), math.min(maxColIndex + 2, stageConfigVo.mapCol)
    else
        return 1, 1, stageConfigVo.mapRow, stageConfigVo.mapCol
    end
end

-- 检查是否大T形状
eliminate.GetIsShapeBigT = function(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
    -- 朝上的T形
    if(aboveThingVo1 and aboveThingVo2 and leftThingVo1 and leftThingVo2 and rightThingVo1 and rightThingVo2)then
        return eliminate.DirType.Top
    end
    -- 朝下的T形
    if(belowThingVo1 and belowThingVo2 and leftThingVo1 and leftThingVo2 and rightThingVo1 and rightThingVo2)then
        return eliminate.DirType.Bottom
    end
    -- 朝左的T形
    if(leftThingVo1 and leftThingVo2 and aboveThingVo1 and aboveThingVo2 and belowThingVo1 and belowThingVo2)then
        return eliminate.DirType.Left
    end
    -- 朝右的T形
    if(rightThingVo1 and rightThingVo2 and aboveThingVo1 and aboveThingVo2 and belowThingVo1 and belowThingVo2)then
        return eliminate.DirType.Right
    end
    return false
end

-- 检查是否中T形状
eliminate.GetIsShapeMiddleT = function(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
    -- 朝上的T形
    if((aboveThingVo1 and aboveThingVo2 and leftThingVo1 and rightThingVo1) and (leftThingVo2 or rightThingVo2))then
        return eliminate.DirType.Top
    end
    -- 朝下的T形
    if((belowThingVo1 and belowThingVo2 and leftThingVo1 and rightThingVo1) and (leftThingVo2 or rightThingVo2))then
        return eliminate.DirType.Bottom
    end
    -- 朝左的T形
    if((leftThingVo1 and leftThingVo2 and aboveThingVo1 and belowThingVo1) and (aboveThingVo2 or belowThingVo2))then
        return eliminate.DirType.Left
    end
    -- 朝右的T形
    if((rightThingVo1 and rightThingVo2 and aboveThingVo1 and belowThingVo1) and (aboveThingVo2 or belowThingVo2))then
        return eliminate.DirType.Right
    end
    return false
end

-- 检查是否小T形状
eliminate.GetIsShapeSmallT = function(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
    -- 朝上的T形
    if(aboveThingVo1 and aboveThingVo2 and leftThingVo1 and rightThingVo1)then
        return eliminate.DirType.Top
    end
    -- 朝下的T形
    if(belowThingVo1 and belowThingVo2 and leftThingVo1 and rightThingVo1)then
        return eliminate.DirType.Bottom
    end
    -- 朝左的T形
    if(leftThingVo1 and leftThingVo2 and aboveThingVo1 and belowThingVo1)then
        return eliminate.DirType.Left
    end
    -- 朝右的T形
    if(rightThingVo1 and rightThingVo2 and aboveThingVo1 and belowThingVo1)then
        return eliminate.DirType.Right
    end
    return false
end

-- 检查是否L形状
eliminate.GetIsShapeL = function(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
    -- 朝左上的L形
    if(leftThingVo1 and leftThingVo2 and aboveThingVo1 and aboveThingVo2)then
        return eliminate.DirType.LeftTop
    end
    -- 朝左下的L形
    if(leftThingVo1 and leftThingVo2 and belowThingVo1 and belowThingVo2)then
        return eliminate.DirType.LeftBotoom
    end
    -- 朝右上的L形
    if(rightThingVo1 and rightThingVo2 and aboveThingVo1 and aboveThingVo2)then
        return eliminate.DirType.RightTop
    end
    -- 朝右下的L形
    if(rightThingVo1 and rightThingVo2 and belowThingVo1 and belowThingVo2)then
        return eliminate.DirType.RightBotoom
    end
    return false
end

-- 检查是否直线5连形状
eliminate.GetIsShapeLine5 = function(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
    -- 竖直形
    if(aboveThingVo1 and aboveThingVo2 and belowThingVo1 and belowThingVo2)then
        return eliminate.DirType.Vertical
    end
    -- 横向形
    if(leftThingVo1 and leftThingVo2 and rightThingVo1 and rightThingVo2)then
        return eliminate.DirType.Horizontal
    end
    return false
end

-- 检查是否直线4连形状
eliminate.GetIsShapeLine4 = function(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
    -- 竖直形
    if((aboveThingVo1 and aboveThingVo2 and belowThingVo1) or (aboveThingVo1 and belowThingVo1 and belowThingVo2))then
        return eliminate.DirType.Vertical
    end
    -- 横向形
    if((leftThingVo1 and leftThingVo2 and rightThingVo1) or (leftThingVo1 and rightThingVo1 and rightThingVo2))then
        return eliminate.DirType.Horizontal
    end
    return false
end

-- 单个格子垂直移动所需时间
eliminate.GetVerticalOnceMoveTime = function()
    return 0.15
end

-- 单个格子倾斜移动所需时间
eliminate.GetInclineOnceMoveTime = function()
    return eliminate.GetVerticalOnceMoveTime() * 1.415
end