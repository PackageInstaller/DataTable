require("Match3Game/Data/GridPosition")
require("Match3Game/Data/Element/ElementBase")
require("Match3Game/Data/Element/ElementColorBall")
require("Match3Game/Data/Element/ElementHorizontal")
require("Match3Game/Data/Element/ElementSuperColorBall")
require("Match3Game/Data/Element/ElementVertical")














GridManager = {}
GridManager.__index = GridManager

function GridManager.New(elementFactory, gridTransform)

    local self = {}
    setmetatable(self, GridManager)
    self.elementFactory = elementFactory
    self.gridTransform = gridTransform
    self:InitEvents()
    return self
end

function GridManager:Init(passData)
    self.width = passData.gridWidth
    self.height = passData.gridHeight
    self.passData = passData
    self.emptyPosDatas = {}
    self.curRoundMaxAnimTime = 0

    self.initialEmptyPositions = {}

    self.columnEliminateCounts = {}

    self.needGenElements = {}
    self.grid = {}
    self:CalGenNormalElementWeight()
    self:CalGenSpecialElementWeight()
end


function GridManager:InitEvents()
    self.onPositionChanged = function(params)
        local data = params[0]

        local element = data.element
        local oldKey = data.oldPos:ToString()
        local grid = self.grid
        local oldElementID = grid[oldKey]:GetID()
        local elementID = element:GetID()
        if element ~= nil and grid[oldKey] ~= nil and oldElementID == elementID then
            grid[oldKey] = nil
        end
        local newKey = element.Pos:ToString()
        grid[newKey] = element
    end
    self.onPositionChangedEnd = function(params)
        local data = params[0]
        local oldKey = data.fromPos:ToString()
        local newKey = data.toPos:ToString()

        self.grid[oldKey] = nil
        self.grid[newKey] = data.element
        self.elementFactory:CacheCellByPosKey(data.fromPos, nil)
        local cell = data.cell
        self.elementFactory:CacheCellByPosKey(data.toPos, cell)
    end

    LuaMgr.AddUIEventListener(UIEventConst.ElementPositionChanged, self.onPositionChanged)
    LuaMgr.AddUIEventListener(UIEventConst.SingElementFallEnd, self.onPositionChangedEnd)
end



function GridManager:InitGrid(passData)
    self:ClearGrid()
    local posCache = {}
    for y = 1, self.height do
        posCache[y] = {}
        for x = 1, self.width do
            local pos = GridPosition.New(x, y)
            local elementType, isIce = self:GetInitCellElementData(passData, y, x)
            if elementType ~= Match3Const.ElementType.None then
                self:CreateElement(Match3Const.ElementType.None, pos, false, true)
            end
            table.insert(posCache[y], #posCache[y] + 1, pos)
        end
    end
    for y = 1, self.height do
        for x = 1, self.width do
            if y == 1 then
                local tempPos = GridPosition.New(x, y - 1)
                table.insert(self.initialEmptyPositions, tempPos:ToString())
            end
            local pos = posCache[y][x]
            local elementType, isIce = self:GetInitCellElementData(passData, y, x)
            if elementType == Match3Const.ElementType.None then
                table.insert(self.initialEmptyPositions, pos:ToString())
            else
                self:CreateElement(elementType, pos, isIce)
            end
        end
    end
    self:SetAllBornPoint()
    LuaMgr.InvokeUIEventListeners(UIEventConst.GridInitialized)
end

function GridManager:SetAllBornPoint()
    self.elementBornPointsDic = {}
    self.elementBornPoints = {}
    for x = 1, self.width do
        local colBornPointDic = {}
        local colBornPoints = {}
        local lastValidElement = nil
        local y = self.height
        while y >= 0 do
            local pos = GridPosition.New(x, y)
            local element = self:GetElementAt(pos)
            if element == nil and lastValidElement ~= nil and self:IsInitialEmpty(pos) then
                colBornPointDic[y] = pos
                table.insert(colBornPoints, #colBornPoints + 1, pos)
                lastValidElement = nil
            elseif element ~= nil then
                lastValidElement = element
            end
            y = y - 1
        end
        self.elementBornPointsDic[x] = colBornPointDic
        if #colBornPoints > 0 then
            self.elementBornPoints[x] = colBornPoints
        end
    end
end

function GridManager:GetInitCellElementData(passData, row, col)
    local elementType = Match3Const.ElementType.None
    if passData.rowCol[row] == nil or passData.rowCol[row][col] == nil then
        return elementType
    end
    local cellConfig = passData.rowCol[row][col]
    local isIce = false
    if cellConfig[1] ~= nil then
        elementType = cellConfig[1]
    end
    if cellConfig[2] ~= nil then
        isIce = true
    end
    return elementType, isIce
end





function GridManager:CreateElement(elementType, pos, isIce, isBGGrid)
    local element = self:CreateElementData(elementType, pos, isIce)
    local key = pos:ToString()
    local cell = nil
    if isBGGrid then
        cell = self.elementFactory:GetElementView(elementType, false)
        cell:SetElement(element)
    else
        self.grid[key] = element
        cell = self.elementFactory:GetElementView(elementType, isIce)
        cell:SetElement(element)
        cell:SetVisible(true)
    end
    return cell
end




function GridManager:CreateElementDataByElement(pos, newElementType)

    local newElement = self:CreateElementData(newElementType, pos, false)
    local key = pos:ToString()
    self.grid[key] = newElement
    local animData = {}
    return animData, newElement
end






function GridManager:CreateElementData(elementType, pos, isIce)
    local element
    if pos == nil then

    end

    if elementType == Match3Const.ElementType.Bomb then
        element = ElementBomb.New(Match3Const.ElementType.Bomb, pos)
    elseif elementType == Match3Const.ElementType.Horizontal then
        element = ElementHorizontal.New(Match3Const.ElementType.Horizontal, pos)
    elseif elementType == Match3Const.ElementType.Vertical then
        element = ElementVertical.New(Match3Const.ElementType.Vertical, pos)
    elseif elementType == Match3Const.ElementType.ColorBall then
        element = ElementColorBall.New(Match3Const.ElementType.ColorBall, pos)
    elseif elementType == Match3Const.ElementType.SuperColorBall then
        element = ElementSuperColorBall.New(Match3Const.ElementType.SuperColorBall, pos)
    else
        element = ElementBase.New(elementType, pos, isIce)
    end
    element.IsEffectTriggered = false
    return element
end




function GridManager:GetElementAt(pos)
    local key = pos:ToString()
    return self.grid[key]
end






function GridManager:SwapElements(startPos, endPos)

    if not self:ArePositionsAdjacent(startPos, endPos) then
        LuaDebug.error("169: GridManager:SwapElements  交换位置不正确")
        return false, 0
    end

    local element1 = self:GetElementAt(startPos)
    local element2 = self:GetElementAt(endPos)

    if not element1 or not element2 then
        return false, 0
    end
    if element1.Type == Match3Const.ElementType.None or element2.Type == Match3Const.ElementType.None or element1.Type == Match3Const.ElementType.WoodenBox or element2.Type == Match3Const.ElementType.WoodenBox then
        return false, 0
    end


    local originalPos1 = element1.Pos:Clone()
    local originalPos2 = element2.Pos:Clone()

    local orgiginaCell1 = self.elementFactory:GetElementCellByPos(element1.Pos)
    local orgiginaCell2 = self.elementFactory:GetElementCellByPos(element2.Pos)
    self.elementFactory:CacheCellByPosKey(element2.Pos, orgiginaCell1)
    self.elementFactory:CacheCellByPosKey(element1.Pos, orgiginaCell2)

    element1:UpdatePosition(originalPos2)
    element2:UpdatePosition(originalPos1)
    local originalPos1Str = originalPos1:ToString()
    local originalPos2Str = originalPos2:ToString()
    self.grid[originalPos1Str] = element2
    self.grid[originalPos2Str] = element1

    local matches = self:FindMatchesAtPosition(startPos)
    if #matches == 0 then
        matches = self:FindMatchesAtPosition(endPos)
    end
    local existSpecialElement = false
    if #matches == 0 then
        if element1.IsSpecial == true then
            existSpecialElement = true
        end
        if element2.IsSpecial == true then
            existSpecialElement = true
        end
    end
    local data = {}
    data.element1 = element1
    data.element2 = element2
    data.isFail = #matches == 0 and existSpecialElement == false
    LuaMgr.InvokeUIEventListeners(UIEventConst.ElementsSwapped, data)
    if data.isFail == true then
        element1:UpdatePosition(originalPos1)
        element2:UpdatePosition(originalPos2)
        self.grid[originalPos1Str] = element1
        self.grid[originalPos2Str] = element2
        self.elementFactory:CacheCellByPosKey(element1.Pos, orgiginaCell1)
        self.elementFactory:CacheCellByPosKey(element2.Pos, orgiginaCell2)
        return false, Match3Const.SwapFaildTime
    end
    return true, Match3Const.SwapSuccessTime
end

function GridManager:ForceSwap(startPos, endPos)
    local element1 = self:GetElementAt(startPos)
    local element2 = self:GetElementAt(endPos)
    if element1 == nil or element2 == nil then
        return
    end

    local originalPos1 = element1.Pos:Clone()
    local originalPos2 = element2.Pos:Clone()

    element1:UpdatePosition(originalPos2)
    element2:UpdatePosition(originalPos1)
    local originalPos1Str = originalPos1:ToString()
    local originalPos2Str = originalPos2:ToString()
    self.grid[originalPos1Str] = element2
    self.grid[originalPos2Str] = element1

    local orgiginaCell1 = self.elementFactory:GetElementCellByPos(element1.Pos)
    local orgiginaCell2 = self.elementFactory:GetElementCellByPos(element2.Pos)
    self.elementFactory:CacheCellByPosKey(element2.Pos, orgiginaCell1)
    self.elementFactory:CacheCellByPosKey(element1.Pos, orgiginaCell2)

    local matches = self:FindMatchesAtPosition(startPos)
    if #matches == 0 then
        matches = self:FindMatchesAtPosition(endPos)
    end
    local data = {}
    data.element1 = element1
    data.element2 = element2
    data.isFail = false
    LuaMgr.InvokeUIEventListeners(UIEventConst.ElementsSwapped, data)
end

function GridManager:EliminateSpecialElement(pos)
    local element = self:GetElementAt(pos)
    local animData = {}
    animData.animTimeType = Match3Const.AnimTimeCalType.Max
    animData.animTime = 0
    if element == nil or element.IsSpecial == false then
        return animData
    end
    if element.TriggerEffect == nil then
        return animData
    end
    animData = element:TriggerEffect(self)
    return animData
end





function GridManager:ArePositionsAdjacent(pos1, pos2)
    local dx = math.abs(pos1.X - pos2.X)
    local dy = math.abs(pos1.Y - pos2.Y)
    return (dx == 1 and dy == 0) or (dx == 0 and dy == 1)
end






function GridManager:FindMatchesAtPosition(pos)
    local element = self:GetElementAt(pos)
    if not element or element.IsObstacle then
        return {}, {}, {}
    end
    local allMatchesElement = {}
    local horizontalMatches = self:FindHorizontalMatches(pos) or {}
    local verticalMatches = self:FindVerticalMatches(pos) or {}
    for key, value in pairs(horizontalMatches) do
        table.insert(allMatchesElement, value)
    end
    for key, value in pairs(verticalMatches) do
        table.insert(allMatchesElement, value)
    end
    return allMatchesElement, horizontalMatches, verticalMatches
end





function GridManager:GetSpecialTypeByMatch(elementDatas)

    local rowTables = {}

    local colTables = {}
    for key, value in pairs(elementDatas) do
        if value.Type ~= Match3Const.ElementType.WoodenBox then
            local pos = value.Pos
            if rowTables[pos.Y] == nil then
                rowTables[pos.Y] = {}
            end
            if colTables[pos.X] == nil then
                colTables[pos.X] = {}
            end
            rowTables[pos.Y][pos.X] = pos
            colTables[pos.X][pos.Y] = pos
        end
    end
    table.sort(elementDatas, GridManager.SortByPosX)
    table.sort(elementDatas, GridManager.SortByPosY)
    local rowTable, colTable = nil, nil
    local minNum = Match3Const.SpecialTypeMap[Match3Const.ElementType.None]
    for key, value in pairs(rowTables) do
        rowTable = {}
        for key1, value1 in pairs(value) do
            table.insert(rowTable, value1)
        end
        if #rowTable >= minNum then
            break
        end
    end
    for key, value in pairs(colTables) do
        colTable = {}
        for key1, value1 in pairs(value) do
            table.insert(colTable, value1)
        end
        if #colTable >= minNum then
            break
        end
    end
    if rowTable == nil or #rowTable == 0 then
        rowTable = nil
    end
    if colTable == nil or #colTable == 0 then
        colTable = nil
    end
    if rowTable ~= nil then
        table.sort(rowTable, GridManager.SortByPosXDescend)
    end
    if colTable ~= nil then
        table.sort(colTable, GridManager.SortByPosYDescend)
    end

    if rowTable == nil and colTable == nil then
        return Match3Const.ElementType.None
    end
    local existRowColorBall = false
    local existColColorBall = false
    if rowTable ~= nil then
        local realCount = #rowTable
        if realCount >= Match3Const.SpecialTypeMap[Match3Const.ElementType.ColorBall] then
            existRowColorBall = true
        elseif realCount == Match3Const.SpecialTypeMap[Match3Const.ElementType.Horizontal] then
            return Match3Const.ElementType.Vertical, rowTable[1]
        end
    end
    if colTable ~= nil then
        local realCount = #colTable
        if realCount >= Match3Const.SpecialTypeMap[Match3Const.ElementType.ColorBall] then
            existColColorBall = true
        elseif realCount == Match3Const.SpecialTypeMap[Match3Const.ElementType.Horizontal] then
            return Match3Const.ElementType.Horizontal, colTable[1]
        end
    end
    if existRowColorBall == true then
        if colTable ~= nil and #colTable >= minNum then
            return Match3Const.ElementType.SuperColorBall, rowTable[minNum]
        else
            return Match3Const.ElementType.ColorBall, rowTable[minNum]
        end
    end
    if existColColorBall == true then
        if rowTable ~= nil and #rowTable >= minNum then
            return Match3Const.ElementType.SuperColorBall, colTable[minNum]
        else
            return Match3Const.ElementType.ColorBall, colTable[minNum]
        end
    end
    return Match3Const.ElementType.None
end




function GridManager:FindHorizontalMatches(pos)
    local element = self:GetElementAt(pos)
    if not element then
        return {}
    end

    local tempMatchDic = {}
    tempMatchDic[element.Id] = element
    local elementType = element.Type


    local x = pos.X - 1
    while x > 0 do
        local leftPos = GridPosition.New(x, pos.Y)
        local leftElement = self:GetElementAt(leftPos)
        if leftElement and leftElement.Type == elementType then
            if tempMatchDic[leftElement.Id] == nil then
                tempMatchDic[leftElement.Id] = leftElement
            end
            x = x - 1
        else
            break
        end
    end


    x = pos.X + 1
    while x < self.width + 1 do
        local rightPos = GridPosition.New(x, pos.Y)
        local rightElement = self:GetElementAt(rightPos)
        if rightElement and rightElement.Type == elementType then
            if tempMatchDic[rightElement.Id] == nil then
                tempMatchDic[rightElement.Id] = rightElement
            end
            x = x + 1
        else
            break
        end
    end
    if NumTool.GetLen(tempMatchDic) < 3 then
        return {}
    end
    local matches = {}
    for key, element in pairs(tempMatchDic) do
        for i = 1, #Match3Const.Neighbor do
            local neighborOffset = Match3Const.Neighbor[i]
            local neighborCellPos = GridPosition.New(element.Pos.X + neighborOffset[1], element.Pos.Y + neighborOffset[2])
            local neighborCellElement = self:GetElementAt(neighborCellPos)
            if neighborCellElement and neighborCellElement.Type == Match3Const.ElementType.WoodenBox then
                table.insert(matches, neighborCellElement)
            end
        end
        table.insert(matches, element)
    end
    return matches
end




function GridManager:FindVerticalMatches(pos)
    local element = self:GetElementAt(pos)
    if not element or element.Type == Match3Const.ElementType.None then
        return {}
    end

    local tempMatchDic = {}
    tempMatchDic[element.Id] = element
    local elementType = element.Type

    local y = pos.Y - 1
    while y > 0 do
        local upPos = GridPosition.New(pos.X, y)
        local upElement = self:GetElementAt(upPos)
        if upElement and upElement.Type == elementType then
            if tempMatchDic[upElement.Id] == nil then
                tempMatchDic[upElement.Id] = upElement
            end
            y = y - 1
        else
            break
        end
    end


    y = pos.Y + 1
    while y < self.height + 1 do
        local downPos = GridPosition.New(pos.X, y)
        local downElement = self:GetElementAt(downPos)
        if downElement and downElement.Type == elementType then
            if tempMatchDic[downElement.Id] == nil then
                tempMatchDic[downElement.Id] = downElement
            end
            y = y + 1
        else
            break
        end
    end
    if NumTool.GetLen(tempMatchDic) < 3 then
        return {}
    end
    local matches = {}
    for key, element in pairs(tempMatchDic) do
        for i = 1, #Match3Const.Neighbor do
            local neighborOffset = Match3Const.Neighbor[i]
            local neighborCellPos = GridPosition.New(element.Pos.X + neighborOffset[1], element.Pos.Y + neighborOffset[2])
            local neighborCellElement = self:GetElementAt(neighborCellPos)
            if neighborCellElement and neighborCellElement.Type == Match3Const.ElementType.WoodenBox then
                table.insert(matches, neighborCellElement)
            end
        end
        table.insert(matches, element)
    end
    return matches
end



function GridManager:FindAllMatches()
    local allMatches = {}
local processedGroups = {}
    local sortFuncByID = function(data1, data2)
        return data1:GetID() > data2:GetID()
    end
    for y = 1, self.height do
        for x = 1, self.width do
            local pos = GridPosition.New(x, y)
            local element = self:GetElementAt(pos)
if element and not element.IsObstacle and element:IsNormalElement() then
                local horizontal = self:FindHorizontalMatches(pos)
                if #horizontal >= 3 then
                    table.sort(horizontal, sortFuncByID)
                    local id = string.format("%d_%d", horizontal[1]:GetID(), horizontal[#horizontal]:GetID())
                    if not processedGroups[id] then
                        processedGroups[id] = true
                        table.insert(allMatches, horizontal)
                    end
                end
                local vertical = self:FindVerticalMatches(pos)
                if #vertical >= 3 then
                    table.sort(vertical, sortFuncByID)
                    local id = string.format("%d_%d", vertical[1]:GetID(), vertical[#vertical]:GetID())
                    if not processedGroups[id] then
                        processedGroups[id] = true
                        table.insert(allMatches, vertical)
                    end
                end
            end
        end
    end
    return allMatches
end





function GridManager:EliminateElement(pos, data)
    data = data or {}

    local genElementType = data.genElementType or Match3Const.ElementType.None
    local element = self:GetElementAt(pos)
    local animTime = 0
    local animTimeType = Match3Const.AnimTimeCalType.Max
    if not element or element.Type == Match3Const.ElementType.None then
        return nil
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.ElementEliminated, element)
    local cell = self.elementFactory:GetElementCellByPos(element.Pos)
    if cell ~= nil then
        if genElementType == Match3Const.ElementType.None then
            animTime, animTimeType = cell:PlayEliminateAnimation()
        end
    end
    local animData = {}
    animData.animTimeType = animTimeType
    animData.animTime = animTime
    return animData
end


function GridManager:ForceChangeElementType()
    if self.allSpecialElement == nil or self.allNormalElement == nil then
        self.allNormalElement = {}
        self.allSpecialElement = {}
        for key, value in pairs(self.grid) do
            if value:IsNormalElement() then
                self.allNormalElement[key] = value
            elseif value.IsSpecial == true then
                self.allSpecialElement[key] = value
            end
        end
    end
    local allNormalKey = {}
    for key, value in pairs(self.allNormalElement) do
        table.insert(allNormalKey, key)
    end
    if #allNormalKey == 0 then
        return
    end
    local keyIndex = math.random(1, #allNormalKey)
    local key = allNormalKey[keyIndex]
    local element = self.allNormalElement[key]
    local cell = self.elementFactory:GetElementCellByPos(element.Pos)
    if cell ~= nil then
        self.elementFactory:CacheCellByPosKey(element.Pos, nil)
        local type = self:GetRandomSpecialElementType()
        local newElement = self:CreateElementData(type, element.Pos, false)
        self.grid[key] = newElement
        cell:SetElement(newElement)
        self.allSpecialElement[key] = newElement
        self.allNormalElement[key] = nil
    else
        LuaDebug.error("UI数据和实际数据对应补上。" .. key)
    end
end


function GridManager:EliminateAllSpecial()
    local animData = {}
    animData.animTimeType = Match3Const.AnimTimeCalType.Sum
    animData.animTime = 0
    if self.allSpecialElement == nil then
        return animData
    end
    for key, value in pairs(self.allSpecialElement) do
        local tempAnimData = {}
        if value.TriggerEffect ~= nil then
            tempAnimData = value:TriggerEffect(self)
            animData.animTime = animData.animTime + tempAnimData.animTime
            if tempAnimData.animTime > 2 then
                LuaDebug.error("703===============" .. value.Type)
            end
        end
        coroutine_runner.wait(tempAnimData.animTime or 0)
    end
    self.allNormalElement = nil
    self.allSpecialElement = nil
    return animData
end




function GridManager:EliminateOnByOne(elements, orginElement)
    if self.eliminateOnByOneCor == nil then
        coroutine_runner.stop(self.eliminateOnByOneCor)
        self.eliminateOnByOneCor = nil
    end
    local singleAnimTime = Match3Const.EliminatedWaitTime / 10
    local func = function()
        local tempElment = {}
        for key, value in pairs(elements) do
            table.insert(tempElment, value)
        end
        local sortFunc = function(data1, data2)
            if data1.Pos.X == data2.Pos.X then
                return data1.Pos.Y < data2.Pos.Y
            end
            return data1.Pos.X > data2.Pos.X
        end
        if orginElement.Type == Match3Const.ElementType.Horizontal or orginElement.Type == Match3Const.ElementType.Vertical then
            table.sort(elements, sortFunc)
        end
        for i = 1, #elements do
            local element = elements[i]
            local cell = self.elementFactory:GetElementCellByPos(element.Pos)
            if cell and orginElement ~= nil and orginElement.IsSpecial and orginElement.Type ~= Match3Const.ElementType.SuperColorBall then
                cell:SetTempIconByType(orginElement.Type)
            end
            self:EliminateElement(element.Pos)
            coroutine_runner.wait(singleAnimTime)
            local cellData = {}
            cellData.cell = cell
            cellData.element = element
            local key = element.Pos:ToString()
            self.grid[key] = nil
            LuaMgr.InvokeUIEventListeners(UIEventConst.RecycleElementView, cellData)
        end
    end
    self.eliminateOnByOneCor = coroutine_runner.start(func)
    local maxAnimTime = #elements * singleAnimTime
    return maxAnimTime + 0.2
end




function GridManager:EliminateSameTime(elements, orginElement, newGenElements)
    if self.eliminateSameTimeCor == nil then
        coroutine_runner.stop(self.eliminateSameTimeCor)
        self.eliminateSameTimeCor = nil
    end

    local singleAnimTime = Match3Const.EliminatedWaitTime
    local maxAnimTime = singleAnimTime
    maxAnimTime = maxAnimTime + 0.02
    if orginElement ~= nil then
        if orginElement.Type == Match3Const.ElementType.ColorBall then
            maxAnimTime = maxAnimTime + singleAnimTime
        elseif orginElement.Type == Match3Const.ElementType.SuperColorBall then
            maxAnimTime = maxAnimTime + Match3Const.SuperColorBallTime
        end
    end
    local func = function()
        local tempElment = {}
        for key, value in pairs(elements) do
            table.insert(tempElment, value)
        end
        local sortFunc = function(data1, data2)
            if data1.Pos.X == data2.Pos.X then
                return data1.Pos.Y < data2.Pos.Y
            end
            return data1.Pos.X > data2.Pos.X
        end
        table.sort(elements, sortFunc)
        if orginElement ~= nil then
            if orginElement.Type == Match3Const.ElementType.ColorBall then
                for i = 1, #elements do
                    local element = elements[i]
                    local cell = self.elementFactory:GetElementCellByPos(element.Pos)
                    if cell ~= nil and element:IsNormalElement() == true then
                        cell:SetTempType(orginElement.Type)
                    end
                end
                coroutine_runner.wait(singleAnimTime)
            elseif orginElement.Type == Match3Const.ElementType.SuperColorBall then
                local during = math.max(singleAnimTime, Match3Const.SuperColorBallTime - 1)
                local endPos = GridPosition.New(4.5, 4.5)
                for i = 1, #elements do
                    local element = elements[i]
                    local cell = self.elementFactory:GetElementCellByPos(element.Pos)
                    if cell ~= nil and element.Id ~= orginElement.Id then
                        cell:PlayEliminateAnimationMove(endPos, during)
                    end
                end
                LuaMgr.InvokeUIEventListeners(UIEventConst.SuperColorBallTriggered, true)
                coroutine_runner.wait(Match3Const.SuperColorBallTime)
                orginElement:UpdateScore(#elements)
            end
        end

        for i = 1, #elements do
            local element = elements[i]
            self:EliminateElement(element.Pos)
        end
        Match3Const.PlaySound(Match3Const.AudioNameIndex.EliminatePop)
        coroutine_runner.wait(singleAnimTime)
        LuaMgr.InvokeUIEventListeners(UIEventConst.SuperColorBallTriggered, false)

        for i = 1, #elements do
            local element = elements[i]
            local posKey = element.Pos:ToString()
            local cell = self.elementFactory:GetElementCellByPos(element.Pos)
            local cellData = {}
            cellData.cell = cell
            cellData.element = element
            self.grid[posKey] = nil
            LuaMgr.InvokeUIEventListeners(UIEventConst.RecycleElementView, cellData)
        end


        if newGenElements ~= nil then
            for key, value in pairs(newGenElements) do
                local genElementType = value.genElementType
                local pos = value.pos
                local newCell = self:CreateElement(genElementType, pos, false)
                local key = pos:ToString()
                self.grid[key] = newCell.CurrentElement
                self.elementFactory:CacheCellByPosKey(value.pos, newCell)
            end
            self:PrintAllGridStatus("807==================")
            coroutine_runner.wait(0.02)
        else
            coroutine_runner.wait(0.02)
        end
    end
    self.eliminateSameTimeCor = coroutine_runner.start(func)
    return maxAnimTime
end

function GridManager:IsInitialEmpty(pos)
    local key = pos:ToString()
    for _, initialKey in pairs(self.initialEmptyPositions) do
        if initialKey == key then
            return true
        end
    end
    return false
end



function GridManager:GetMostNormalElementType()
    local typeCounts = {}
    local maxCount = 0

    local mostCommonType = Match3Const.ElementType.None
    for _, element in pairs(self.grid) do
        if element:IsNormalElement() then
            typeCounts[element.Type] = (typeCounts[element.Type] or 0) + 1
            if typeCounts[element.Type] > maxCount then
                maxCount = typeCounts[element.Type]
                mostCommonType = element.Type
            end
        end
    end
    return mostCommonType
end



function GridManager:FillEmptySpaces()

    local allWoodenBoxDic = {}

    local allDefaultEmptyDic = {}

    local allEmptyDic = {}

    local noneEmptyDic = {}

    local noneDefaultEmptyDic = {}

    for x = 1, self.width do
        local colWoodenBox = nil
        local colNoneEmptyGird = {}
        local colEmptyGrids = {}
        local colNoneDefaultEmpty = {}
        local defaultEmptyGrid = {}
        for y = 1, self.height do
            local pos = GridPosition.New(x, y)
            local element = self:GetElementAt(pos)
            if element ~= nil and element.Type == Match3Const.ElementType.WoodenBox then
                if colWoodenBox == nil then
                    colWoodenBox = {}
                end
                table.insert(colWoodenBox, #colWoodenBox + 1, element)
            elseif self:IsInitialEmpty(pos) == true then
                table.insert(defaultEmptyGrid, #defaultEmptyGrid + 1, pos)
            elseif element ~= nil then
                table.insert(colNoneEmptyGird, #colNoneEmptyGird + 1, element)
            elseif element == nil then
                table.insert(colEmptyGrids, #colEmptyGrids + 1, pos)
            end
            if self:IsInitialEmpty(pos) == false then
                table.insert(colNoneDefaultEmpty, #colNoneDefaultEmpty + 1, pos)
            end
        end

        allWoodenBoxDic[x] = colWoodenBox
        if #defaultEmptyGrid == Match3Const.StandardLine then
            allDefaultEmptyDic[x] = defaultEmptyGrid
        else

            if #colNoneEmptyGird > 0 then
                noneEmptyDic[x] = colNoneEmptyGird
            end
            if #colEmptyGrids > 0 then
                allEmptyDic[x] = colEmptyGrids
            end
        end

        if #colNoneDefaultEmpty > 0 then
            table.sort(colNoneDefaultEmpty, GridManager.SortByPosY)
            noneDefaultEmptyDic[x] = colNoneDefaultEmpty
        end
    end


    local sortCellFunc = function(data1, data2)
        return data1.CurrentElement.Pos.Y > data2.CurrentElement.Pos.Y
    end

    self.curRoundMaxAnimTime = 0
    for x = 1, self.width do
        local fallQueue = {}

        if allDefaultEmptyDic[x] == nil and allEmptyDic[x] ~= nil then
            local colNoneDefaultEmpty = noneDefaultEmptyDic[x]
            local bornPointY = self.elementBornPoints[x][1].Y
            if allWoodenBoxDic[x] ~= nil then


                local colAllWoodenBox = allWoodenBoxDic[x]
                local firstWoodenBox = table.remove(colAllWoodenBox, 1)
                local upperIndex = -1
                local lowwerIndex = firstWoodenBox.Pos.Y - 1
                local curWoodenBox = firstWoodenBox
                local isBreak = false
                while true do

                    local allTempCells = {}
                    local startY = upperIndex + 1
                    local endY = lowwerIndex
                    if endY > startY then
                        for y = startY, endY, 1 do
                            local pos = GridPosition.New(x, y)
                            local cell = self.elementFactory:GetElementCellByPos(pos)
                            if cell ~= nil then
                                if cell.CurrentElement ~= nil and cell.CurrentElement.Type ~= Match3Const.ElementType.WoodenBox then
                                    table.insert(allTempCells, #allTempCells + 1, cell)
                                end
                            elseif self:IsInitialEmpty(pos) == false and y < firstWoodenBox.Pos.Y then
                                local bornPos = GridPosition.New(x, bornPointY)
                                local cell = self:CreateElement(self:GetRandomNormalElementType(), bornPos)
                                cell:UpdatePosition()
                                table.insert(allTempCells, #allTempCells + 1, cell)
                                bornPointY = bornPointY - 1
                            end
                        end
                        if #allTempCells > 0 then
                            table.sort(allTempCells, sortCellFunc)
                            local initY = endY
                            for i = 1, #allTempCells do
                                local cell = allTempCells[i]
                                local data = {}
                                data.element = cell.CurrentElement
                                data.targetPos = GridPosition.New(x, initY)
                                table.insert(fallQueue, #fallQueue + 1, data)
                                initY = initY - 1
                            end
                        end
                    end
                    if #colAllWoodenBox > 0 then
                        upperIndex = endY
                        curWoodenBox = table.remove(colAllWoodenBox, 1)
                        lowwerIndex = curWoodenBox.Pos.Y - 1
                    elseif isBreak == false then
                        lowwerIndex = colNoneDefaultEmpty[#colNoneDefaultEmpty].Y
                        upperIndex = endY + 1
                        isBreak = true
                    elseif isBreak == true then
                        break
                    end
                end
            else

                local colNoneEmptyGrid = noneEmptyDic[x] or {}

                for i = #colNoneDefaultEmpty, 1, -1 do
                    local y = colNoneDefaultEmpty[i].Y

                    local element = table.remove(colNoneEmptyGrid, #colNoneEmptyGrid)
                    if element ~= nil then
                        if element.Pos.Y <= y then
                            local data = {}
                            data.element = element
                            data.targetPos = GridPosition.New(x, y)
                            data.isNew = false
                            table.insert(fallQueue, #fallQueue + 1, data)
                        end
                    else
                        local bornPos = GridPosition.New(x, bornPointY)
                        local cell = self:CreateElement(self:GetRandomNormalElementType(), bornPos)
                        cell:UpdatePosition()
                        local data = {}
                        data.element = cell.CurrentElement
                        data.targetPos = GridPosition.New(x, y)
                        data.isNew = true
                        table.insert(fallQueue, #fallQueue + 1, data)
                        bornPointY = bornPointY - 1
                    end
                end
            end
        end
        while true do
            if #fallQueue == 0 then
                break
            end
            local data = table.remove(fallQueue, 1)

            local element = data.element

            local targetPos = data.targetPos

            local originalPos = element.Pos:Clone()

            local animData = {}
            animData.element = element
            animData.fromPos = originalPos
            animData.toPos = targetPos
            animData.duration = Match3Const.FallSpeed * (math.abs(targetPos.Y - originalPos.Y))
            self.curRoundMaxAnimTime = math.max(self.curRoundMaxAnimTime, animData.duration)
            LuaMgr.InvokeUIEventListeners(UIEventConst.ElementFall, animData)
        end
    end
    return self.curRoundMaxAnimTime
end

function GridManager:FliterDirtyGrid()
    local positionSet = {}
    local normalPositions = {}
    local duplicationElement = {}
    for key, element in pairs(self.grid) do
        if element.Pos ~= nil and (element:IsNormalElement() or element.IsSpecial == true) then
            local posKey = element.Pos:ToString()
            if not positionSet[posKey] and key == posKey then
                table.insert(normalPositions, element.Pos:Clone())
                positionSet[posKey] = true
            else
                table.insert(duplicationElement, key)
            end
        end
    end
    for key, value in pairs(duplicationElement) do
        self.grid[value] = nil
    end
end

function GridManager:FliterDirtyCell()
    local posKeys = {}
    local allCell = self.elementFactory:GetCacheCellMap()
    for key, value in pairs(allCell) do
        table.insert(posKeys, key)
    end
    for key, value in pairs(posKeys) do
        local x, y = self:ParseGridKey(value)
        local pos = GridPosition.New(x, y)
        local cell = self.elementFactory:GetElementCellByPos(pos)
        if cell ~= nil and cell.CurrentElement == nil then
            self.elementFactory:CacheCellByPosKey(pos, nil)
        end
    end
end







function GridManager.SortByPosYDescend(data1, data2)
    if data1.Y == nil and data1.Pos ~= nil then
        return data1.Pos.Y > data2.Pos.Y
    end
    return data1.Y > data2.Y
end




function GridManager.SortByPosY(data1, data2)
    if data1.Y == nil and data1.Pos ~= nil then
        return data1.Pos.Y < data2.Pos.Y
    end
    return data1.Y < data2.Y
end




function GridManager.SortByPosXDescend(data1, data2)
    if data1.X == nil and data1.Pos ~= nil then
        return data1.Pos.X > data2.Pos.X
    end
    return data1.X > data2.X
end




function GridManager.SortByPosX(data1, data2)
    if data1.Y == nil and data1.Pos ~= nil then
        return data1.Pos.X < data2.Pos.X
    end
    return data1.X < data2.X
end







function GridManager:CalGenNormalElementWeight()
    self.normalElementWeight = 0
    for _, item in ipairs(self.passData.config.Typelimit) do
        self.normalElementWeight = self.normalElementWeight + (item[2] or 0)
    end
end

function GridManager:GetRandomNormalElementType()
    local randomValue = math.random(self.normalElementWeight)
    local current = 0
    local typeLimitConfig = self.passData.config.Typelimit
    for _, item in ipairs(typeLimitConfig) do
        current = current + (item[2] or 0)
        if randomValue <= current then
            return item[1]
        end
    end
    return typeLimitConfig[#typeLimitConfig][1]
end

function GridManager:CalGenSpecialElementWeight()
    self.specialElementWeight = 0
    local config = ConfigMgr.Config.constants.EliminateWeight
    for _, item in ipairs(config) do
        self.specialElementWeight = self.specialElementWeight + (tonumber(item[2]) or 0)
    end
end

function GridManager:GetRandomSpecialElementType()
    local randomValue = math.random(self.specialElementWeight)
    local current = 0
    local typeLimitConfig = ConfigMgr.Config.constants.EliminateWeight
    local goalType = nil
    for _, item in ipairs(typeLimitConfig) do
        current = current + (tonumber(item[2]) or 0)
        if randomValue <= current then
            goalType = tonumber(item[1])
            break
        end
    end
    if goalType == nil then
        goalType = tonumber(typeLimitConfig[#typeLimitConfig][1])
    end
    if goalType == Match3Const.ElementType.Horizontal then
        local ramdom = math.random(1, 10)
        if ramdom <= 5 then
            goalType = Match3Const.ElementType.Vertical
        end
    end
    return goalType
end




function table.deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[table.deepcopy(orig_key, copies)] = table.deepcopy(orig_value, copies)
            end
setmetatable(copy, table.deepcopy(getmetatable(orig), copies))
        end
else
        copy = orig
    end
    return copy
end

function GridManager:ReshuffleGrid()

local validElements = {}
local positionSet = {}


    for key, element in pairs(self.grid) do
        if element.Pos ~= nil and (element:IsNormalElement() or element.IsSpecial) then
            local posKey = element.Pos:ToString()

            if not positionSet[posKey] then
                table.insert(validElements, element)
                positionSet[posKey] = true
            else

                self.grid[key] = nil
            end
        end
    end


    local allValidPositions = {}

    local allWoodenBox = {}
    for x = 1, self.width do
        for y = 1, self.height do
            local pos = GridPosition.New(x, y)
            local element = self:GetElementAt(pos)
            if not self:IsInitialEmpty(pos) and (element ~= nil and element.Type ~= Match3Const.ElementType.WoodenBox) then
                table.insert(allValidPositions, pos)
            elseif element ~= nil and element.Type == Match3Const.ElementType.WoodenBox then
                allWoodenBox[pos:ToString()] = element
            end
        end
    end


    if #validElements ~= #allValidPositions then
        LuaDebug.error(string.format("元素数量（%d）与有效位置数量（%d）不匹配，无法重排", #validElements, #allValidPositions))
        return
    end


self:ShuffleTable(validElements)
self:ShuffleTable(allValidPositions)

    self.elementFactory:RecycleAllValidCell()
self.grid = {}

    for i = 1, #allValidPositions do
        local element = validElements[i]
        local newPos = allValidPositions[i]
        local newPosKey = newPos:ToString()
        element:UpdatePosition(newPos:Clone())
        self.grid[newPosKey] = element
        local cell = self.elementFactory:GetElementView(element.Type, element.IsIce)
        cell:SetElement(element)
        cell:SetVisible(true)
    end
    for key, element in pairs(allWoodenBox) do
        self.grid[key] = element
        local cell = self.elementFactory:GetElementView(element.Type, element.IsIce)
        cell:SetElement(element)
        cell:SetVisible(true)
    end
end


function GridManager:ShuffleTable(t)
    for i = #t, 2, -1 do
        local j = math.random(1, i)
        t[i], t[j] = t[j], t[i]
    end
end


function GridManager:ClearGrid()

    local allPositions = {}
    for key, _ in pairs(self.grid) do
        local x, y = self:ParseGridKey(key)
        table.insert(allPositions, GridPosition.New(x, y))
    end
    self.grid = {}
end




function GridManager:ParseGridKey(key)
    local x, y = string.match(key, "(%d+),(%d+)")
    local xInt = tonumber(x) or -1
    local yInt = tonumber(y) or -1
    return xInt, yInt
end


function GridManager:GetWidth()
    return self.width
end


function GridManager:GetHeight()
    return self.height
end

function GridManager:GetGridRectTransform()
    return self.gridTransform
end

function GridManager:RemoveUIEvent()
    if self.eliminateOnByOneCor == nil then
        coroutine_runner.stop(self.eliminateOnByOneCor)
        self.eliminateOnByOneCor = nil
    end
    LuaMgr.RemoveUIEventListener(UIEventConst.ElementPositionChanged, self.onPositionChanged)
    LuaMgr.RemoveUIEventListener(UIEventConst.SingElementFallEnd, self.onPositionChangedEnd)
end

function GridManager:Destroy()
    self:RemoveUIEvent()
end


function GridManager:PrintAllGridStatus(title)
    if true then
        return
    end
local posWidth = 5
local initWidth = 5
local elemWidth = 4
local cellWidth = 4

    local str = ""
    for y = 1, self.height do
        local tempStr = ""
        for x = 1, self.width do
            local pos = GridPosition.New(x, y)
            local isInitEmpty = self:IsInitialEmpty(pos)
            local element = self:GetElementAt(pos)
            local elementType = "____"
            local cellType = "____"

            if element ~= nil then
                elementType = tostring(element.Type)
                local cell = self.elementFactory:GetElementCellByPos(pos)
                if cell ~= nil and cell.CurrentElement ~= nil then
                    cellType = tostring(cell.CurrentElement.Type)
                else
                    cellType = pos:ToString()
                end
            end
            local cellStr = string.format("%-" .. posWidth .. "s|%-" .. initWidth .. "s|%-" .. elemWidth .. "s|%-" .. cellWidth .. "s", pos:ToString(), tostring(isInitEmpty), elementType, cellType)
            tempStr = tempStr .. (x > 1 and "  " or "") .. cellStr
        end
        str = str .. (y > 1 and "\n" or "") .. tempStr
    end

    local time = LuaMgr.Timestamp()
    local date = os.date("%m/%d %H:%M:%S", time)
    LuaDebug.warn(string.format("Match3-%s-%s:\n%s", date, title, str))
end

