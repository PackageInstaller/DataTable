




ManagementBigCellData = {}
ManagementBigCellData.__index = ManagementBigCellData




function ManagementBigCellData.New(gridPos)

    local self = {}
    setmetatable(self, ManagementBigCellData)
    self.gridPos = gridPos
    self.curLayer = 1
    self.allSmallCells = {}
    return self
end

function ManagementBigCellData:SetValid(isValid)
    self.isValid = isValid
end

function ManagementBigCellData:GetValid()
    return self.isValid or false
end



function ManagementBigCellData:Add(smallCell, layer, index)
    if self.smallCellDic == nil then
        self.smallCellDic = {}
    end
    if self.smallCellDic[layer] == nil then
        self.smallCellDic[layer] = {}
    end
    self.smallCellDic[layer][smallCell.data.smallGridPos:ToString()] = smallCell
    table.insert(self.allSmallCells, smallCell)
end




function ManagementBigCellData:SetSmallCell(goalSmallCell, goalGridPos)
    local layerCellDic = self.smallCellDic[self.curLayer]
    if layerCellDic == nil then
        LuaDebug.error("ManagementBigCellData:SetSmallCell错误：当前层级数据不存在，curLayer=" .. tostring(self.curLayer))
        return
    end
    layerCellDic[goalGridPos:ToString()] = goalSmallCell
end




function ManagementBigCellData:GetSmallCell(gridPos)
    local layerCells = self.smallCellDic[self.curLayer]
    if layerCells == nil then
        LuaDebug.error("ManagementBigCellData:GetSmallCell错误：当前层级数据不存在，curLayer=" .. tostring(self.curLayer))
        return nil, false
    end
    return layerCells[gridPos:ToString()], true
end

function ManagementBigCellData:GetSmallCells()
    local layerCells = self.smallCellDic[self.curLayer]
    if layerCells == nil then
        LuaDebug.error("ManagementBigCellData:GetSmallCells错误：当前层级数据不存在，curLayer=" .. tostring(self.curLayer))
        return {}
    end
    return layerCells
end



function ManagementBigCellData:GetAllSmallCells()
    return self.allSmallCells
end


function ManagementBigCellData:CanMove()
    local layerCells = self.smallCellDic[self.curLayer]
    if layerCells == nil then
        return false
    end
    local existEmptyCell = false
    for key, value in pairs(layerCells) do
        if value:IsEmpty() then
            existEmptyCell = true
            break
        end
    end
    return existEmptyCell
end

function ManagementBigCellData:CheckEliminated()
    local layerCellDic = self.smallCellDic[self.curLayer]
    if layerCellDic == nil then
        LuaDebug.error("ManagementBigCellData:CheckEliminated错误：当前层级数据不存在，curLayer=" .. tostring(self.curLayer))
        return nil
    end

    local elementsGroup = {}
    for key, value in pairs(layerCellDic) do
        local elementID = value:GetElementID()
        if elementID > 0 then
            if elementsGroup[elementID] == nil then
                elementsGroup[elementID] = {}
            end
            table.insert(elementsGroup[elementID], value)
        end
    end
    local canElimilateElementID = 0
    for elementID, cellList in pairs(elementsGroup) do
        if #cellList >= 3 then
            canElimilateElementID = elementID
            break
        end
    end
    local data = {}

    data.bigCellData = self
    data.canElimilateElement = true
    if canElimilateElementID == 0 then
        data.canElimilateElement = false
        return data
    end
    data.posKey = self.gridPos:ToString()
    data.layer = self.curLayer
    data.smallCellsDic = layerCellDic
    return data
end

function ManagementBigCellData:RefreshLayer()
    for key, layerItems in pairs(self.smallCellDic) do
        for _, smallItem in pairs(layerItems) do
            smallItem:SetIsUnlock(key == self.curLayer)
        end
    end
    local layerCellDic = self.smallCellDic[self.curLayer]
    local isAllEmpty = true
    for key, value in pairs(layerCellDic) do
        if not value:IsEmpty() then
            isAllEmpty = false
            break
        end
    end
    local oldLayer = self.curLayer
    if isAllEmpty == true then
        local curLayer = self.curLayer + 1
        local newLayerDic = self.smallCellDic[curLayer]
        if newLayerDic ~= nil then
            for key, smallItem in pairs(newLayerDic) do
                smallItem:SetIsUnlock(true)
            end
            self.curLayer = curLayer
        end
    end
    return oldLayer ~= self.curLayer
end

function ManagementBigCellData:SetTotalLayer(totalLayer)
    self.totalLayer = totalLayer
end

function ManagementBigCellData:Reset()
    self.curLayer = 1
    self.allSmallCells = {}
end

function ManagementBigCellData:PrintLog()
    if not LuaMgr.IsDebug() then
        return
    end
    local layerCellDic = self.smallCellDic[self.curLayer]
    if layerCellDic == nil then
        LuaDebug.error("ManagementBigCellData:PrintLog错误：当前层级数据不存在，curLayer=" .. tostring(self.curLayer))
        return
    end
    for key, value in pairs(layerCellDic) do
        LuaDebug.error(self.gridPos:ToString() .. "|" .. tostring(key) .. ", valueSmallPos=" .. value.data.smallGridPos:ToString())
    end
end