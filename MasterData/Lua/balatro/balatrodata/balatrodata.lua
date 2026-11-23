







require("Balatro/BalatroData/BalatroBrandDataBase")
require("Balatro/BalatroData/BalatroEffect")

BalatroData = setmetatable({}, {__index = BalatroBrandDataBase})
BalatroData.__index = BalatroData
function BalatroData.New(configData)

    local self = BalatroBrandDataBase.New()
    self._ID = configData.ID
    self._Des = configData.Des
    self._Name = LuaMgr.GetLangText(configData.Namelan)
    self._ResName = configData.ResID
    self._EffectFunc = _G["BalatroEffect_" .. configData.EffectID]
    self._FallbackEffectFunc = nil
    self._ConfigData = configData
    self._UID = self._ID * 10000
    self._IsDestroy = false
self._CanChangePointIndex = 0
    self._OwnerStatus = BalatroUtil.BalatroOwnStatus.None
    self._OldUsePropsCount = 0
    setmetatable(self, BalatroData)
    self:Reset(true)
    self:CalBeforeReset()
    self:SetUID(self._UID)
    return self
end

function BalatroData:Reset(resetDestroy)
    self._AddRate = 0
    self._MuliRate = 1
    self._Score = 0
    self._ChildBrand = nil

    self._IsInStage = false
    if resetDestroy == true then

        self._IsDestroy = false
    end

    self._IsInvalid = false
    self._IsSelected = false

    self._DesktopIndex = 0

    self._FallbackConfig = nil
    self._FallbackEffectFunc = nil
    self._HandBrandLimit = 0
    self._CanChangePointIndex = 0
    self._SelectRoundID = nil
    self._OldUsePropsCount = 0
end


function BalatroData:CalBeforeReset()
    self._AddRate = 0
    self._MuliRate = 1
    self._Score = 0
end


function BalatroData:SetFallbackConfig(configData)
    self._FallbackConfig = configData
    self._FallbackEffectFunc = _G["BalatroEffect_" .. configData.EffectID]
end

function BalatroData:GetConfig()
    if self._FallbackConfig then
        return self._FallbackConfig
    end
    return self._ConfigData
end

function BalatroData:GetDes()
    local des = LuaMgr.GetLangText(self._ConfigData.Deslan)
    if not des or des == "" then
        des = self._ConfigData.Des
    end
    local startIndex, endIndex = string.find(des, "%d")
    if startIndex ~= nil then
        if self._CanChangePointIndex ~= 0 then
            return string.gsub(des, "%%s", BalatroUtil.ShowPointStr[self._CanChangePointIndex])
        elseif self._ConfigData.ResultType1 == BalatroUtil.ResultType.Score then
            return string.gsub(des, "%%d", tostring(self._Score))
        elseif self._ConfigData.ResultType1 == BalatroUtil.ResultType.Rate and self._ConfigData.CalSymbol1 == BalatroUtil.CalSymbolType.Add then
            return string.gsub(des, "%%d", tostring(self._AddRate))
        else
            return string.gsub(des, "%%d", tostring(self._MuliRate))
        end
    end
    return des
end

function BalatroData:SetCanChangePointIndex(showPointIndex)
    self._CanChangePointIndex = showPointIndex
end

function BalatroData:GetCanChangePointIndex()
    return self._CanChangePointIndex
end

function BalatroData:CanCopyAbility()
    return self._ConfigData.CanCopyAbility == 1
end


function BalatroData:SetMuliRate(num)
    self._MuliRate = num
end

function BalatroData:GetMuliRate()
    return self._MuliRate or 1
end


function BalatroData:SetAddRate(num)
    self._AddRate = num
end

function BalatroData:GetAddRate()
    return self._AddRate or 0
end


function BalatroData:SetScore(num)
    self._Score = num
end

function BalatroData:GetScore()
    return self._Score or 0
end


function BalatroData:SetPlaycardTimes(num)
    self._PlaycardTimes = num
end

function BalatroData:GetPlaycardTimes()
    return self._PlaycardTimes
end


function BalatroData:SetDiscardTimes(num)
    self._DiscardTimes = num
end

function BalatroData:GetDiscardTimes()
    return self._DiscardTimes
end


function BalatroData:SetHandBrandLimit(num)
    self._HandBrandLimit = num
end

function BalatroData:GetHandBrandLimit()
    return self._HandBrandLimit
end

function BalatroData:SetChildBrand(brand)
    self._ChildBrand = table.Copy(brand)
end

function BalatroData:GetChildBrand()
    return self._ChildBrand
end

function BalatroData:SetDestroy()
    self._IsDestroy = true
    self._IsTempSelected = false
    self._IsSelected = false
    self._FallbackConfig = nil
    self._FallbackEffectFunc = nil
end

function BalatroData:GetIsDestroy()
    return self._IsDestroy
end

function BalatroData:SetInvalid(isInvalid)
    self._IsInvalid = isInvalid
end

function BalatroData:GetInvalid()
    return self._IsInvalid
end


function BalatroData:SetSelected(isSelected)
    self._IsSelected = isSelected
end

function BalatroData:GetSelected()
    return self._IsSelected
end

function BalatroData:SetTempSelected(isSelected)
    self._IsTempSelected = isSelected
end

function BalatroData:GetTempSelected()
    return self._IsTempSelected
end

function BalatroData:SetSelectRoundID(id)
    self._SelectRoundID = id
end

function BalatroData:GetSelectRoundID()
    return self._SelectRoundID
end



function BalatroData:SetOwnStatus(ownerStatus)
    self._OwnerStatus = ownerStatus
end

function BalatroData:GetOwnStatus()
    return self._OwnerStatus
end


function BalatroData:GetRare()
    return self._ConfigData.Rare
end

function BalatroData:SetUsePropsCount(num)
    self._OldUsePropsCount = num
end

function BalatroData:GetUsePropsCount()
    return self._OldUsePropsCount
end




function BalatroData:Execute(cardLst, otherParam)
    if self._IsDestroy == true or self._IsSelected == false or self._IsInvalid == true then
        if self._IsInvalid == true then
            self:CalBeforeReset()    
        end
        return nil
    end
    if self._ConfigData.ActionType ~= BalatroUtil.ActionType.Increase then
        self:CalBeforeReset()
    end
    if self:CanCopyAbility() == false then
        if type(self._EffectFunc) == BalatroUtil.LuaDataType.Function then
            self._EffectFunc(self, cardLst, otherParam)
        end
        if type(self._FallbackEffectFunc) == BalatroUtil.LuaDataType.Function then
            return self._FallbackEffectFunc(self, cardLst, otherParam)
        end
    else
        if type(self._EffectFunc) == BalatroUtil.LuaDataType.Function then
            return self._EffectFunc(self, cardLst, otherParam)
        end
    end
    return nil
end

function BalatroData:SetUID(uid)
    self._UID = uid
end

function BalatroData:GetUID()
    return self._UID
end

function BalatroData:SetIsTemp(isTemp)
    self._IsTemp = isTemp
end


function BalatroData:GetIsTemp()
    return self._IsTemp
end