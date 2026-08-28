--[[
    author:luqucheng
    time:2020-09-28 16:36:58
]]
local BuffEffect = {}
BuffEffect = Class("BuffEffect")

--@RefType [Game.Battle.Core.Buff#Buff]
BuffEffect.buff = nil --buff效果属于的buff

--@RefType [Game.Battle.Data.BuffEffectData#BuffEffectData]
BuffEffect.data = nil


BuffEffect.value = 0
BuffEffect.enable = true
BuffEffect.isUnique = nil

--@buff: [Game.Battle.Core.Buff#Buff]
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
--@buffEffectData: [Game.Battle.Data.BuffEffectData#BuffEffectData]
function BuffEffect:__init(buff, buffEffectData, effectParams)
    self.buff = buff
    self.data = buffEffectData
end

function BuffEffect:GetValue(  )
    return self.value
end

function BuffEffect:SetValue( value )
    self.value = value
end

function BuffEffect:Refresh()
    return false
end

function BuffEffect:IsType(mainType, subType, miniType)
    return self.data.mainEffectType == mainType and self.data.subEffectType == subType and self.data.miniEffectType == miniType
end

return  BuffEffect