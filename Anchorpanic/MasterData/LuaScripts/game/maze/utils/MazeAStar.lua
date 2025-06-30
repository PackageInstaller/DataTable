module("maze.MazeAStar", Class.impl())

function ctor(self)
    self.mIsLog = false
end

function __print(self, str)
	if(self.mIsLog)then 
		print(str) 
	end
end

-- 只在每个迷宫地图初始reset一次，关闭时reset一次
function reset(self)
    if(self.mMapDic)then
        for key, grid in pairs(self.mMapDic) do
            LuaPoolMgr:poolRecover(grid)
        end
    end
    self.mMapDic = nil
end

function setData(self, layoutType, mapSizeW, mapSizeH, mapRowNum, mapColNum, tileSideLen, tileHalfH, checkMoveFun, checkCostFun)
    self.mLayoutType = layoutType
    self.mMapSizeW = mapSizeW
    self.mMapSizeH = mapSizeH
    self.mMapRowNum = mapRowNum
    self.mMapColNum = mapColNum
    self.mTileSideLen = tileSideLen
    self.mTileHalfH = tileHalfH
    self.mCheckMoveFun = checkMoveFun
    self.mCheckCostFun = checkCostFun
end

function __initMap(self)
    if(not self.mMapDic)then
        self:reset()
        self.mMapDic = {}
        for row = 1, self.mMapRowNum do
            for col = 1, self.mMapColNum do
                local vo = LuaPoolMgr:poolGet(maze.MazeAstarGrid)
                vo.canWalk = self.mCheckMoveFun(row, col)
                vo:setCostMultiplier(self.mCheckCostFun(row, col))
                vo.row = row
                vo.col = col
                vo.x, vo.y = maze.getTilePosByRowCol(self.mMapSizeW, self.mMapSizeH, self.mLayoutType, row, col, self.mTileSideLen, self.mTileHalfH)
                self.mMapDic[self:__getMapKey(row, col)] = vo
            end
        end
    else
        for row = 1, self.mMapRowNum do
            for col = 1, self.mMapColNum do
                local vo = self.mMapDic[self:__getMapKey(row, col)]
                vo:setNearGridList(nil)
                vo.canWalk = self.mCheckMoveFun(row, col)
                vo:setCostMultiplier(self.mCheckCostFun(row, col))
            end
        end
    end
end

function findPath(self, startRow, startCol, endRow, endCol)
    if (not (startRow >= 1 and startRow <= self.mMapRowNum and startCol >= 1 and startCol <= self.mMapColNum)) then
        return false, nil
    end
    if (not (endRow >= 1 and endRow <= self.mMapRowNum and endCol >= 1 and endCol <= self.mMapColNum)) then
        return false, nil
    end
    -- 初始化地图格子
    self:__initMap(self.mMapRowNum, self.mMapColNum)
    -- 开放列表数组
    self.mOpenList = {}
    -- 封闭列表数组
    self.mCloseList = {}
    -- 找到的路径节点数组
    self.mFindPathList = nil
    -- 弗洛伊德路径平滑处理节点数组
    self.mFloydPathList = {}
    -- 是否结束寻路
    self.mIsEnd = false

    -- 启发函数方法
    -- self.mHeuristic = self.__manhattan
    self.mHeuristic = self.__euclidian
    -- self.mHeuristic = self.__diagonal

    -- 方向运动代价权值（横竖为1 斜方向为 Math.SQRT2 = 1.4）
    self.mStraightCost = 1  -- 直线代价权值
    self.mDiagCost = 1.4    -- 对角线代价权值SQRT2

    -- 结束节点
    self.mEndGrid = self:getMapGrid(endRow, endCol)
    -- 开始节点
    self.mStartGrid = self:getMapGrid(startRow, startCol)
    self.mStartGrid.g = 0
    self.mStartGrid.h = self.mHeuristic(self.mStartGrid, self.mEndGrid, self.mStraightCost, self.mStraightCost)
    self.mStartGrid.f = self.mStartGrid.g + self.mStartGrid.h
    -- 将开始节点加入开放列表
    table.insert(self.mOpenList, self.mStartGrid)

    return self:search(self.mLayoutType, self.mMapRowNum, self.mMapColNum)
end

function search(self, layoutType, rowNum, colNum)
    local checkNode = nil
    while(not self.mIsEnd)do
        self:__print("\n")
        -- 当前节点在开放列表中的索引位置
        local currentNum
        -- 在开放列表中查找具有最小 F 值的节点，并把查找到的节点作为下一个要九宫格中心节点
        local openLen = #self.mOpenList

        checkNode = self.mOpenList[1]
        currentNum = 1
        for i = 1, openLen do
            if (self.mOpenList[i].f < checkNode.f) then
                checkNode = self.mOpenList[i]
                currentNum = i
            end
        end
        -- 如果开放列表中最后一个节点是最小 F 节点 相当于直接openList.pop()  否则相当于交换位置来保存未比较的节点
        self.mOpenList[currentNum] = self.mOpenList[openLen]
        table.remove(self.mOpenList, openLen)
        table.insert(self.mCloseList, checkNode)

        self:__print(string.format("开始目标点位于close列表的第%s行%s列", checkNode.row, checkNode.col))
        local nearGridList = checkNode:getNearGridList()
        if(nearGridList == nil)then
            nearGridList = {}
            local nearList = maze.getNearRangeList(layoutType, rowNum, colNum, checkNode.row, checkNode.col, 1)
            for i = 1, #nearList do
                local data = nearList[i]
                if(self:getMapGrid(data.row, data.col).canWalk)then
                    table.insert(nearGridList, self:getMapGrid(data.row, data.col))
                end
            end
            checkNode:setNearGridList(nearGridList)
        end
        for i = 1, #nearGridList do
            -- 当前要被探查的节点
            local nearGrid = nearGridList[i]
            self:__print(string.format("目标点第%s行%s列的邻近点共有%s个，开始检查第%s行%s列", checkNode.row, checkNode.col, #nearGridList, nearGrid.row, nearGrid.col))
            if (self:__isInclude(self.mCloseList, nearGrid) == false) then
                -- 代价计算 横竖为1 斜方向为 Math.SQRT2 = 1.4
                local cost = self.mStraightCost
                -- 这里看情况有需要跳跃啥的设置对应的代价计算
                -- if (not (node.x == test.x) or not (node.y == test.y)) then
                --     cost = self.mDiagCost
                -- end
                local g = checkNode.g + cost * nearGrid:getCostMultiplier()
                local h = self.mHeuristic(nearGrid, self.mEndGrid, self.mStraightCost, self.mStraightCost)
                local f = g + h
                -- 如果该周围节点在开启找到（表示已经被探测过的）
                if (self:__isInclude(self.mOpenList, nearGrid)) then
                    self:__print(string.format("找到邻近点第%s行%s列在open列表中", nearGrid.row, nearGrid.col))
                    -- 如果该相邻节点在开放列表中，则判断若经由当前节点到达该相邻节点的G值是否小于原来保存的G值,若小于,则将该相邻节点的父节点设为当前节点，并重新设置该相邻节点的G和F值
                    if (g < nearGrid.g) then
                        nearGrid.f = f
                        nearGrid.g = g
                        nearGrid.h = h
                        nearGrid.parent = checkNode
                        self:__print(string.format("更换邻近点父母，第%s行%s列的临近点的旧父母为第%s行%s列，新父母为第%s行%s列", nearGrid.row, nearGrid.col, nearGrid.parent.row, nearGrid.parent.col, checkNode.row, checkNode.col))
                    end
                else
                    -- 未被探测的节点
                    nearGrid.f = f
                    nearGrid.g = g
                    nearGrid.h = h
                    nearGrid.parent = checkNode
                    table.insert(self.mOpenList, nearGrid)
                    self:__print(string.format("添加邻近点第%s行%s列到open列表", nearGrid.row, nearGrid.col))
                end
                -- 循环结束条件：当结束节点被加入到开放列表作为待检验节点时，表示路径被找到，此时应终止循环
                if (self:equals(nearGrid, self.mEndGrid)) then
                    self:__print(string.format("找到终结点第%s行%s列", nearGrid.row, nearGrid.col))
                    self.mIsEnd = true
                    break
                end
            end
        end
        -- 未找到路径
        if (#self.mOpenList == 0) then
            self:__print("找不到路径")
            self.mIsEnd = true
            return false, nil
        end
    end
    return true, self:__getBuildPath()
end

function __getBuildPath(self)
    self.mFindPathList = {}
    local grid = self.mEndGrid
    table.insert(self.mFindPathList, grid)
    while (self:equals(grid, self.mStartGrid) == false) do
        grid = grid.parent
        table.insert(self.mFindPathList, 1, grid)
    end
    return self.mFindPathList
end

function getMapGrid(self, row, col)
    if(not self.mMapDic)then
        self:__initMap()
    end
    return self.mMapDic[self:__getMapKey(row, col)]
end

function __getMapKey(self, row, col)
    return row * 100000 + col
end

function equals(self, grid1, grid2)
    return grid1.row == grid2.row and grid1.col == grid2.col
end

function __isInclude(self, gridList, searchgrid)
    for i = 1, #gridList do
        local grid = gridList[i]
        if(self:equals(grid, searchgrid))then
            return true
        end        
    end
    return false
end

function optimizePathList(self, rowColList, targetRow, targetCol)
    local function __sortRowColList(rwColVo_1, rwColVo_2)
        if (rwColVo_1 and rwColVo_2) then
            local h1 = self.__euclidian(self:getMapGrid(rwColVo_1.row, rwColVo_1.col), self:getMapGrid(targetRow, targetCol), 1, 1)
            local h2 = self.__euclidian(self:getMapGrid(rwColVo_2.row, rwColVo_2.col), self:getMapGrid(targetRow, targetCol), 1, 1)
            -- 估价距离从小到大
            if (h1 > h2) then
                return false
            end
            if (h1 < h2) then
                return true
            end
        end
        return false
    end
    table.sort(rowColList, __sortRowColList)
    return rowColList
end

-------------------------------------------------------------------- 启发函数 --------------------------------------------------------------------
-- 曼哈顿
function __manhattan(startNode, endNode, straightCost, diagCost)
    return (math.abs(startNode.x - endNode.x) + math.abs(startNode.y - endNode.y)) * straightCost
end

-- 欧几里得
function __euclidian(startNode, endNode, straightCost, diagCost)
    local dx = startNode.x - endNode.x
    local dy = startNode.y - endNode.y
    return math.sqrt(dx * dx + dy * dy) * straightCost
end

-- 对角线
function __diagonal(startNode, endNode, straightCost, diagCost)
    local dx = math.abs(startNode.x - endNode.x)
    local dy = math.abs(startNode.y - endNode.y)
    if(straightCost == diagCost)then
        -- 斜向代价 = 直线代价
        return straightCost * math.sqrt(dx * dx + dy * dy)
    else
        -- 斜向代价 = SQRT2*直线代价
        return straightCost * (dx + dy) + (self.mDiagCost * straightCost - 2 * straightCost) * math.min(dx, dy)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
