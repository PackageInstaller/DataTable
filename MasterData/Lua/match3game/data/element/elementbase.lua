










ElementBase = {}
ElementBase.__index = ElementBase




function ElementBase.New(elementType, pos, isIce)

    local obj = setmetatable({}, ElementBase)
    obj.Id = Match3Const.GeneralUID()
    obj.Type = elementType
    obj.Pos = pos:Clone()
    obj.TempPos = pos
    obj.IsObstacle = elementType == Match3Const.ElementType.WoodenBox
    obj.IsIce = isIce
    obj.IsSpecial = elementType >= Match3Const.ElementType.Horizontal and elementType <= Match3Const.ElementType.SuperColorBall and obj.IsObstacle == false
    obj.IsEffectTriggered = false
    obj.Healthy = isIce == true and 2 or 0
    return obj
end



function ElementBase:UpdatePosition(newPos)
    self.Pos = newPos:Clone()
end

function ElementBase:SetTempPos(newPos)
    self.TempPos = newPos:Clone()
end

function ElementBase:AddHealty(num)
    self.Healthy = self.Healthy + num
end

function ElementBase:ResetTempPos()
    self.TempPos = self.Pos
end



function ElementBase:IsNormalElement()
    return self.Type >= Match3Const.ElementType.Normal1 and self.Type <= Match3Const.ElementType.Normal5
end

function ElementBase:GetID()
    return self.Id
end


function ElementBase:SetType(elementType)
    self.Type = elementType

    self.Id = Match3Const.GeneralUID()
end


function ElementBase:GetScore()
    if self.Type < Match3Const.ElementType.Normal1 or self.Type > Match3Const.ElementType.Normal5 then
        return 0
    end
    return ConfigMgr.Config.constants.EliminateBaseCredit
end

function ElementBase:IsInGrid()
    local pos = self.Pos
    if pos.X <= 0 or pos.X > Match3Const.StandardLine or pos.Y <= 0 or pos.Y > Match3Const.StandardLine then
        return false
    end
    return true
end

function ElementBase:SetAnimTime(animData, maxAnimTime)
    if animData == nil then
        return maxAnimTime
    end
    if animData.animTimeType == Match3Const.AnimTimeCalType.Max then
        maxAnimTime = math.max(maxAnimTime, animData.animTime)
    elseif animData.animTimeType == Match3Const.AnimTimeCalType.Sum then
        maxAnimTime = maxAnimTime + animData.animTime
    end
    return maxAnimTime
end

function ElementBase:UpdateScore(elementNum)
    local scoreData = {}
    scoreData.eliminateNum = elementNum
    scoreData.specialType = self.Type
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ScoreUpdate, scoreData)
end