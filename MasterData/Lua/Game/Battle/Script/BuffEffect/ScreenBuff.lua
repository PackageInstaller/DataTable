--
-- Author:luqucheng
-- Date: 2022-3-7 15:43:01
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')
local ScreenBuff = Class("ScreenBuff", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function ScreenBuff:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)
end

--@buff: [Game.Battle.Core.Buff#Buff]
function ScreenBuff:IsScreen(buff)
    local data = self.data
    local sub = self.data.subEffectType
    if sub == 1 then
        --按照tag屏蔽
        for i,tag in ipairs(buff.data.buffTags) do
            if tag == data.effectNum1[1] then
                return true
            end
        end
        return false
    elseif sub == 2 then
        --根据大类二类三类和增减益屏蔽
        local mainType = data.effectNum1[1]
        local subType = data.effectNum1[2]
        local miniType = data.effectNum1[3]
        local buffType = data.effectNum1[4]

        return (buffType == 0 or buff.data.buffType == buffType) and 
            (mainType == 0 or buff.mainEffectType == mainType) and 
            (subType == 0 or buff.subEffectType == subType) and 
            (miniType == 0 or buff.miniEffectType == miniType)
    elseif sub == 3 then
        --根据id屏蔽
        return data.effectNum1[1] == buff.buffID
    end
end

return  ScreenBuff