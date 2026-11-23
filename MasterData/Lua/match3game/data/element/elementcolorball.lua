
ElementColorBall = {}
ElementColorBall.__index = ElementColorBall
setmetatable(ElementColorBall, {__index = ElementBase})

function ElementColorBall.New(type, pos)
    local self = ElementBase.New(type, pos)
    setmetatable(self, ElementColorBall)
    return self
end




function ElementColorBall:TriggerEffect(gridManager, other)

    local mostType = Match3Const.ElementType.None
    if other ~= nil then
        mostType = other.Type
    else
        mostType = gridManager:GetMostNormalElementType()
    end
    local animData = {}
    animData.animTimeType = Match3Const.AnimTimeCalType.Max
    animData.animTime = 0
    if mostType == Match3Const.ElementType.None then
        return animData
    end
    if self.IsEffectTriggered then
        return animData
    end
    local needElimateElement = {}
    for _, element in pairs(gridManager.grid) do
        if element.Type == mostType and element:IsInGrid() == true then
            if other ~= nil and other.IsSpecial == true then
                self.otherType = other.Type
            end
            table.insert(needElimateElement, element)
        end
    end
    table.insert(needElimateElement, self)
    local animTime = gridManager:EliminateSameTime(needElimateElement, self)
    self:UpdateScore(#needElimateElement)
    LuaMgr.InvokeUIEventListeners(UIEventConst.ColorBallTriggered, self)
    local animData = {}
    animData.animTimeType = Match3Const.AnimTimeCalType.Sum
    animData.animTime = animTime
    return animData
end