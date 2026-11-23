








Match3InputHandler = {}
Match3InputHandler.__index = Match3InputHandler

local objs = {
    onDragEvent = {path = "", type = UITool.OnDragEvent}
}

function Match3InputHandler.New(gridManager)

    local self = {}
    setmetatable(self, Match3InputHandler)
    self.gridManager = gridManager
    self.cellSize = Match3Const.CellSize
    self.isDragging = false
    self.isUsingProp = false
    self.startPos = nil
    local gridTrans = self.gridManager:GetGridRectTransform()
    if IsNull(gridTrans) == false then
        self.gridTransRect = gridTrans:GetComponent(UITool.RectTransform)
    end
    UITool.Parse(self.gridTransRect, self, objs)
    self:InitInputEvents()
    return self
end


function Match3InputHandler:InitInputEvents()
    self.onComboIncreased = function(param)
        self.IsComboing = true
    end

    self.onComboEnded = function(param)
        self.IsComboing = false
    end

    self.onPreUseProp = function(param)
        local data = param[0]
        if data.isActive == true then
            self.preUsePropType = data.propType
        end
        self.isUsingProp = data.isActive
    end
    self.operateLimitChange = function(params)
        self.isLimitOpeate = params[0]
        if self.isLimitOpeate == false then
            self.isDragging = false
        end
    end
    LuaMgr.AddUIEventListener(UIEventConst.PropPreUseStateChanged, self.onPreUseProp)
    LuaMgr.AddUIEventListener(UIEventConst.Match3ComboIncreased, self.onComboIncreased)
    LuaMgr.AddUIEventListener(UIEventConst.Match3ComboEnded, self.onComboEnded)
    LuaMgr.AddUIEventListener(UIEventConst.Match3OperateLimitChange, self.operateLimitChange)
    local onPointerDown = function(index, eventData)
        self:OnPointerDown(RaycastTool.GetMousePosition())
    end
    local onPointerUp = function(eventData)
        self:OnPointerUp(RaycastTool.GetMousePosition())
    end
    local onBeginDrag = function(eventData)
        self:OnBeginDrag(RaycastTool.GetMousePosition())
    end
    local onDrag = function(eventData)
        self:OnDrag(RaycastTool.GetMousePosition())
    end
    local onEndDrag = function(eventData)
        self:OnDragEnd(RaycastTool.GetMousePosition())
    end
    self.onDragEvent:SetData(1, onPointerDown, onDrag, onPointerUp)
    self.onDragEvent:SetDragData(onBeginDrag, onEndDrag)
end




function Match3InputHandler:ScreenToGridPosition(screenPos)
    local localPos = RectTool.Screen2Local(Vector2(screenPos.x, screenPos.y), self.gridTransRect).pos
    local gridSize = self.gridTransRect.sizeDelta
    local gridWidth = gridSize.x
    local gridHeight = gridSize.y
    local adjustedX = localPos.x + gridWidth / 2
    local adjustedY = gridHeight / 2 - localPos.y
    local x, y = self:GetGridPosIndexByPos(adjustedX, adjustedY)
    return GridPosition.New(x, y)
end

function Match3InputHandler:GetGridPosIndexByPos(adjustedX, adjustedY)
    if not self.sizePosMap then
        self.sizePosMap = {}
        for i = 0, Match3Const.StandardLine do
            self.sizePosMap[i] = i * self.cellSize
        end
    end
    local gridPosX, gridPosY = -1, -1
    local maxGridIndex = Match3Const.StandardLine
    for i = 0, maxGridIndex - 1 do
        local start = self.sizePosMap[i]
        local endVal = self.sizePosMap[i + 1]
        if adjustedX >= start and adjustedX < endVal then
            gridPosX = i + 1
        end
        if adjustedY >= start and adjustedY < endVal then
            gridPosY = i + 1
        end
    end
    if adjustedX >= self.sizePosMap[maxGridIndex] then
        gridPosX = maxGridIndex
    end
    if adjustedY >= self.sizePosMap[maxGridIndex] then
        gridPosY = maxGridIndex
    end
    gridPosX = math.max(1, math.min(gridPosX, maxGridIndex))
    gridPosY = math.max(1, math.min(gridPosY, maxGridIndex))
    return gridPosX, gridPosY
end

function Match3InputHandler:OnPointerDown(screenPos)
end

function Match3InputHandler:OnPointerUp(screenPos)
    if self.isLimitOpeate == true then
        return
    end

    if self.validDrag == false then
        self.startPos = nil
        self.isDragging = false
    end
    if self.isUsingProp == false then
        return
    end
    local gridPos = self:ScreenToGridPosition(screenPos)
    if self.preUsePropType == Match3Const.PropType.Eliminate then
        Match3Const.PlaySound(Match3Const.AudioNameIndex.EliminateSelect)
        local data = {}
        data.startPos = gridPos
        LuaMgr.InvokeUIEventListeners(UIEventConst.UseEliminateProp, data)
        self.preUsePropType = nil
        return
    elseif self.preUsePropType == Match3Const.PropType.Swap then
        Match3Const.PlaySound(Match3Const.AudioNameIndex.EliminateSelect)
        if self.startPos == nil then
            local element1 = self.gridManager:GetElementAt(gridPos)
            if element1 == nil then
                return
            end
            self.startPos = gridPos
            return
        elseif self.startPos:ToString() == gridPos:ToString() then
            self.startPos = nil
            return
        end
        local data = {}
        data.startPos = gridPos
        data.endPos = gridPos
        LuaMgr.InvokeUIEventListeners(UIEventConst.UseSwapProp, data)
        self.gridManager:ForceSwap(self.startPos, gridPos)
        self:OnSwapElementSucc(gridPos, 0, true)
        self.startPos = nil
    end
end

function Match3InputHandler:OnBeginDrag(screenPos)
    self.validDrag = false
    if self.isLimitOpeate == true then
        return
    end
    if self.isDragging == true or self.isUsingProp == true then
        return
    end
    if self.IsComboing then
        return
    end
    local gridPos = self:ScreenToGridPosition(screenPos)
    local element = self.gridManager:GetElementAt(gridPos)
    if element then
        self.isDragging = true
        self.startPos = gridPos
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ElementClick, gridPos)
    end
end

function Match3InputHandler:OnDrag(screenPos)
    if self.isLimitOpeate == true then
        return
    end
    if self.IsComboing or self.isUsingProp == true then
        return
    end
    if not self.isDragging or not self.startPos then
        return
    end
    local currentPos = self:ScreenToGridPosition(screenPos)

    if self.gridManager:ArePositionsAdjacent(self.startPos, currentPos) then
        self:OnDragEnd(screenPos)
        self.validDrag = true
    end
end

function Match3InputHandler:OnDragEnd(screenPos)

    if self.isLimitOpeate == true then
        return
    end
    if self.IsComboing or self.isUsingProp == true then
        return
    end
    if not self.isDragging or not self.startPos then
        return
    end
    local endPos = self:ScreenToGridPosition(screenPos)

    if self.gridManager:ArePositionsAdjacent(self.startPos, endPos) then
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ElementDragEnd, self.startPos, endPos)

        local swapped, animTime = self.gridManager:SwapElements(self.startPos, endPos)
        if swapped then
            self:OnSwapElementSucc(endPos, animTime)
        else
            Match3Const.PlaySound(Match3Const.AudioNameIndex.EliminateSwapFail)
            local callback = function()
                self.isDragging = false
            end
            self.tweenSequenceReset = DOTWeen:Sequence()
            self.tweenSequenceReset:AppendInterval(animTime):OnComplete(callback)
        end
    else
        self.isDragging = false
    end
    self.startPos = nil
end

function Match3InputHandler:OnSwapElementSucc(endPos, animTime, isUseProp)
    local func = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ComboStepStatus, Match3Const.ComboStatus.Start)
        local maxAnimTime, eliminateNum = 0, 0
        if isUseProp ~= true then
            maxAnimTime, eliminateNum = self:EliminateBaseElement(endPos)
        end
        coroutine_runner.wait(maxAnimTime + 0.1)
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ComboIncreased, 0)
        local data = {}
        data.usePropType = self.preUsePropType
        LuaMgr.InvokeUIEventListeners(UIEventConst.ElementsEliminated, data)

        coroutine_runner.wait(animTime)
        self.isDragging = false
        self.isUsingProp = false
        self.preUsePropType = nil
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ComboStepStatus, Match3Const.ComboStatus.End)
    end
    if self.swapElementSuccCoroutine ~= nil then
        coroutine_runner.stop(self.swapElementSuccCoroutine)
        self.swapElementSuccCoroutine = nil
    end
    self.swapElementSuccCoroutine = coroutine_runner.start(func)
end

function Match3InputHandler:EliminateBaseElement(endPos)
    if self.startPos == nil then
        return 0, 0
    end
    local doubleSpecial, animData, singleElementType = self:EliminateSpecialElement(endPos)
    if doubleSpecial then
        return animData and animData.animTime or 0, 0
    end
    if singleElementType == Match3Const.ElementType.ColorBall or singleElementType == Match3Const.ElementType.SuperColorBall then
        return animData and animData.animTime or 0, 0
    end
    local matches1 = self.gridManager:FindMatchesAtPosition(self.startPos)
    local matches2 = self.gridManager:FindMatchesAtPosition(endPos)


    local elementsToEliminate = {}
    local elementIds = {}
    for _, element in ipairs(matches1) do
        if not elementIds[element.Id] then
            elementIds[element.Id] = true
            table.insert(elementsToEliminate, element)
        end
    end
    for _, element in ipairs(matches2) do
        if not elementIds[element.Id] then
            elementIds[element.Id] = true
            table.insert(elementsToEliminate, element)
        end
    end

    local maxAnimTime = 0
    if animData ~= nil then
        if animData.animTimeType == Match3Const.AnimTimeCalType.Max then
            maxAnimTime = math.max(maxAnimTime, animData.animTime)
        elseif animData.animTimeType == Match3Const.AnimTimeCalType.Sum then
            maxAnimTime = maxAnimTime + animData.animTime
        end
    end
    local startPosSpecialType = self.gridManager:GetSpecialTypeByMatch(matches1)
    local endPosSpecialType = self.gridManager:GetSpecialTypeByMatch(matches2)

    local removeDuplicateDatas = {}
    local specialElementDatas = {}
    local needScoreElements = {}
    for _, element in ipairs(elementsToEliminate) do
        local specialElementData = nil
        local pos = element.Pos
        local posStr = pos:ToString()
        if posStr == self.startPos:ToString() and startPosSpecialType ~= Match3Const.ElementType.None then
            specialElementData = {}
            specialElementData.genElementType = startPosSpecialType
            specialElementData.pos = pos
            table.insert(specialElementDatas, specialElementData)
        elseif posStr == endPos:ToString() and endPosSpecialType ~= Match3Const.ElementType.None then
            specialElementData = {}
            specialElementData.genElementType = endPosSpecialType
            specialElementData.pos = pos
            table.insert(specialElementDatas, specialElementData)
        end
        if element.Type ~= Match3Const.ElementType.WoodenBox then
            table.insert(needScoreElements, element)
        end
        if animData ~= nil then
            removeDuplicateDatas[posStr] = true
        end
    end

    local maxAnimTime = self.gridManager:EliminateSameTime(elementsToEliminate, nil, specialElementDatas)
    local scoreData = {}
    scoreData.eliminateNum = #needScoreElements
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ScoreUpdate, scoreData)
    return maxAnimTime, NumTool.GetLen(removeDuplicateDatas)
end

function Match3InputHandler:EliminateSpecialElement(endPos)
    local elementStart = self.gridManager:GetElementAt(self.startPos)
    local elementEnd = self.gridManager:GetElementAt(endPos)
    if elementEnd ~= nil and elementEnd.IsSpecial == false and elementStart ~= nil and elementStart.IsSpecial == false then

        return false, nil
    elseif elementEnd ~= nil and elementEnd.IsSpecial == false and elementStart ~= nil and elementStart.IsSpecial == true then

        local animData = elementStart:TriggerEffect(self.gridManager, elementEnd)
        return false, animData, elementStart.Type
    elseif elementEnd ~= nil and elementEnd.IsSpecial == true and elementStart ~= nil and elementStart.IsSpecial == false then

        local animData = elementEnd:TriggerEffect(self.gridManager, elementStart)
        return false, animData, elementEnd.Type
    elseif elementEnd ~= nil and elementEnd.IsSpecial == true and elementStart ~= nil and elementStart.IsSpecial == true then

        local animData = elementEnd:TriggerEffect(self.gridManager, elementStart)
        return true, animData
    end
    return false
end

function Match3InputHandler:Destroy()
    LuaMgr.RemoveUIEventListener(UIEventConst.PropPreUseStateChanged, self.onPreUseProp)
    LuaMgr.RemoveUIEventListener(UIEventConst.Match3ComboIncreased, self.onComboIncreased)
    LuaMgr.RemoveUIEventListener(UIEventConst.Match3ComboEnded, self.onComboEnded)
    LuaMgr.RemoveUIEventListener(UIEventConst.Match3OperateLimitChange, self.operateLimitChange)
    if self.tweenSequenceReset ~= nil then
        self.tweenSequenceReset:Kill()
    end
    if self.swapElementSuccCoroutine ~= nil then
        coroutine_runner.stop(self.swapElementSuccCoroutine)
        self.swapElementSuccCoroutine = nil
    end
end