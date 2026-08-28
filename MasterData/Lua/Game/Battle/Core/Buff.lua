--
-- Author:luqucheng
-- Date: 2019-10-22 11:21:20
--
local Buff = Class("Buff")
local Core = import('Game.Battle.Core.Core')
local Trigger = import('Game.Battle.Core.Trigger')
local BuffEffect = import("Game.Battle.Core.BuffEffect")
local BuffEffectFactory = import("Game.Battle.Core.BuffEffectFactory")

--buff类型
--持续时间
Buff.buffID = nil
Buff.id = nil
Buff.layNum = nil
--@RefType [Game.Battle.Data.BuffData#BuffData]
Buff.data = nil--配置表内的数据，对应效果表
Buff.remainRound = nil
Buff.owner = nil
Buff.attacker = nil
Buff.value = 0
--@RefType [Game.Battle.Core.BuffEffect#BuffEffect<>]
Buff.effects = nil

Buff.triggerCdValue = 0
Buff.triggerCdValuePerTarget = {}
Buff.mainEffectType = 0
Buff.subEffectType = 0
Buff.miniEffectType = 0

Buff.state = nil

Buff.dispelLv = 0

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function Buff:__init(owner, attacker, buffData, layNum, effectParams)
    self.data = buffData
    self.layNum = math.range( layNum, 1, self.data.stackingMax )
    self.buffID = self.data.id
    self.remainRound = buffData.round
    self.id = Core:GetNextBuffID()
    self.owner = owner
    self.attacker = attacker
    self.dispelLv = 0
    self.sourceType = effectParams and effectParams.buffSourceType or 0
    --添加buff效果
    self.effects = {}

    for i,v in ipairs(self.data.effects) do
        local buffEffectData = Core:GetBuffEffectData(v, self.data.star, self.data.lv, self.data.upgradeType)
        -- local buffEffect = BuffEffect.New(self, buffEffectData, effectParams)
        local buffEffect = BuffEffectFactory:GetBuffEffect(self, buffEffectData, effectParams)
        buffEffect.isUnique = self.data.isUnique[i] == 1
        table.insert(self.effects, buffEffect)
    end

    --buff的type取的是第一个效果的
    self.mainEffectType = buffData.mainEffectType
    self.subEffectType = buffData.subEffectType
    self.miniEffectType = buffData.miniEffectType
    self.dispelLv = buffData.dispelLv

    self.state = Constants.BuffState.Active

    if self.data.triggerCdType == Constants.TriggerCdType.Round then
        self.triggerCdValue = 0
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInOnSkill then
        self.triggerCdValue = self.data.triggerCdNum
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInRound then
        self.triggerCdValue = self.data.triggerCdNum
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInOnSkillPerTarget then
        self.triggerCdValuePerTarget = {}
    end
end

function Buff:SetOverrideValue(overrideValue)
    self.effects[1].value = overrideValue
end

function Buff:Refresh()
    if self.data.refresh == 0 then
        return false
    end
    local isRefreshed = false
    for i,effect in ipairs(self.effects) do
        local refreshed = effect:Refresh()
        if refreshed then
            isRefreshed = true
        end
    end

    return isRefreshed
end

function Buff:WalkAllEffects( func, includeDisabled )
    for i,effect in ipairs(self.effects) do
        if func and effect.enable or includeDisabled then
            local stop = func(effect)
            if stop then
                return true
            end
        end
    end
end

function Buff:HasBuffEffectType( effectType )
    for i,effect in ipairs(self.effects) do
        if effect.data.mainEffectType == effectType then
            return true
        end
    end
    return false
end

function Buff:HasUnique(  )
    for i,effect in ipairs(self.effects) do
        if effect.isUnique then
            return true
        end
    end

    return false
end

function Buff:AddLayer( addNum, overrideMax )
    if overrideMax then
        self.layNum = math.range( self.layNum + addNum, 0, overrideMax )
    else
        self.layNum = math.range( self.layNum + addNum, 0, self.data.stackingMax )
    end
    return self.layNum
end


function Buff:SetLayer( num, overrideMax )
    if overrideMax then
        self.layNum = math.range( num, 0, overrideMax )
    else
        self.layNum = math.range( num, 0, self.data.stackingMax )
    end
end

function Buff:IsMaxLayer()
    return self.layNum >= self.data.stackingMax
end

function Buff:TrigEffect( trigMainType, trigData, target )
    trigData.trigger = self
    trigData.triggerType = Constants.BuffTriggerType.Effect
    local data = self.data
    -- print("TrigEffect", self.buffID, trigMainType, data.effectTrigger)
    local isTrig , isFinal = Trigger.CheckTrigger(data.effectTrigger, trigMainType, self.owner, target, trigData, data.buffConditionPara, self)
    return isTrig, data.triggerEffectTypes, data.effectId, data.stackTime , isFinal
end

function Buff:TrigEnd( trigMainType, trigData, target )
    trigData.trigger = self
    trigData.triggerType = Constants.BuffTriggerType.End
    local data = self.data
    local isTrig = Trigger.CheckTrigger(data.endType, trigMainType, self.owner, target, trigData, data.buffEndPara, self)
    return isTrig
end

function Buff:ResetCountOnSkillTrigger(  )
    if self.data.triggerCdType == Constants.TriggerCdType.CountInOnSkill then
        self.triggerCdValue = self.data.triggerCdNum
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInOnSkillPerTarget then
        for k, v in pairs(self.triggerCdValuePerTarget) do
            self.triggerCdValuePerTarget[k] = nil
        end
    end
end

function Buff:OnTrigged( target )
    if self.data.triggerCdType == Constants.TriggerCdType.Round then
        self.triggerCdValue = self.data.triggerCdNum
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInOnSkill then
        self.triggerCdValue = self.triggerCdValue - 1
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInRound then
        self.triggerCdValue = self.triggerCdValue - 1
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInOnSkillPerTarget then
        if target then
            self.triggerCdValuePerTarget[target.id] = (self.triggerCdValuePerTarget[target.id] or 0) + 1
        end
    end
end

function Buff:OnChangeDuration( deltaDuration )
    if self.data.triggerCdType == Constants.TriggerCdType.Round and self.triggerCdValue > 0 and deltaDuration < 0 then
        self.triggerCdValue = self.triggerCdValue + deltaDuration
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInRound then
        self.triggerCdValue = self.data.triggerCdNum
    end
end

function Buff:IsInCd( target )
    if not self.data.triggerCdType or self.data.triggerCdType == Constants.TriggerCdType.None then
        return false
    end
    if self.data.triggerCdType == Constants.TriggerCdType.Round then
        return self.triggerCdValue > 0
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInOnSkill then
        return self.triggerCdValue <= 0
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInRound then
        return self.triggerCdValue <= 0
    elseif self.data.triggerCdType == Constants.TriggerCdType.CountInOnSkillPerTarget then
        if target then
            return (self.triggerCdValuePerTarget[target.id] or 0) >= self.data.triggerCdNum
        else
            return false
        end
    end

    return false
end

--有cd的技能就没有触发保护
function Buff:NeedTrigProtect()
    if self.data.triggerCdType == Constants.TriggerCdType.Round
        or self.data.triggerCdType == Constants.TriggerCdType.CountInRound
        or self.data.triggerCdType == Constants.TriggerCdType.CountInOnSkillPerTarget then
        return false
    end

    return true
end

function Buff:OnRemove()
    self:WalkAllEffects(function(effect)
        if effect.OnRemove then
            effect:OnRemove()
        end
        return false
    end)
end

return  Buff