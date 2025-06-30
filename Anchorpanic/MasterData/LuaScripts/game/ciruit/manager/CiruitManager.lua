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
function initData(self, dupConfigVo)
    self.m_gridDic = {}
    self.m_sceneGridVoDic = {}

    self.m_startGridDic = {}
    self.m_endGridDic = {}

    self.m_putGridDic = {}

    self.m_maxRow, self.m_maxCol = dupConfigVo.max_row, dupConfigVo.max_col

    for id, grid in pairs(dupConfigVo.grid_list) do
        local row = grid.row
        local col = grid.col

        local gridConfigVo = self:getGridConfig(grid.gird_id)
        if not gridConfigVo then
            logError("grid 配置找不到 grid_id = " .. grid.gird_id)
        else
            if gridConfigVo.grid_type == CiruitConst.GridType.Put then
                local gridVo = self:creatGridVo(id, gridConfigVo)
                gridVo:put(row, col)

                if not self.m_putGridDic[row] then
                    self.m_putGridDic[row] = {}
                end

                self.m_putGridDic[row][col] = gridVo
            end
        end
    end
end

function putGridVo(self, row, col, gridVo)
    gridVo:put(row, col)

    if not self.m_sceneGridVoDic[row] then
        self.m_sceneGridVoDic[row] = {}
    end
    self.m_sceneGridVoDic[row][col] = gridVo

    if gridVo:getGridType() == CiruitConst.GridType.Start then
        self.m_startGridDic[gridVo:getId()] = gridVo
    end

    if gridVo:getGridType() == CiruitConst.GridType.End then
        self.m_endGridDic[gridVo:getId()] = gridVo
    end
end

function revokeGridVo(self, gridVo)
    local row, col = gridVo.m_row, gridVo.m_col
    if row == nil or col == nil then
        return
    end

    if self.m_sceneGridVoDic[row] == nil then
        return
    end

    self.m_sceneGridVoDic[row][col] = nil
end

function canPut(self, row, col, grid_id)
    if row <= 0 or col <= 0 then
        return false
    end

    if row > self.m_maxRow or col > self.m_maxCol then
        return false
    end

    if not self.m_putGridDic[row] then
        return false
    end

    if self.m_putGridDic[row][col] == nil then
        return false
    end

    if self.m_sceneGridVoDic[row] then
        local sceneGridVo = self.m_sceneGridVoDic[row][col]
        if sceneGridVo ~= nil and sceneGridVo:getId() ~= grid_id then
            return false
        end
    end

    return true
end

function checkGridPass(self)
    for row, gridDic in pairs(self.m_sceneGridVoDic) do
        for col, gridVo in pairs(gridDic) do
            gridVo:resetPassState()
            -- local pos = "   row = " .. row .. "   col = " .. col .. "  id= "..gridVo:getId()
            -- logAll(gridVo.m_passsDirDic, " ---- "..pos)
        end
    end

    -- logAll("本次操作结束========================")

    for _, startGridVo in pairs(self.m_startGridDic) do
        self:checkGridVo(startGridVo)
    end
end

function checkGridVo(self, gridVo, sourceDir)
    if gridVo.m_configVo.grid_type == CiruitConst.GridType.End then
        return
    end

    local row = gridVo.m_row
    local col = gridVo.m_col
    local grid_id = gridVo:getId()

    local dirList = gridVo:getDirPassDirList(sourceDir) --方向对应的联通的方向
    for _, dir in pairs(dirList) do
        if dir == CiruitConst.GridDir.Up then
            local upGridVo = self:getSceneGridVo(row - 1, col)
            if upGridVo ~= nil then
                if upGridVo:pass(CiruitConst.GridDir.Down, gridVo:getPassGridIdDic(CiruitConst.GridDir.Up)) then
                    self:checkGridVo(upGridVo, CiruitConst.GridDir.Down)
                end
            end
        elseif dir == CiruitConst.GridDir.Right then
            local rightGridVo = self:getSceneGridVo(row, col + 1)
            if rightGridVo ~= nil then
                if rightGridVo:pass(CiruitConst.GridDir.Left, gridVo:getPassGridIdDic(CiruitConst.GridDir.Right)) then
                    self:checkGridVo(rightGridVo, CiruitConst.GridDir.Left)
                end
            end
        elseif dir == CiruitConst.GridDir.Down then
            local downGridVo = self:getSceneGridVo(row + 1, col)
            if downGridVo ~= nil then
                if downGridVo:pass(CiruitConst.GridDir.Up, gridVo:getPassGridIdDic(CiruitConst.GridDir.Down)) then
                    self:checkGridVo(downGridVo, CiruitConst.GridDir.Up)
                end
            end
        elseif dir == CiruitConst.GridDir.Left then
            local leftGridVo = self:getSceneGridVo(row, col - 1)
            if leftGridVo ~= nil then
                if leftGridVo:pass(CiruitConst.GridDir.Right, gridVo:getPassGridIdDic(CiruitConst.GridDir.Left)) then
                    self:checkGridVo(leftGridVo, CiruitConst.GridDir.Right)
                end
            end
        end
    end
end

function checkSettlementPanel(self)
    for endGrid_id, endGridVo in pairs(self.m_endGridDic) do
        if not self:checkEndGridPass(endGridVo) then
            return false
        end
    end

    return true
end

function checkEndGridPass(self, endGridVo)
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

    for _, startGridVo in pairs(self.m_startGridDic) do
        if passGridIdDic[startGridVo:getId()] == nil then
            return false
        end
    end

    return true
end

function getStartGridVoDic(self)
    return self.m_startGridDic
end

function getEndGridVoDic(self)
    return self.m_endGridDic
end

function getSceneGridVo(self, row, col)
    if row <= 0 or col <= 0 then
        return nil
    end

    if row > self.m_maxRow or col > self.m_maxCol then
        return nil
    end

    if not self.m_sceneGridVoDic[row] then
        return nil
    end

    return self.m_sceneGridVoDic[row][col]
end

function creatGridVo(self, id, gridConfigVo)
    if not self.m_gridDic then
        return nil
    end

    local gridVo = ciruit.CiruitGridVo:poolGet()
    gridVo:setData(id, gridConfigVo)

    self.m_gridDic[id] = gridVo

    return gridVo
end

function recoverGridVo(self, gridVo)
    local grid_id = gridVo:getId()
    if gridVo:isPut() then
        local row = gridVo.m_row
        local col = gridVo.m_col

        if self.m_sceneGridVoDic and self.m_sceneGridVoDic[row] then
            self.m_sceneGridVoDic[row][col] = nil
        end

        if self.m_startGridDic then
            self.m_startGridDic[grid_id] = nil
        end

        if self.m_endGridDic then
            self.m_endGridDic[grid_id] = nil
        end
    end
    if grid_id then
        self.m_gridDic[grid_id]:recover()
        self.m_gridDic[grid_id] = nil
    end
end

function clearData(self)
    if self.m_putGridDic then
        for row, colDic in pairs(self.m_putGridDic) do
            for col, gridVo in pairs(colDic) do
                gridVo:recover()
            end
        end
    end

    self.m_putGridDic = nil
    self.m_maxRow, self.m_maxCol = nil, nil
end

function getIsShowRed(self)
    local areaConfig = self:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(areaConfig) do
        if self:getAreaShowRed(areaConfigVo) then
            return true
        end
    end

    return false
end

function getAreaShowRed(self, areaConfigVo)
    local timeOpen = areaConfigVo:isOpen()
    if not timeOpen then
        return false
    end

    for i = 1, #areaConfigVo.stage_list do
        local dup_id = areaConfigVo.stage_list[i]
        if self:getDupShowRed(dup_id) then
            return true
        end
    end

    return false
end

function getDupShowRed(self, dup_id)
    local dupConfig = self:getDupConfig(dup_id)
    if dupConfig then
        local lastDup_id = dupConfig.pre_id
        if self:getDupPassState(lastDup_id) and not self:getDupPassState(dup_id) and dupConfig:isOpen() and not StorageUtil:getBool1(gstor.CIRUIT_DUPNEWOPENSTR .. dup_id) then
            return true
        end
    end

    return false
end

return _M
