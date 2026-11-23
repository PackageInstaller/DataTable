







require("Balatro/BalatroData/BalatroBrandDataBase")
require("Balatro/BalatroData/BalatroEffect")

BalatroSceneData = setmetatable({}, {__index = BalatroBrandDataBase})
BalatroSceneData.__index = BalatroSceneData
function BalatroSceneData.New(configData)

    local self = BalatroBrandDataBase.New()
    self._ID = configData.ID
    self._Des = configData.Des
    self._Name = configData.Name
    self._Dirty = false
    if not configData.EffectID then
        self._Effect = _G["SceneEffect_" .. 10000]
    else
        self._Effect = _G["SceneEffect_" .. configData.EffectID]
    end
    self._IsValid = true
    self._ConfigData = configData
    setmetatable(self, BalatroSceneData)
    return self
end

function BalatroSceneData:GetConfig()
    return self._ConfigData
end

function BalatroSceneData:GetDes()
    local des = LuaMgr.GetLangText(self._ConfigData.Deslan)
    if not des or des == "" then
        des = self._ConfigData.Des
    end
    return des
end

function BalatroSceneData:GetCalTime()
    return self._ConfigData.CalFrequency
end


function BalatroSceneData:SetDirty()
    self._Dirty = true
end

function BalatroSceneData:IsDirty()
    return self._Dirty
end

function BalatroSceneData:Execute(cardLst, otherParam)
    if type(self._Effect) == BalatroUtil.LuaDataType.Function then
        return self._Effect(self, cardLst, otherParam)
    end
    LuaDebug.error("BalatroSceneData:Execute ID:" .. self._ConfigData.EffectID)
    return false
end