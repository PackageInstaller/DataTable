-- @FileName:   CiruitGridVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.ciruit.manager.CiruitGridVo', Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function setData(self, id, gridConfigVo)
    self.m_id = id
    self.m_configVo = gridConfigVo

    self:initPassDir()
end

function initPassDir(self)
    self.m_passsDirDic = {} --哪些方向可以链接
    if self.m_configVo.grid_type == CiruitConst.GridType.Start then
        self.m_passsDirDic =
        {
            [CiruitConst.GridDir.Up] = {type = 1, grid = {}},
            [CiruitConst.GridDir.Right] = {type = 1, grid = {}},
            [CiruitConst.GridDir.Down] = {type = 1, grid = {}},
            [CiruitConst.GridDir.Left] = {type = 1, grid = {}},
        }

    elseif self.m_configVo.grid_type == CiruitConst.GridType.End then
        self.m_passsDirDic =
        {
            [CiruitConst.GridDir.Up] = {type = 1, grid = {}},
            [CiruitConst.GridDir.Right] = {type = 1, grid = {}},
            [CiruitConst.GridDir.Down] = {type = 1, grid = {}},
            [CiruitConst.GridDir.Left] = {type = 1, grid = {}},
        }
    elseif self.m_configVo.grid_type == CiruitConst.GridType.L then
        self.m_passsDirDic =
        {
            [CiruitConst.GridDir.Down] = {type = 1, grid = {}},
            [CiruitConst.GridDir.Left] = {type = 1, grid = {}},
        }
    elseif self.m_configVo.grid_type == CiruitConst.GridType.I then
        self.m_passsDirDic =
        {
            [CiruitConst.GridDir.Up] = {type = 1, grid = {}},
            [CiruitConst.GridDir.Down] = {type = 1, grid = {}},
        }
    elseif self.m_configVo.grid_type == CiruitConst.GridType.Skew then
        self.m_passsDirDic =
        {
            [CiruitConst.GridDir.Up] = {type = 1, grid = {}}, --1
            [CiruitConst.GridDir.Right] = {type = 2, grid = {}}, --2
            [CiruitConst.GridDir.Down] = {type = 2, grid = {}}, --2
            [CiruitConst.GridDir.Left] = {type = 1, grid = {}}, --1
        }
    elseif self.m_configVo.grid_type == CiruitConst.GridType.T then
        self.m_passsDirDic =
        {
            [CiruitConst.GridDir.Right] = {type = 1, grid = {}},
            [CiruitConst.GridDir.Down] = {type = 1, grid = {}},
            [CiruitConst.GridDir.Left] = {type = 1, grid = {}},
        }
    elseif self.m_configVo.grid_type == CiruitConst.GridType.Cross then
        self.m_passsDirDic =
        {
            [CiruitConst.GridDir.Up] = {type = 1, grid = {}}, --1
            [CiruitConst.GridDir.Right] = {type = 2, grid = {}}, --2
            [CiruitConst.GridDir.Down] = {type = 1, grid = {}}, --1
            [CiruitConst.GridDir.Left] = {type = 2, grid = {}}, --2
        }
    end
end

--放入场景
function put(self, row, col)
    self.m_row = row
    self.m_col = col
end

--从场景里面回收
function revoke(self)
    self.m_row = nil
    self.m_col = nil

    self:initPassDir()
end

function isPut(self)
    return self.m_row ~= nil and self.m_col ~= nil
end

function resetPassState(self)
    local passDic = {}
    for dir, dirGridDic in pairs(self.m_passsDirDic) do
        dirGridDic.grid = {}
        passDic[dir] = dirGridDic
    end
    self.m_passsDirDic = passDic

    if self.m_configVo.grid_type == CiruitConst.GridType.Start then
        for dir, passGrid in pairs(self.m_passsDirDic) do
            passGrid.grid[self.m_id] = 1
        end
    end
end

function rotate(self, angle)
    local count = math.ceil(angle / 90)
    for j = 1, count do
        local newState = {}
        newState[1] = self.m_passsDirDic[4]
        for i = 1, 4 - 1 do
            newState[i + 1] = self.m_passsDirDic[i]
        end

        self.m_passsDirDic = newState
    end
end

function pass(self, sourceDir, sourceGridIdList)
    if not self:canPass(sourceDir) then
        return false
    end

    local tabEqual = function (tab1, tab2)
        for key1, value1 in pairs(tab1) do
            if tab2[key1] == nil then
                return false
            end
        end

        for key2, value2 in pairs(tab2) do
            if tab1[key2] == nil then
                return false
            end
        end

        return true
    end

    --判断是不是所有方向联通的起点都一样，如果是一样的中断。避免递归死循环
    local isEqual = true
    local passDirList = self:getDirPassDirList(sourceDir)
    for _, dir in pairs(passDirList) do
        if not tabEqual(self.m_passsDirDic[sourceDir].grid, sourceGridIdList) then
            isEqual = false
            break
        end
    end
    if isEqual then
        return false
    end

    local passGridIdList = {}
    for gridId, _ in pairs(sourceGridIdList) do
        passGridIdList[gridId] = 1
    end
    for gridId, _ in pairs(self.m_passsDirDic[sourceDir].grid) do
        passGridIdList[gridId] = 1
    end

    for _, dir in pairs(passDirList) do
        self.m_passsDirDic[dir].grid = passGridIdList
    end
    self.m_passsDirDic[sourceDir].grid = passGridIdList

    -- logAll(sourceDir, "来源方向" .. self.m_id)
    -- logAll(sourceGridIdList, "来源连通" .. self.m_id)

    -- logAll(passDirList, "可以联通的方向" .. self.m_id)
    -- logAll(self.m_passsDirDic, "联通情况" .. self.m_id)

    return true
end

function getGridType(self)
    return self.m_configVo.grid_type
end

function getId(self)
    return self.m_id
end

--获取联通的所有方向起点
function getPassDirDic(self)
    return self.m_passsDirDic
end

--获取输入的方向可以联通的方向(包含输入的方向)
function getDirPassDirList(self, dir)
    local dirList = {}
    if not dir then
        for _dir, dic in pairs(self.m_passsDirDic) do --除了输入的方向之外类型相同证明可以想通
            table.insert(dirList, _dir)
        end

        return dirList
    end

    local dirDic = self.m_passsDirDic[dir]
    if not dirDic == nil then --输入的方向无法联通
        return nil
    end

    for _dir, dic in pairs(self.m_passsDirDic) do --除了输入的方向之外类型相同证明可以想通
        if dir ~= _dir then --必须要排除输入的方向
            if dirDic.type == dic.type then
                table.insert(dirList, _dir)
            end
        end
    end

    return dirList
end

--是否可以联通
function canPass(self, dir)
    if self.m_configVo.grid_type == CiruitConst.GridType.Start then
        return false
    end

    if not dir then
        return false
    end

    if self.m_passsDirDic[dir] == nil then
        return false
    end

    return true
end

--获取方向联通的格子id
function getPassGridIdDic(self, dir)
    return self.m_passsDirDic[dir].grid
end

---是否联通 (不输入方向，随便一个方向链接都算联通)
function isPass(self, dir)
    if dir == nil then
        for dir, gridDic in pairs(self.m_passsDirDic) do
            if not table.empty(gridDic.grid) then
                return true
            end
        end
        return false
    end

    if not self.m_passsDirDic[dir] then
        return false
    end

    return not table.empty(self.m_passsDirDic[dir].grid)
end

function getConfigData(self)
    return self.m_configVo
end

-- 回收
function recover(self)
    self.m_id = nil
    self.m_row = nil
    self.m_col = nil

    self.m_configVo = nil

    self.m_passsDirDic = nil

    LuaPoolMgr:poolRecover(self)
end

return _M
