--
-- Author:luqucheng
-- Date: 2019-11-13 15:51:01
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')

local ChangePushCardProbBuffType = Constants.SpecialBuffType.ChangePushCardProb

local ChangePushCardProb = Class("ChangePushCardProb", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function ChangePushCardProb:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)
    local data = self.data
    local owner = self.buff.owner
    local attacker = self.buff.attacker

    local prob = data.effectNum1[1]

    owner.buffMgr:SetSpecialStatus(ChangePushCardProbBuffType, prob)
end

function ChangePushCardProb:OnRemove()
    local owner = self.buff.owner
    
    -- 清除
    owner.buffMgr:ClearSpecialStatus(ChangePushCardProbBuffType)

    -- 检查是否还有其他的changePushCardProb类型的buff
    owner.buffMgr:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == Constants.BuffType.Special
        and buffEffect.data.subEffectType == Constants.SpecialBuffType.ChangePushCardProb then
            local params = buffEffect.data.effectNum1
            local prob = params[1]
            owner.buffMgr:SetSpecialStatus(ChangePushCardProbBuffType, prob)
            return true
        end
        return false
    end)
end

return  ChangePushCardProb