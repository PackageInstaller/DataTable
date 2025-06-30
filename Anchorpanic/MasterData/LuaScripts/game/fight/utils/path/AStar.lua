module("AStar", Class.impl())

function ctor(self)
    self:_initMap()
end

function _initMap( self )
    self.m_map = {}
    for col=0,fight.SceneUtil.COL_COUNT-1 do
        for row=0,fight.SceneUtil.ROW_COUNT-1 do
            self.m_map[self:_getMapKey(col,row)] = {col = col,row = row}
        end
    end
end

function _resetMap(self)
    for col=0,fight.SceneUtil.COL_COUNT-1 do
        for row=0,fight.SceneUtil.ROW_COUNT-1 do
            local node = self:_getMapNode(col,row)
            node.block = false
            node.open = false
            node.isMask = false
            node.g = 0
            node.h = 0
            node.f = 0
            node.parent = nil
        end
    end
end

function _getMapNode(self,col,row)
    return self.m_map[self:_getMapKey(col,row)]
end

function _getMapKey( self,col,row )
    return col *10000 + row
end


function find( self,cusStartTile,cusEndTile,cusFinderId)
    if cusStartTile == cusEndTile then
        print(0000000000000)
        return nil 
    end

    self.m_open = {}
    self.m_s_t = cusStartTile
    self.m_e_t = cusEndTile
    self.m_finder_id = cusFinderId

    self:_initMask()

    local path = self:__findPath()
    return path
end

function _initMask(self)
    self:_resetMap()
    local thingDic = fight.SceneManager:getAllThing()
    local myV = fight.SceneManager:getThing(self.m_finder_id):volume()
    for id,vo in pairs(thingDic) do
        if id ~= self.m_finder_id then
            if vo:isMoving() == false then
                local v = vo:volume() + myV
                local t = vo:tile()
                for col=t.col-v,t.col+v do
                    for row=t.row-v,t.row+v do
                        self:_getMapNode(col,row).isMask = true
                    end
                end
            end
        end
    end
end

function _isWalkNode(self,col,row)
    if col < 0 or col >= fight.SceneUtil.COL_COUNT or row < 0 or row >= fight.SceneUtil.ROW_COUNT then
        return false
    end
    return self:_getMapNode(col,row).isMask == false
end

function __findPath(self)

    if 
        self.m_s_t.col < 0 or self.m_s_t.col >= fight.SceneUtil.COL_COUNT or self.m_s_t.row < 0 or self.m_s_t.row >= fight.SceneUtil.ROW_COUNT or
        self.m_e_t.col < 0 or self.m_e_t.col >= fight.SceneUtil.COL_COUNT or self.m_e_t.row < 0 or self.m_e_t.row >= fight.SceneUtil.ROW_COUNT 
    then
        print(1111111111111111)
        return nil
    end

    if self:__isMask(self.m_e_t) then
        print(222222222222)
        return nil
    end

    local path = {}

    local getEnd = false

    self.m_s_node = self:_getMapNode(self.m_s_t.col,self.m_s_t.row)
    self.m_e_node = self:_getMapNode(self.m_e_t.col,self.m_e_t.row)
    local curr = self.m_s_node
    

    local step = 0

    while getEnd == false do
        step = step + 1
        curr.block = true
        local checkList = {}
        local cols = fight.SceneUtil.COL_COUNT
        local rows = fight.SceneUtil.ROW_COUNT

        --上下左右
        if curr.row > 0 then
            table.insert( checkList,self:_getMapNode(curr.col,curr.row - 1))
        end
        if curr.col > 0 then
            table.insert( checkList,self:_getMapNode(curr.col - 1,curr.row))
        end
        if curr.col < (cols - 1) then
            table.insert( checkList,self:_getMapNode(curr.col + 1,curr.row))
        end
        if curr.row < (rows - 1) then
            table.insert( checkList,self:_getMapNode(curr.col,curr.row + 1))
        end

        --四个对角
        if curr.row > 0 and curr.col > 0 and not(self:_isWalkNode(curr.col - 1, curr.row) == false and self:_isWalkNode(curr.col, curr.row - 1) == false) then
            table.insert( checkList,self:_getMapNode((curr.col - 1),(curr.row - 1)))
        end
        if curr.row < rows - 1 and curr.col > 0 and not(self:_isWalkNode(curr.col - 1, curr.row) == false and self:_isWalkNode(curr.col, curr.row + 1) == false) then
            table.insert( checkList,self:_getMapNode((curr.col - 1),(curr.row + 1)))
        end
        if curr.row > 0 and curr.col < cols - 1 and not(self:_isWalkNode(curr.col, curr.row - 1) == false and self:_isWalkNode(curr.col + 1, curr.row) == false) then
            table.insert( checkList,self:_getMapNode((curr.col + 1),(curr.row - 1)))
        end
        if curr.row < rows - 1 and curr.col < cols - 1 and not(self:_isWalkNode(curr.col, curr.row + 1) == false and self:_isWalkNode(curr.col + 1, curr.row) == false) then
            table.insert( checkList,self:_getMapNode((curr.col + 1),(curr.row + 1)))
        end

        local checkLen = #checkList
        local checkIndex = 1
        local checkNode
        while checkIndex <= checkLen do
            checkNode = checkList[checkIndex]
            if checkNode == self.m_e_node then
                checkNode.nodeparent = curr
                getEnd = true
                break
            end
            if checkNode.isMask == false then
                self:_count(checkNode, curr)
            end
            checkIndex = checkIndex + 1
        end
        if  getEnd == false then
            if #self.m_open > 0 then
                local min = self:_getMin()
                curr = self.m_open[min]
                table.remove(self.m_open,min)
            else
                print(33333333333)
                return nil
            end
        end
    end

    

    local itemNode = self.m_e_node
    while (itemNode ~= self.m_s_node) do
        table.insert(path,1,itemNode)
        itemNode = itemNode.nodeparent
    end

    return path
end

function _count(self,neighboringNode,centerNode) 
    if neighboringNode.block == false then
        local g = centerNode.g + 10
        if ((math.abs(neighboringNode.col - centerNode.col) == 1) and (math.abs(neighboringNode.row - centerNode.row) == 1)) then
            g = centerNode.g + 14
        else
            g = centerNode.g + 10
        end
        if (neighboringNode.open) then
            if (neighboringNode.g >= g) then
                neighboringNode.g = g
                self:_ghf(neighboringNode)
                neighboringNode.nodeparent = centerNode
            end
        else
            self:_addToOpen(neighboringNode)
            neighboringNode.g = g
            self:_ghf(neighboringNode)
            neighboringNode.nodeparent = centerNode
        end
    end
end

function _ghf(self,nodeItem)
    local disX = math.abs(nodeItem.col - self.m_e_node.col)
    local disY = math.abs(nodeItem.row - self.m_e_node.row)
    nodeItem.h = 10 * (disX + disY)
    nodeItem.f = nodeItem.g + nodeItem.h
end

function _addToOpen(self,nodeItem) 
    table.insert(self.m_open,nodeItem)
    nodeItem.open = true
end

function _getMin(self) 
    local openLen = #self.m_open
    local firstF = 100000
    local minIndex = 1
    local index = 1
    while index <= openLen do
        if (firstF > self.m_open[index].f) then
            firstF = self.m_open[index].f
            minIndex = index
        end
        index = index + 1
    end
    return minIndex
end

function __isMask( self,cusTile )
    local tile = self:_getMapNode(cusTile.col,cusTile.row)
    return tile and tile.isMask
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
