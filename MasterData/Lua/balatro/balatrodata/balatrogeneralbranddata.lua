







require("Balatro/BalatroData/BalatroBrandDataBase")


BalatroGeneralBrandData = setmetatable({}, {__index = BalatroBrandDataBase})
BalatroGeneralBrandData.__index = BalatroGeneralBrandData

function BalatroGeneralBrandData.New(configData, uidExtra)

    local self = BalatroBrandDataBase.New()
    setmetatable(self, BalatroGeneralBrandData)
    self._uidExtra = uidExtra or 0
    self:SetConfig(configData)

    self._IsWeaken = false
    self._turnOver = false
    self._IsUsed = false
    self._IsDestroy = false

    self._ExtraStyle = 0
    self._ScenePoint = 0
    self._UIIndex = 0
    self._ShowType = BalatroUtil.ShowType.Normal
    self._ExtraScore = 0
    self._ExtraRate = 0
    self._ExtraMuliRate = 1
    return self
end

function BalatroGeneralBrandData:GetResName(isHandBrand)
    if isHandBrand == true and self._turnOver == true then
        return "jj_xcp_kb"
    end
    local tempResConf = BalatroGeneralBrandData.GetBrandByCondition(self._Style, self._ShowPoint)
    if tempResConf ~= nil then
        return tempResConf.ResID
    end
    return self._ConfigData.ResID
end


function BalatroGeneralBrandData:Copy(brandData)
    self._Style = brandData._Style
    self._Point = brandData._Point
    self._Name = brandData._Name
    self._ResName = brandData._ResName
    self._ShowPoint = brandData._ShowPoint
    self._IsWeaken = brandData._IsWeaken
    self._turnOver = brandData._turnOver
    self._ExtraStyle = brandData._ExtraStyle
    self._ScenePoint = brandData._ScenePoint
    self._ShowType = brandData._ShowType
    self._ExtraScore = brandData._ExtraScore
    self._ExtraRate = brandData._ExtraRate
    self._ExtraMuliRate = brandData._ExtraMuliRate
end

function BalatroGeneralBrandData:SetConfig(configData)
    self._ConfigData = configData
    self._ID = configData.ID * 1000 + self._uidExtra
    self._Style = configData.Style
    self._Point = configData.RealPoint
    self._Name = configData.StyleName .. configData.PointName
    self._ResName = configData.ResID
    self._ShowPoint = configData.ShowPoint
end

function BalatroGeneralBrandData:GetBaseID()
    return self._ConfigData.ID
end


function BalatroGeneralBrandData:Reset()
    self._Style = self._ConfigData.Style
    self._Point = self._ConfigData.RealPoint
    self._ShowPoint = self._ConfigData.ShowPoint
    self._ScenePoint = 0
    self._turnOver = false
    self._IsWeaken = false
    self._ExtraStyle = 0
    self._ShowType = BalatroUtil.ShowType.Normal
    self._ExtraScore = 0
    self._ExtraRate = 0
    self._ExtraMuliRate = 1
    self._IsDestroy = false
end

function BalatroGeneralBrandData:GetShowPoint()
    return self._ShowPoint
end

function BalatroGeneralBrandData:SetIndex(index)
    self._UIIndex = index
end

function BalatroGeneralBrandData:GetIndex()
    return self._UIIndex
end


function BalatroGeneralBrandData:SetTempShowPoint(point)
    self._ShowPoint = point
    self._Point = BalatroGeneralBrandData.GetBrandByCondition(self._Style, self._ShowPoint).RealPoint
end

function BalatroGeneralBrandData:SetScenePoint(point)
    self._ScenePoint = point
end


function BalatroGeneralBrandData:SetTempStyle(style)
    self._Style = style
end


function BalatroGeneralBrandData:SetExtraStyle(style)
    self._ExtraStyle = style
end


function BalatroGeneralBrandData:CheckStyle(style)
    if style == 0 or style == nil then
        return false
    end
    if style == self._Style or style == self._ExtraStyle then
        return true
    end
    return false
end


function BalatroGeneralBrandData:SetIsTurnOver(turnOver)
    self._turnOver = turnOver
end

function BalatroGeneralBrandData:GetStyle()
    return self._Style
end

function BalatroGeneralBrandData:GetExtraStyle()
    return self._ExtraStyle
end

function BalatroGeneralBrandData:GetCardName()
    return self._Name
end


function BalatroGeneralBrandData:SetWeaken(weaken)
    self._IsWeaken = weaken
end

function BalatroGeneralBrandData:IsWeaken()
    return self._IsWeaken
end


function BalatroGeneralBrandData:GetIsValid()
    return self._IsWeaken == false
end


function BalatroGeneralBrandData:SetUsed(isUsed)
    self._IsUsed = isUsed
end

function BalatroGeneralBrandData:GetUsed()
    return self._IsUsed
end

function BalatroGeneralBrandData:SetDestroy()
    self._IsDestroy = true
end

function BalatroGeneralBrandData:IsDestroy()
    return self._IsDestroy
end


function BalatroGeneralBrandData:GetPoint()
    if self._IsWeaken == true then
        return 0
    end
    return self._Point + self._ScenePoint
end

function BalatroGeneralBrandData:GetBasePoint()
    return self._Point
end

function BalatroGeneralBrandData:GetConfigStyle()
    return self._ConfigData.Style
end


function BalatroGeneralBrandData:SetSuperShowType(showType)
    self._ShowType = showType
end

function BalatroGeneralBrandData:GetSuperShowType()
    return self._ShowType
end

function BalatroGeneralBrandData:SetExtraScore(num)
    self._ExtraScore = num
end

function BalatroGeneralBrandData:GetExtraScore()
    return self._ExtraScore
end

function BalatroGeneralBrandData:SetExtraRate(num)
    self._ExtraRate = num
end

function BalatroGeneralBrandData:GetExtraRate()
    return self._ExtraRate
end

function BalatroGeneralBrandData:SetExtraMuliRate(num)
    self._ExtraMuliRate = num
end

function BalatroGeneralBrandData:GetExtraMuliRate()
    return self._ExtraMuliRate
end

function BalatroGeneralBrandData:ResetExtraData()
    self._ExtraScore = 0
    self._ExtraRate = 0
    self._ExtraMuliRate = 1
end

function BalatroGeneralBrandData:SetJoinCal(isJoin)
    self._IsJoinCal = isJoin
end

function BalatroGeneralBrandData:IsJoinCal()
    return self._IsJoinCal
end

BalatroGeneralBrandData.StylePointTbl = {}
BalatroGeneralBrandData.GetBrandByCondition = function(style, showPoint)
    if #BalatroGeneralBrandData.StylePointTbl == 0 then
        for key, value in pairs(ConfigMgr.Config.GeneralBrandList) do
            if BalatroGeneralBrandData.StylePointTbl[value.Style] == nil then
                BalatroGeneralBrandData.StylePointTbl[value.Style] = {}
            end
            BalatroGeneralBrandData.StylePointTbl[value.Style][value.ShowPoint] = value
        end
    end
    if BalatroGeneralBrandData.StylePointTbl[style] then
        return BalatroGeneralBrandData.StylePointTbl[style][showPoint]
    end
    LuaDebug.error(string.format("错误的索引 style:%s showPoint:%s", tostring(style), tostring(showPoint)))
    return nil
end