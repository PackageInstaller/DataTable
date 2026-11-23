







require("Balatro/BalatroData/BalatroBrandDataBase")
require("Balatro/BalatroData/BalatroEffect")

BalatroPropBrandData = setmetatable({}, {__index = BalatroBrandDataBase})
BalatroPropBrandData.__index = BalatroPropBrandData

function BalatroPropBrandData.New(configData)

    local self = BalatroBrandDataBase.New()
    self._ID = configData.ID
    self._ConfigData = configData
    self._Name = LuaMgr.GetLangText(self._ConfigData.Namelan)
    self._Des = LuaMgr.GetLangText(self._ConfigData.Deslan)
    self._ResName = configData.ResID
    self._Effect = _G["PropsEffect_" .. configData.EffectID]
    self._UID = 0

    self._DesktopIndex = 0
    setmetatable(self, BalatroPropBrandData)
    self:SetUID(self._UID)
    return self
end

function BalatroPropBrandData:GetConfig()
    return self._ConfigData
end

function BalatroPropBrandData:SetUID(uid)
    self._UID = uid
end

function BalatroPropBrandData:GetUID()
    return self._UID
end

function BalatroPropBrandData:Use(brandDatas, otherParam)
    if self._Effect ~= nil and type(self._Effect) == BalatroUtil.LuaDataType.Function then
        return self._Effect(self, brandDatas, otherParam)
    end
    return false, ""
end