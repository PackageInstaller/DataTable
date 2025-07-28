-- @FileName:   CiruitManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.ciruit.manager.CiruitManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

--初始化
function init(self)
    self.mDupRecordList = {}
    self.mStarAwardStateList = {}
end

function parseAreaConfigData(self)
    self.mAreaConfigVoDic = {}
    local baseData = RefMgr:getData("circuit_area_data")
    for key, data in pairs(baseData) do
        local baseVo = ciruit.CiruitAreaConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.mAreaConfigVoDic[key] = baseVo
    end
end

function parseDupConfigData(self)
    self.mDupConfigVoDic = {}
    local baseData = RefMgr:getData("circuit_dup_data")
    for key, data in pairs(baseData) do
        local baseVo = ciruit.CiruitDupConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.mDupConfigVoDic[key] = baseVo
    end
end

function parseGridConfigData(self)
    self.mGridConfigVoDic = {}
    local baseData = RefMgr:getData("circuit_grid_data")
    for key, data in pairs(baseData) do
        local baseVo = ciruit.CiruitGridConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.mGridConfigVoDic[key] = baseVo
    end
end

--------------------------------------------配置数据
--获取地图区域配置
function getAreaConfig(self, area_id)
    if not self.mAreaConfigVoDic then
        self:parseAreaConfigData()
    end
    return self.mAreaConfigVoDic[area_id]
end

function getAreaConfigDic(self)
    if not self.mAreaConfigVoDic then
        self:parseAreaConfigData()
    end
    return self.mAreaConfigVoDic
end

--获取副本配置
function getDupConfig(self, dup_id)
    if not self.mDupConfigVoDic then
        self:parseDupConfigData()
    end
    return self.mDupConfigVoDic[dup_id]
end

--获取格子配置
function getGridConfig(self, grid_id)
    if not self.mGridConfigVoDic then
        self:parseGridConfigData()
    end
    return self.mGridConfigVoDic[grid_id]
end

--获取区域id根据副本id
function getAreaIdByDupId(self, dupId)
    local allAreaCofig = self:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(allAreaCofig) do
        for _, dup_id in pairs(areaConfigVo.stage_list) do
            if dupId == dup_id then
                return areaId
            end
        end
    end

    return 1
end

--获取下一个关卡
function getNextDupId(self, dupId)
    local isBreak = false
    local allAreaCofig = self:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(allAreaCofig) do
        if isBreak then
            return areaConfigVo.stage_list[1]
        end

        local length = #areaConfigVo.stage_list
        for i = 1, length do
            if areaConfigVo.stage_list[i] == dupId then
                local next_index = i + 1
                if next_index <= length then
                    return areaConfigVo.stage_list[next_index]
                else
                    isBreak = true
                    break
                end
            end
        end
    end
end

------------------------------------------服务器数据
function setPassDupId(self, passDupIdList)
    self.mPassDupDic = {}

    for _, dupId in pairs(passDupIdList) do
        self.mPassDupDic[dupId] = 1
    end
end

function getAreaPassState(self, area_id)
    local areaConfig = self:getAreaConfig(area_id)
    if areaConfig then
        for _, dupId in pairs(areaConfig.stage_list) do
            if not self:getDupPassState(dupId) then
                return false
            end
        end
    end

    return true
end

function getDupPassState(self, dupId)
    if not self.mPassDupDic then
        return false
    end
    return self.mPassDupDic[dupId] == 1
end

-----------------------------------------缓存数据

--初始化格子数据 从左上往下往右开始
function initGridVo(self, dupConfigVo)
    self.m_GridVoDic = {}
    self.m_StartGridList = {}
    self.m_EndGridList = {}
    self.m_MaxRow, self.m_MaxCol = 0, 0

    for id, grid in pairs(dupConfigVo.grid_list) do
        local row = grid.row
        local col = grid.col
        if not self.m_GridVoDic[row] then
            self.m_GridVoDic[row] = {}
        end

        local gridConfigVo = self:getGridConfig(grid.gird_id)
        if not gridConfigVo then
            logError("grid 配置找不到 grid_id = " .. grid.gird_id)
        else
            local gridVo = ciruit.CiruitGridVo:poolGet()
            gridVo:setData(id, row, col, gridConfigVo)

            self.m_GridVoDic[row][col] = gridVo

            if gridConfigVo.grid_type == CiruitConst.GridType.Start then
                table.insert(self.m_StartGridList, gridVo)
            end

            if gridConfigVo.grid_type == CiruitConst.GridType.End then
                table.insert(self.m_EndGridList, gridVo)
            end
        end

        if self.m_MaxRow < row then
            self.m_MaxRow = row
        end

        if self.m_MaxCol < col then
            self.m_MaxCol = col
        end
    end
end

function checkGridPass(self)
    for row, gridDic in pairs(self.m_GridVoDic) do
        for col, gridVo in pairs(gridDic) do
            gridVo:resetPassState()
        end
    end

    for _, startGridVo in pairs(self.m_StartGridList) do
        self:checkGridVo(startGridVo)
    end
end

function checkGridVo(self, grid, sourceDir)
    if grid.m_configVo.grid_type == CiruitConst.GridType.End then
        return
    end

    local row = grid.m_row
    local col = grid.m_col
    local grid_id = grid:getId()

    local dirList = grid:getDirPassDirList(sourceDir) --方向对应的联通的方向
    for _, dir in pairs(dirList) do
        if grid:isPass(dir) then
            if dir == CiruitConst.GridDir.Up then
                local upGrid = self:getGridVo(row - 1, col)
                if upGrid ~= nil then
                    if upGrid:pass(CiruitConst.GridDir.Down, grid:getPassGridIdDic(CiruitConst.GridDir.Up)) then
                        self:checkGridVo(upGrid, CiruitConst.GridDir.Down)
                    end
                end
            elseif dir == CiruitConst.GridDir.Right then
                local rightGrid = self:getGridVo(row, col + 1)
                if rightGrid ~= nil then
                    if rightGrid:pass(CiruitConst.GridDir.Left, grid:getPassGridIdDic(CiruitConst.GridDir.Right)) then
                        self:checkGridVo(rightGrid, CiruitConst.GridDir.Left)
                    end
                end
            elseif dir == CiruitConst.GridDir.Down then
                local downGrid = self:getGridVo(row + 1, col)
                if downGrid ~= nil then
                    if downGrid:pass(CiruitConst.GridDir.Up, grid:getPassGridIdDic(CiruitConst.GridDir.Down)) then
                        self:checkGridVo(downGrid, CiruitConst.GridDir.Up)
                    end
                end
            elseif dir == CiruitConst.GridDir.Left then
                local leftGrid = self:getGridVo(row, col - 1)
                if leftGrid ~= nil then
                    if leftGrid:pass(CiruitConst.GridDir.Right, grid:getPassGridIdDic(CiruitConst.GridDir.Left)) then
                        self:checkGridVo(leftGrid, CiruitConst.GridDir.Right)
                    end
                end
            end
        end
    end
end

function checkSettlementPanel(self)
    for k, endGridVo in pairs(self.m_EndGridList) do
        if not endGridVo:isPass() then
            return false
        end

        local passGridIdDic = {} --当前终点链接的所有起点
        -- --所有方向是否都联通了起点
        local endPassDirDic = endGridVo:getPassDirDic()
        for dir, dirPassGridDic in pairs(endPassDirDic) do
            for gridId, _ in pairs(dirPassGridDic.grid) do
                passGridIdDic[gridId] = 1
            end
        end

        for _, startGridVo in pairs(self.m_StartGridList) do
            if passGridIdDic[startGridVo:getId()] == nil then
                return false
            end
        end
    end

    return true
end

function getStartGridVoList(self)
    return self.m_StartGridList
end

function getEndGridVoList(self)
    return self.m_EndGridList
end

function getGridVo(self, row, col)
    if row <= 0 or col <= 0 then
        return nil
    end

    if row > self.m_MaxRow or col > self.m_MaxCol then
        return nil
    end

    return self.m_GridVoDic[row][col]
end

function clearGridVo(self)
    if not self.m_GridVoDic then
        return
    end

    for row, gridDic in pairs(self.m_GridVoDic) do
        for col, gridVo in pairs(gridDic) do
            gridVo:recover()
        end
    end

    self.m_GridVoDic = nil
    self.m_StartGridList = nil
end

return _M
