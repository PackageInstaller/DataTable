-- 获取静态层级的缩放大小
map.getStaticLayerScale = function(layoutType)
    if (layoutType == maze.LAYOUT_VERTICAL) then
        return 1
    elseif (layoutType == maze.LAYOUT_HORIZONTAL) then
        return 1
    end
end

-- 根据地图行列数获取地图宽高
maze.getMapSizeByRowCol = function(layoutType, rowNum, colNum, tileSideLen, tileHalfH)
    local mapH = 0
    local mapW = 0
    if (layoutType == maze.LAYOUT_VERTICAL) then
        mapH = tileSideLen / 2 + (tileSideLen + tileSideLen / 2) * rowNum
        mapW = 2 * tileHalfH * colNum
        mapW = rowNum > 1 and mapW + tileHalfH or mapW
    elseif (layoutType == maze.LAYOUT_HORIZONTAL) then
        mapW = tileSideLen / 2 + (tileSideLen + tileSideLen / 2) * colNum
        mapH = 2 * tileHalfH * rowNum
        mapH = colNum > 1 and mapH + tileHalfH or mapH
    end
    return mapW, mapH
end

-- 通过本地坐标获取对应格子的中心坐标
maze.getTilePosByLocalPos = function(tileRowCount, tileColCount, layoutType, localPosX, localPosY, tileSideLen, tileHalfH)
    localPosX = maze.getFormatNum(localPosX)
    localPosY = maze.getFormatNum(localPosY)
    tileSideLen = maze.getFormatNum(tileSideLen)
    tileHalfH = maze.getFormatNum(tileHalfH)
    local mapW, mapH = maze.getMapSizeByRowCol(layoutType, tileRowCount, tileColCount, tileSideLen, tileHalfH)
    -- 转化为以左下角为原点
    localPosX = localPosX + mapW / 2
    localPosY = localPosY + mapH / 2
    --位于矩形网格边线上的三个CELL中心点
    local center3Point = {}
    -- 网格对角线平方向上取整
    local mindist = 0
    if (layoutType == maze.LAYOUT_VERTICAL) then
        -- print(string.format("偏移后3个点的y坐标%s，%s，%s", center3Point[1].y, center3Point[2].y, center3Point[3].y))
        -- 左下角x偏移
        local offsetX = tileHalfH
        -- 左下角y偏移
        local offsetY = maze.getIsEvenNumOut(layoutType) and -tileSideLen / 2 or tileSideLen
        -- 网格宽、高
        local rectW = tileSideLen * 1.732 --sqrt(3) * tileSideLen
        local rectH = tileSideLen * 1.5 --tileSideLen * 3 / 2
        -- 网格对角线平方向上取整
        mindist = math.ceil(rectW * rectW + rectH * rectH)
        --计算出鼠标点目前位于哪一个矩形网格中
        local rectX = math.floor((localPosX - offsetX) / rectW)
        local rectY = math.floor((localPosY - offsetY) / rectH)
        -- print(string.format("鼠标点目前位于第x=%s，y=%s的矩形网格中", rectX, rectY))
        center3Point[1] = {}
        center3Point[2] = {}
        center3Point[3] = {}
        center3Point[1].x = maze.getFormatNum(rectW * rectX)
        center3Point[2].x = maze.getFormatNum(rectW * (rectX + 0.5))
        center3Point[3].x = maze.getFormatNum(rectW * (rectX + 1))
        -- print(string.format("3个点的x坐标%s，%s，%s", center3Point[1].x, center3Point[2].x, center3Point[3].x))
        center3Point[1].x = center3Point[1].x + offsetX
        center3Point[2].x = center3Point[2].x + offsetX
        center3Point[3].x = center3Point[3].x + offsetX
        -- print(string.format("偏移后3个点的x坐标%s，%s，%s", center3Point[1].x, center3Point[2].x, center3Point[3].x))
        --根据rectY % 2是否是偶数，决定三个点的纵坐标
        if (rectY % 2 == 0) then
            --偶数时，三个点组成正立正三角
            center3Point[1].y = maze.getFormatNum(rectH * rectY)
            center3Point[2].y = maze.getFormatNum(rectH * (rectY + 1))
            center3Point[3].y = center3Point[1].y
        else
            --奇数时，三个点组成倒立正三角
            center3Point[1].y = maze.getFormatNum(rectH * (rectY + 1))
            center3Point[2].y = maze.getFormatNum(rectH * rectY)
            center3Point[3].y = center3Point[1].y
        end
        -- print(string.format("当前%s行，为%s", rectY % 2 == 0 and "偶数" or "奇数", rectY % 2 == 0 and "正三角" or "倒三角"))
        -- print(string.format("3个点的y坐标%s，%s，%s", center3Point[1].y, center3Point[2].y, center3Point[3].y))
        center3Point[1].y = center3Point[1].y + offsetY
        center3Point[2].y = center3Point[2].y + offsetY
        center3Point[3].y = center3Point[3].y + offsetY
    else
        -- print(string.format("偏移后3个点的x坐标%s，%s，%s", center3Point[1].x, center3Point[2].x, center3Point[3].x))
        -- 左下角x偏移
        local offsetX = maze.getIsEvenNumOut(layoutType) and -tileSideLen / 2 or tileSideLen
        -- 左下角y偏移
        local offsetY = tileHalfH
        -- 网格宽、高
        local rectW = tileSideLen * 1.5 --tileSideLen * 3 / 2
        local rectH = tileSideLen * 1.732 --sqrt(3) * tileSideLen
        -- 网格对角线平方向上取整
        mindist = math.ceil(rectW * rectW + rectH * rectH)
        --计算出鼠标点目前位于哪一个矩形网格中
        local rectX = math.floor((localPosX - offsetX) / rectW)
        local rectY = math.floor((localPosY - offsetY) / rectH)
        -- print(string.format("鼠标点目前位于第x=%s，y=%s的矩形网格中", rectX, rectY))
        center3Point[1] = {}
        center3Point[2] = {}
        center3Point[3] = {}
        center3Point[1].y = maze.getFormatNum(rectH * rectY)
        center3Point[2].y = maze.getFormatNum(rectH * (rectY + 0.5))
        center3Point[3].y = maze.getFormatNum(rectH * (rectY + 1))
        -- print(string.format("3个点的y坐标%s，%s，%s", center3Point[1].y, center3Point[2].y, center3Point[3].y))
        center3Point[1].y = center3Point[1].y + offsetY
        center3Point[2].y = center3Point[2].y + offsetY
        center3Point[3].y = center3Point[3].y + offsetY
        -- print(string.format("偏移后3个点的y坐标%s，%s，%s", center3Point[1].y, center3Point[2].y, center3Point[3].y))
        --根据rectX % 2是否是偶数，决定三个点的横坐标
        if (rectX % 2 == 0) then
            --偶数时，三个点组成向右正三角
            center3Point[1].x = maze.getFormatNum(rectW * rectX)
            center3Point[2].x = maze.getFormatNum(rectW * (rectX + 1))
            center3Point[3].x = center3Point[1].x
        else
            --奇数时，三个点组成向左正三角
            center3Point[1].x = maze.getFormatNum(rectW * (rectX + 1))
            center3Point[2].x = maze.getFormatNum(rectW * rectX)
            center3Point[3].x = center3Point[1].x
        end
        -- print(string.format("当前%s行，为%s", rectX % 2 == 0 and "偶数" or "奇数", rectX % 2 == 0 and "向右正三角" or "向左正三角"))
        -- print(string.format("3个点的x坐标%s，%s，%s", center3Point[1].x, center3Point[2].x, center3Point[3].x))
        center3Point[1].x = center3Point[1].x + offsetX
        center3Point[2].x = center3Point[2].x + offsetX
        center3Point[3].x = center3Point[3].x + offsetX
    end

    -- 被捕获的索引
    local index = 1
    --当前距离
    local dist = 0
    -- 二分之根号3边长的平方，如果距离比它还小，就必然捕获
    local minDistance2 = tileHalfH * tileHalfH
    --现在找出鼠标距离哪一个点最近
    for i = 1, #center3Point do
        --求出距离的平方
        dist = maze.getDistance2(localPosX, localPosY, center3Point[i].x, center3Point[i].y)
        --如果已经肯定被捕获
        if (dist < minDistance2) then
            index = i
            break
        end
        --更新最小距离值和索引
        if (dist < mindist) then
            mindist = dist
            index = i
        end
    end
    --现在 index 就是被捕获的结果
    return center3Point[index].x, center3Point[index].y
end

-- 经过测试，小数点保留在3位比较安全，不会丢失精度（例：1-0.999=0.001，1-0.9999=丢失）
maze.getFormatNum = function(num, decimalCount)
    return maze.getPreciseDecimal(num, decimalCount or 3)
end

-- cusNum保留n位小数，不四舍五入
maze.getPreciseDecimal = function(cusNum, n)
    if type(cusNum) ~= "number" then
        return cusNum
    end
    n = n or 0
    n = math.floor(n)
    if n < 0 then
        n = 0
    end
    local nDecimal = 10 ^ n
    local nTemp = math.floor(cusNum * nDecimal)
    local nRet = nTemp / nDecimal
    return nRet
end

-- 通过格子的中心坐标获取对应所在的行和列
maze.getRowColByTilePos = function(tileRowCount, tileColCount, layoutType, posX, posY, tileSideLen, tileHalfH)
    local mapW, mapH = maze.getMapSizeByRowCol(layoutType, tileRowCount, tileColCount, tileSideLen, tileHalfH)
    local row = 0
    local col = 0
    if (layoutType == maze.LAYOUT_VERTICAL) then
        row = (posY - tileSideLen / 2 - tileSideLen / 2) / (tileSideLen * 1.5) + 1
        row = math.floor(row + 0.5)
        if (maze.getOddEvenOut(layoutType, row, nil)) then
            col = (posX - tileHalfH) / (2 * tileHalfH) + 1
            col = math.floor(col + 0.5)
        else
            col = posX / (2 * tileHalfH)
            col = math.floor(col + 0.5)
        end
    elseif (layoutType == maze.LAYOUT_HORIZONTAL) then
        col = (posX - tileSideLen / 2 - tileSideLen / 2) / (tileSideLen * 1.5) + 1
        col = math.floor(col + 0.5)
        if (maze.getOddEvenOut(layoutType, nil, col)) then
            row = (posY - tileHalfH) / (2 * tileHalfH) + 1
            row = math.floor(row + 0.5)
        else
            row = posY / (2 * tileHalfH)
            row = math.floor(row + 0.5)
        end
    end
    return row, col
end

-- 获取两点的平方距离
maze.getDistance2 = function(x1, y1, x2, y2)
    return ((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
end

-- 通过行和列获取指定格子的坐标
maze.getTilePosByRowCol = function(mapW, mapH, layoutType, row, col, tileSideLen, tileHalfH)
    local posX = 0
    local posY = 0
    if (layoutType == maze.LAYOUT_VERTICAL) then
        if (maze.getOddEvenOut(layoutType, row, col)) then
            posX = tileHalfH + (col - 1) * 2 * tileHalfH
        else
            posX = col * 2 * tileHalfH
        end
        posY = tileSideLen / 2 + (row - 1) * (tileSideLen * 1.5) + tileSideLen / 2
    elseif (layoutType == maze.LAYOUT_HORIZONTAL) then
        if (maze.getOddEvenOut(layoutType, row, col)) then
            posY = tileHalfH + (row - 1) * 2 * tileHalfH
        else
            posY = row * 2 * tileHalfH
        end
        posX = tileSideLen / 2 + (col - 1) * (tileSideLen * 1.5) + tileSideLen / 2
    end
    -- 转化为以左下角为原点
    posX = posX - mapW / 2
    posY = posY - mapH / 2
    return posX, posY
end

-- 获取是否指定奇数行/偶数行/奇数列/偶数列突出
maze.getOddEvenOut = function(layoutType, row, col)
    -- 是否突出
    local isOut = false
    -- 是否偶数突出
    local isEvenOut = maze.getIsEvenNumOut(layoutType)
    if (layoutType == maze.LAYOUT_VERTICAL) then
        if (row % 2 == 0) then
            isOut = isEvenOut
        else
            isOut = not isEvenOut
        end
    elseif (layoutType == maze.LAYOUT_HORIZONTAL) then
        if (col % 2 == 0) then
            isOut = isEvenOut
        else
            isOut = not isEvenOut
        end
    end
    return isOut
end

-- 配置设置是否偶数突出
maze.setIsEvenNumOut = function(isEvenNumOut)
    maze.MAP_IS_EVEN_NUM_OUT = isEvenNumOut
end

-- 是否偶数突出
maze.getIsEvenNumOut = function(layoutType)
    if(maze.MAP_IS_EVEN_NUM_OUT ~= nil)then
        return maze.MAP_IS_EVEN_NUM_OUT
    end
    return false
end

-- 获取目标点N圈范围内的所有点，不包含目标点
maze.getNearRangeList = function(layoutType, rowNum, colNum, row, col, range)
    local searchTempRow = nil
    local searchTempCol = nil
    local searchDic = {}
    local targetList = {}
    if (layoutType == maze.LAYOUT_VERTICAL) then
        for x = 1, range do
            table.insert(targetList, {row = row, col = col + x})
            table.insert(targetList, {row = row, col = col - x})
        end
        if (maze.getOddEvenOut(layoutType, row, col)) then
            for index = 1, #targetList do
                local deltaLeftX = 0
                local deltaRightX = 0
                for y = 1, range do
                    if(y % 2 == 0)then
                        deltaLeftX = deltaLeftX + 1
                    end
                    if(y % 2 ~= 0)then
                        deltaRightX = deltaRightX + 1
                    end
                    if(targetList[index].col < col)then   -- 左侧
                        -- 上侧
                        searchTempRow = targetList[index].row + y
                        searchTempCol = targetList[index].col + deltaLeftX
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                        -- 下侧
                        searchTempRow = targetList[index].row - y
                        searchTempCol = targetList[index].col + deltaLeftX
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                    elseif(targetList[index].col > col)then   -- 右侧
                        -- 上侧
                        searchTempRow = targetList[index].row + y
                        searchTempCol = targetList[index].col - deltaRightX
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                        -- 下侧
                        searchTempRow = targetList[index].row - y
                        searchTempCol = targetList[index].col - deltaRightX
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                    end
                end
            end
        else
            for index = 1, #targetList do
                local deltaLeftX = 0
                local deltaRightX = 0
                for y = 1, range do
                    if(y % 2 ~= 0)then
                        deltaLeftX = deltaLeftX + 1
                    end
                    if(y % 2 == 0)then
                        deltaRightX = deltaRightX + 1
                    end
                    if(targetList[index].col < col)then   -- 左侧
                        -- 上侧
                        searchTempRow = targetList[index].row + y
                        searchTempCol = targetList[index].col + deltaLeftX
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                        -- 下侧
                        searchTempRow = targetList[index].row - y
                        searchTempCol = targetList[index].col + deltaLeftX
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                    elseif(targetList[index].col > col)then   -- 右侧
                        -- 上侧
                        searchTempRow = targetList[index].row + y
                        searchTempCol = targetList[index].col - deltaRightX
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                        -- 下侧
                        searchTempRow = targetList[index].row - y
                        searchTempCol = targetList[index].col - deltaRightX
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                    end
                end
            end
        end
    elseif (layoutType == maze.LAYOUT_HORIZONTAL) then
        for y = 1, range do
            table.insert(targetList, {row = row + y, col = col})
            table.insert(targetList, {row = row - y, col = col})
        end
        if (maze.getOddEvenOut(layoutType, row, col)) then
            for i = 1, #targetList do
                local deltaTopY = 0
                local deltaBottomY = 0
                for x = 1, range do
                    if(x % 2 == 0)then
                        deltaTopY = deltaTopY + 1
                    end
                    if(x % 2 ~= 0)then
                        deltaBottomY = deltaBottomY + 1
                    end
                    if(targetList[i].row < row)then   -- 下侧
                        -- 右侧
                        searchTempCol = targetList[i].col + x
                        searchTempRow = targetList[i].row + deltaTopY
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                        -- 左侧
                        searchTempCol= targetList[i].col - x
                        searchTempRow = targetList[i].row + deltaTopY
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                    elseif(targetList[i].row > row)then   -- 上侧
                        -- 右侧
                        searchTempCol = targetList[i].col + x
                        searchTempRow = targetList[i].row - deltaBottomY
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                        -- 左侧
                        searchTempCol = targetList[i].col - x
                        searchTempRow = targetList[i].row - deltaBottomY
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                    end
                end
            end
        else
            for i = 1, #targetList do
                local deltaTopY = 0
                local deltaBottomY = 0
                for x = 1, range do
                    if(x % 2 ~= 0)then
                        deltaTopY = deltaTopY + 1
                    end
                    if(x % 2 == 0)then
                        deltaBottomY = deltaBottomY + 1
                    end
                    if(targetList[i].row < row)then   -- 下侧
                        -- 右侧
                        searchTempCol = targetList[i].col + x
                        searchTempRow = targetList[i].row + deltaTopY
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                        -- 左侧
                        searchTempCol= targetList[i].col - x
                        searchTempRow = targetList[i].row + deltaTopY
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                    elseif(targetList[i].row > row)then   -- 上侧
                        -- 右侧
                        searchTempCol = targetList[i].col + x
                        searchTempRow = targetList[i].row - deltaBottomY
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                        -- 左侧
                        searchTempCol = targetList[i].col - x
                        searchTempRow = targetList[i].row - deltaBottomY
                        if(searchTempRow >= 1 and searchTempRow <= rowNum and searchTempCol >= 1 and searchTempCol <= colNum)then
                            searchDic[maze.getRowColKey(searchTempRow, searchTempCol)] = {row = searchTempRow, col = searchTempCol}
                        end
                    end
                end
            end
        end
    end

    local searchList = {}
    for i = 1, #targetList do
        if(targetList[i].row >= 1 and targetList[i].row <= rowNum and targetList[i].col >= 1 and targetList[i].col <= colNum)then
            table.insert(searchList, targetList[i])
        end
    end
    for key, vo in pairs(searchDic) do
        table.insert(searchList, vo)
    end
    return searchList
end
--根据角度获取朝向类型
maze.getDirTypeByAng = function (layoutType,angle)
    if layoutType == maze.LAYOUT_VERTICAL then 
        local _angle = 0
        for i=1,6 do
            _angle = 30 + ((i-1) * 60)
            if angle <= _angle + 10 and angle>= _angle - 10 then 
                return i
            end
        end
    elseif layoutType == maze.LAYOUT_HORIZONTAL then
        local _angle = 0
        for i=1,6 do
            _angle = (i-1) * 60
            if angle <= _angle + 10 and angle>= _angle - 10 then 
                return i
            end
        end
    end

    return 0
end

--  61   -- 123
-- 5⬡2  --  ⎔
--  43   -- 654
-- 获取目标点指定方向指定距离上所有点，不包含目标点
maze.getDirDisList = function(layoutType, rowNum, colNum, row, col, direction, distance, isLimitRange)
    local function _isInRange(_row, _col)
        if(isLimitRange)then
            if(_row >= 1 and _row <= rowNum and _col >= 1 and _col <= colNum)then
                return true
            else
                return false
            end
        else
            return true
        end
    end
    local targetList = {}
    if (layoutType == maze.LAYOUT_VERTICAL) then
        if (maze.getOddEvenOut(layoutType, row, col)) then
            if(direction == 1)then
                local topRight = col
                for i = 1, distance do
                    if(i % 2 == 0)then
                        topRight = topRight + 1
                    end
                    if(_isInRange(row + i, topRight))then
                        table.insert(targetList, {row = row + i, col = topRight})
                    end
                end
            elseif(direction == 2)then
                for i = 1, distance do
                    if(_isInRange(row, col + i))then
                        table.insert(targetList, {row = row, col = col + i})
                    end
                end
            elseif(direction == 3)then
                local bottomRight = col
                for i = 1, distance do
                    if(i % 2 == 0)then
                        bottomRight = bottomRight + 1
                    end
                    if(_isInRange(row - i, bottomRight))then
                        table.insert(targetList, {row = row - i, col = bottomRight})
                    end
                end
            elseif(direction == 4)then
                local bottomLeft = col
                for i = 1, distance do
                    if(i % 2 ~= 0)then
                        bottomLeft = bottomLeft - 1
                    end
                    if(_isInRange(row - i, bottomLeft))then
                        table.insert(targetList, {row = row - i, col = bottomLeft})
                    end
                end
            elseif(direction == 5)then
                for i = 1, distance do
                    if(_isInRange(row, col - i))then
                        table.insert(targetList, {row = row, col = col - i})
                    end
                end
            elseif(direction == 6)then
                local topLeft = col
                for i = 1, distance do
                    if(i % 2 ~= 0)then
                        topLeft = topLeft - 1
                    end
                    if(_isInRange(row + i, topLeft))then
                        table.insert(targetList, {row = row + i, col = topLeft})
                    end
                end
            end
        else
            if(direction == 1)then
                local topRight = col
                for i = 1, distance do
                    if(i % 2 ~= 0)then
                        topRight = topRight + 1
                    end
                    if(_isInRange(row + i, topRight))then
                        table.insert(targetList, {row = row + i, col = topRight})
                    end
                end
            elseif(direction == 2)then
                for i = 1, distance do
                    if(_isInRange(row, col + i))then
                        table.insert(targetList, {row = row, col = col + i})
                    end
                end
            elseif(direction == 3)then
                local bottomRight = col
                for i = 1, distance do
                    if(i % 2 ~= 0)then
                        bottomRight = bottomRight + 1
                    end
                    if(_isInRange(row - i, bottomRight))then
                        table.insert(targetList, {row = row - i, col = bottomRight})
                    end
                end
            elseif(direction == 4)then
                local bottomLeft = col
                for i = 1, distance do
                    if(i % 2 == 0)then
                        bottomLeft = bottomLeft - 1
                    end
                    if(_isInRange(row - i, bottomLeft))then
                        table.insert(targetList, {row = row - i, col = bottomLeft})
                    end
                end
            elseif(direction == 5)then
                for i = 1, distance do
                    if(_isInRange(row, col - i))then
                        table.insert(targetList, {row = row, col = col - i})
                    end
                end
            elseif(direction == 6)then
                local topLeft = col
                for i = 1, distance do
                    if(i % 2 == 0)then
                        topLeft = topLeft - 1
                    end
                    if(_isInRange(row + i, topLeft))then
                        table.insert(targetList, {row = row + i, col = topLeft})
                    end
                end
            end
        end
    elseif(layoutType == maze.LAYOUT_HORIZONTAL)then
        if (maze.getOddEvenOut(layoutType, row, col)) then
            if(direction == 1)then
                local topLeft = row
                for i = 1, distance do
                    if(i % 2 == 0)then
                        topLeft = topLeft + 1
                    end
                    if(_isInRange(topLeft, col - i))then
                        table.insert(targetList, {row = topLeft, col = col - i})
                    end
                end
            elseif(direction == 2)then
                for i = 1, distance do
                    if(_isInRange(row + i, col))then
                        table.insert(targetList, {row = row + i, col = col})
                    end
                end
            elseif(direction == 3)then
                local topRight = row
                for i = 1, distance do
                    if(i % 2 == 0)then
                        topRight = topRight + 1
                    end
                    if(_isInRange(topRight, col + i))then
                        table.insert(targetList, {row = topRight, col = col + i})
                    end
                end
            elseif(direction == 4)then
                local bottomRight = row
                for i = 1, distance do
                    if(i % 2 ~= 0)then
                        bottomRight = bottomRight - 1
                    end
                    if(_isInRange(bottomRight, col + i))then
                        table.insert(targetList, {row = bottomRight, col = col + i})
                    end
                end
            elseif(direction == 5)then
                for i = 1, distance do
                    if(_isInRange(row - i, col))then
                        table.insert(targetList, {row = row - i, col = col})
                    end
                end
            elseif(direction == 6)then
                local bottomLeft = row
                for i = 1, distance do
                    if(i % 2 ~= 0)then
                        bottomLeft = bottomLeft - 1
                    end
                    if(_isInRange(bottomLeft, col - i))then
                        table.insert(targetList, {row = bottomLeft, col = col - i})
                    end
                end
            end
        else
            if(direction == 1)then
                local topLeft = row
                for i = 1, distance do
                    if(i % 2 ~= 0)then
                        topLeft = topLeft + 1
                    end
                    if(_isInRange(topLeft, col - i))then
                        table.insert(targetList, {row = topLeft, col = col - i})
                    end
                end
            elseif(direction == 2)then
                for i = 1, distance do
                    if(_isInRange(row + i, col))then
                        table.insert(targetList, {row = row + i, col = col})
                    end
                end
            elseif(direction == 3)then
                local topRight = row
                for i = 1, distance do
                    if(i % 2 ~= 0)then
                        topRight = topRight + 1
                    end
                    if(_isInRange(topRight, col + i))then
                        table.insert(targetList, {row = topRight, col = col + i})
                    end
                end
            elseif(direction == 4)then
                local bottomRight = row
                for i = 1, distance do
                    if(i % 2 == 0)then
                        bottomRight = bottomRight - 1
                    end
                    if(_isInRange(bottomRight, col + i))then
                        table.insert(targetList, {row = bottomRight, col = col + i})
                    end
                end
            elseif(direction == 5)then
                for i = 1, distance do
                    if(_isInRange(row - i, col))then
                        table.insert(targetList, {row = row - i, col = col})
                    end
                end
            elseif(direction == 6)then
                local bottomLeft = row
                for i = 1, distance do
                    if(i % 2 == 0)then
                        bottomLeft = bottomLeft - 1
                    end
                    if(_isInRange(bottomLeft, col - i))then
                        table.insert(targetList, {row = bottomLeft, col = col - i})
                    end
                end
            end
        end
    end
    return targetList
end

maze.getRowColKey = function(cusRow, cusCol)
    return cusRow * 100000 + cusCol
end
 
--[[ 替换语言包自动生成，请勿修改！
]]
