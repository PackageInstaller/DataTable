module("BStar", Class.impl())
DIR = {
    LEFT = 0,
    UP = 1,
    RIGHT = 2,
    DOWN =3,
    NONE = 4
}

DIR_NODE = {
    {-1,0},
    {0,-1},
    {1,0},
    {0,1},
    {0,0}
}
STEP_LIMIT = 300
node = {
    __call = function(_, col, row,step)
        return setmetatable({ col = col or 0, row = row or 0, wall = DIR.NONE,dir = DIR.NONE,step = step or 1}, node)
    end,
    __tostring = function(v)
        return string.format("(col = %f,row = %f) step = %f",v.col,v.row,v.step)
    end,

    __eq = function(v,u)
        return v:equals(u)
    end,

    __index = {
        next = function (self,dir)
            local dn = DIR_NODE[dir+1]
            local nextNode = node(self.col + dn[1],self.row + dn[2],self.step+1)
            if self.parents then
                local tempP = {}
                for i,v in ipairs(self.parents) do
                    table.insert(tempP, v)
                end
                table.insert(tempP,self)
                nextNode.parents = tempP
            else
                nextNode.parents = {self}
            end
            return nextNode
        end,

        setWD = function ( self,wall,dir )
            self.wall = wall
            self.dir = dir
        end,

        equals = function(self,v)
            return self.col == v.col and self.row == v.row
        end
    }
}
setmetatable(node,node)

function find( self,cusStartTile,cusEndTile,cusFinderId)
    self.m_s_t = node(cusStartTile.col,cusStartTile.row)
    self.m_e_t = node(cusEndTile.col,cusEndTile.row)

    self.m_f_id = cusFinderId;
    
    self.m_visited = {}
    self.m_checkList = {self.m_s_t}
    local limit = STEP_LIMIT;
    local finTile
    while #self.m_checkList > 0 and limit >= 0 do
        limit = limit - 1
        local curr = table.remove(self.m_checkList)
        if curr == self.m_e_t then
            finTile = curr
            --到终点
            break
        end
        if self:__allowed(curr) then
            if self.m_visited[curr.col] == nil then
                self.m_visited[curr.col] = {}
            end
            self.m_visited[curr.col][curr.row] = true
    
            if self:__walkSd(curr) == false then
                self:__walkBranch(curr)
            end
        end
    end
    if finTile then
        local path = {}
        if finTile.parents then
            local len = #finTile.parents
            for i=2,len do
                local t = finTile.parents[i]
                table.insert( path,fight.Tile(t.col,t.row))
            end
        end
        table.insert( path,fight.Tile(finTile.col,finTile.row))
        self:__optimizePath(path)
        return path
    end
    return nil
end


function __optimizePath(self,cusPath)
    local len = #cusPath
    local index = 1
    while index <= len - 2 do

        local p = cusPath[index]
        local p2 = cusPath[index + 1]
        local p3 = cusPath[index + 2]

        if (p.col == p2.col and p2.row == p3.row) or (p.row == p2.row and p2.col == p3.col) then
            table.remove(cusPath,index + 1)
            len = len - 1
        end
        index = index + 1
    end
end

--往目标方向移动
function __walkSd(self,tile)
    local dir = self:__sd(tile)
    local next = tile:next(dir)
    if self:__allowed(next) then
        table.insert( self.m_checkList,next)
        return true
    end
    return false
end

--撞墙后分开走
function __walkBranch(self,tile)
    local sdir = self:__sd(tile)
    local sdir_next = tile:next(sdir)
    if tile.wall == DIR.NONE and self:__atWall(sdir_next) then
        local d1 = (sdir+1) % DIR.NONE
        local next1 = tile:next(d1)
        next1:setWD(sdir,d1)
        table.insert( self.m_checkList,next1)
        
        local d2 = (sdir+3) % DIR.NONE
        local next2 = tile:next(d2)
        next2:setWD(sdir,d2)
        table.insert( self.m_checkList,next2)
    else
        local wdir = tile.wall
        local wdir_tile = tile:next(wdir)
        if self:__atWall(wdir_tile) == false then --已经绕过墙了
            wdir_tile:setWD((tile.dir + 2)%DIR.NONE,wdir)
            table.insert(self.m_checkList,wdir_tile)
        else
            local next = tile:next(tile.dir)
            next:setWD(tile.wall,tile.dir)
            table.insert(self.m_checkList,next)
        end
    end
end

--获取直接通往目标的方向
function __sd(self,tile)
    if math.abs( tile.col - self.m_e_t.col ) >= math.abs( tile.row - self.m_e_t.row ) then
        if tile.col < self.m_e_t.col then
            return DIR.RIGHT
        else
            return DIR.LEFT
        end
    end
    if tile.row < self.m_e_t.row then
        return DIR.DOWN
    else
        return DIR.UP
    end
end
--格子是否允许走
function __allowed(self,tile)
    local visited = self.m_visited[tile.col] and self.m_visited[tile.col][tile.row]
    if visited then
        return false
    end
    if self:__atWall(tile) then
        return false
    end
    return true
end
--格子是否在墙上
function __atWall(self,tile)
    local empty = fight.SceneManager:isEmptyTile(tile,self.m_f_id)
    return not empty
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
