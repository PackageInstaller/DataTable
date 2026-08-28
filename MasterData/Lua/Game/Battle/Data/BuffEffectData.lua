--[[
    author:luqucheng
    time:2020-09-28 16:57:52
]]
---@class Game.Battle.Data.BuffEffectData
local BuffEffectData = {}

BuffEffectData.id = nil
BuffEffectData.lv = nil
BuffEffectData.star = nil
BuffEffectData.mainEffectType = nil
BuffEffectData.subEffectType = nil
BuffEffectData.miniEffectType = nil
BuffEffectData.effectNum1 = nil
BuffEffectData.effectLv = nil
BuffEffectData.dispelLv = nil
BuffEffectData.multiType = nil--综合类型ID，由mainEffectType subEffectType miniEffectType buffType组合而出

return  BuffEffectData