
ElementSuperColorBall = {}
ElementSuperColorBall.__index = ElementSuperColorBall
setmetatable(ElementSuperColorBall, {__index = ElementBase})

function ElementSuperColorBall.New(type, pos)

    local self = ElementBase.New(type, pos)
    setmetatable(self, ElementSuperColorBall)
    return self
end




function ElementSuperColorBall:TriggerEffect(gridManager, other)
    local maxAnimTime = 0
    if self.IsEffectTriggered then
        local animData = {}
        animData.animTimeType = Match3Const.AnimTimeCalType.Max
        animData.animTime = 0
        return animData
    end
    self.IsEffectTriggered = true
    local needElimateElement = {}
    for _, element in pairs(gridManager.grid) do
        table.insert(needElimateElement, element)
    end
    local animTime = gridManager:EliminateSameTime(needElimateElement, self)
    local animData = {}
    animData.animTimeType = Match3Const.AnimTimeCalType.Max
    animData.animTime = animTime
    return animData
end