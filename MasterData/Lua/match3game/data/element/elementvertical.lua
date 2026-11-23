
ElementVertical = {}
ElementVertical.__index = ElementVertical
setmetatable(ElementVertical, {__index = ElementBase})

function ElementVertical.New(type, pos)

    local self = ElementBase.New(type, pos)
    setmetatable(self, ElementVertical)
    return self
end



function ElementVertical:TriggerEffect(gridManager, other)
    local maxAnimTime = 0
    if self.IsEffectTriggered then
        local animData = {}
        animData.animTimeType = Match3Const.AnimTimeCalType.Max
        animData.animTime = 0
        return animData
    end
    self.removeDuplicateDatas = {}
    if other ~= nil then
        if other.IsSpecial == true then
            if other.Type == self.Type then
                local animData, newElement = gridManager:CreateElementDataByElement(self.Pos, Match3Const.ElementType.Horizontal)
                maxAnimTime = self:SetAnimTime(animData, maxAnimTime)
                if newElement then
                    animData = newElement:TriggerEffect(gridManager)
                    maxAnimTime = self:SetAnimTime(animData, maxAnimTime)
                end
            else
                local animData = other:TriggerEffect(gridManager)
                maxAnimTime = self:SetAnimTime(animData, maxAnimTime)
            end
        end
    end
    self.IsEffectTriggered = true
    local needElimateElement = self:GetNeedElimateElement(gridManager)
    local animTime = gridManager:EliminateOnByOne(needElimateElement, self)
    self:UpdateScore(NumTool.GetLen(self.removeDuplicateDatas) + 1)

    local data = {
        centerPos = self.Pos
    }
    LuaMgr.InvokeUIEventListeners(UIEventConst.VerticalTriggered, data)
    local animData = {}
    animData.animTimeType = Match3Const.AnimTimeCalType.Max
    animData.animTime = animTime
    return animData
end

function ElementVertical:GetNeedElimateElement(gridManager)
    local centerY = self.Pos.Y
    local targetX = self.Pos.X
    local gridHeight = gridManager:GetHeight()
    local needElimateElement = {}
    for y = centerY - 1, 1, -1 do
        local currentPos = GridPosition.New(targetX, y)
        local element = gridManager:GetElementAt(currentPos)
        if element ~= nil and element.Type ~= Match3Const.ElementType.WoodenBox then
            self.removeDuplicateDatas[currentPos:ToString()] = true
        end
        if element ~= nil then
            table.insert(needElimateElement, element)
        end
    end

    for y = centerY + 1, gridHeight do
        local currentPos = GridPosition.New(targetX, y)
        local element = gridManager:GetElementAt(currentPos)
        if element ~= nil and element.Type ~= Match3Const.ElementType.WoodenBox then
            self.removeDuplicateDatas[currentPos:ToString()] = true
        end
        if element ~= nil then
            table.insert(needElimateElement, element)
        end
    end
    table.insert(needElimateElement, self)
    return needElimateElement
end