--
-- Author:luqucheng
-- Date: 2019-10-17 14:34:26
--
local Attribute = {}
Attribute = Class("Attribute")

--当前属性
Attribute.values = nil
--加成属性
Attribute.subValues = nil
--基础属性
Attribute.baseValues = nil



function Attribute:__init(...)

    self.values = {}
    self.subValues = {}
    self.baseValues = {}
    
    --初始化角色属性,补全空位
    local na = self.values
    local ba = self.baseValues
    local sa = self.subValues
    for k,v in pairs(Constants.AttrTypeId) do
        na[tostring(v)] = 0
        ba[tostring(v)] = 0
    end

    for k,v in pairs(Constants.AttrAdditionIdType) do
        sa[tostring(v)] = 0
    end

    self:InitWithData(...)


    --@TODO 2019-10-31 16:41:28 测试用，需要删除
    -- ba[tostring(Constants.AttrTypeId.Hp)] = 10000
    ba[tostring(Constants.AttrTypeId.Pose)] = 1

    -- printInfo(table.toString(self.values,'na'))
    -- printInfo(table.toString(self.baseValues,'ba'))
    -- printInfo(table.toString(self.subValues,'sa'))

    self.lockValues = {}
end

function Attribute:InitWithData( data )
    if not data then
        return
    end
    local ba = self.baseValues
    local l = string.slice(data, '&')
    for i,v in ipairs(l) do
        local d = string.slice(v, '=')
        local key = tonumber(d[1])
        ba[tostring(key)] = tonumber(d[2])
    end
end

--desc:
--Author:luqucheng
--date:2019-10-17 14:34:26
function Attribute:GetValue(attrType)
    local value = self.values[tostring(attrType)]
    if value then
        return value
    end
    return 0
end

function Attribute:GetOriginValue(attrType)
    local value = self.baseValues[tostring(attrType)]
    if value then
        return value
    end
    return 0
end

function Attribute:GetSubValue(attrType)
    local value = self.subValues[tostring(attrType)]
    if value then
        return value
    end
    return 0
end

function Attribute:SetValue(attrType, value)
    self.values[tostring(attrType)] = value
end

--计算当前属性
function Attribute:RefreshNowValues()
    local b = Constants.AttrTypeId
    local a = Constants.AttrAdditionIdType
    local speedThreshold = Constants.BattleSpeedThreshold

    local v2p = Constants.ValueToPercent

    local na = self.values
    local ba = self.baseValues
    local sa = self.subValues
    
    -- local speed = math.max( 1, ba[tostring(b.Speed)] * (1 + sa[tostring(a.SpeedPercent)]) + sa[tostring(a.Speed)] )
    -- if speed > speedThreshold then
    --     local s1 = speed - speedThreshold
    --     local s2 = speed - speedThreshold - 1
    --     speed = math.round( speedThreshold + math.floor( s1^0.5 )  +  math.floor( s2^(2/3) ) )
    -- end
    -- na[tostring(b.Speed)] = speed

    -- 战斗内生命值上限 = 角色养成生命值上限 *（1+BUFF生命值上限百分比变化）+BUFF生命值上限固定值变化。
    na[tostring(b.Hp)] = math.max( 1, ba[tostring(b.Hp)] * (1+ sa[tostring(a.HpPercent)]) + sa[tostring(a.Hp)] )
    -- 战斗防御力 = 角色养成防御力 *（1+BUFF防御力百分比变化）+BUFF防御力变化。
    na[tostring(b.Defense)] = math.max( 0, ba[tostring(b.Defense)] * (1+ sa[tostring(a.DefPercent)]) + sa[tostring(a.Def)])

    -- 战斗内攻击力 = 角色养成攻击力 *（1+BUFF攻击力百分比变化）+BUFF攻击力变化。
    na[tostring(b.Attack)] = math.max( 0, ba[tostring(b.Attack)] * (1+ sa[tostring(a.AtkPercent)]) + sa[tostring(a.Atk)])

    na[tostring(b.GiveBaseDamageIncrease)] = ba[tostring(b.GiveBaseDamageIncrease)] + sa[tostring(a.GiveBaseDamageIncrease)]
    na[tostring(b.GiveNormalDamageIncrease)] = ba[tostring(b.GiveNormalDamageIncrease)] + sa[tostring(a.GiveNormalDamageIncrease)]
    na[tostring(b.GiveFinalDamageIncrease)] = ba[tostring(b.GiveFinalDamageIncrease)] + sa[tostring(a.GiveFinalDamageIncrease)]
    na[tostring(b.TakeBaseDamageIncrease)] = ba[tostring(b.TakeBaseDamageIncrease)] + sa[tostring(a.TakeBaseDamageIncrease)]
    na[tostring(b.TakeNormalDamageIncrease)] = ba[tostring(b.TakeNormalDamageIncrease)] + sa[tostring(a.TakeNormalDamageIncrease)]
    na[tostring(b.TakeFinalDamageIncrease)] = ba[tostring(b.TakeFinalDamageIncrease)] + sa[tostring(a.TakeFinalDamageIncrease)]
    na[tostring(b.GiveIndirectDamageIncrease)] = ba[tostring(b.GiveIndirectDamageIncrease)] + sa[tostring(a.GiveIndirectDamageIncrease)]
    na[tostring(b.TakeIndirectDamageIncrease)] = ba[tostring(b.TakeIndirectDamageIncrease)] + sa[tostring(a.TakeIndirectDamageIncrease)]
    na[tostring(b.GiveShieldIncrease)] = ba[tostring(b.GiveShieldIncrease)] + sa[tostring(a.GiveShieldIncrease)]
    na[tostring(b.TakeShieldIncrease)] = ba[tostring(b.TakeShieldIncrease)] + sa[tostring(a.TakeShieldIncrease)]

    na[tostring(b.PenetrationValue)] = math.max(0, ba[tostring(b.PenetrationValue)] * (1 + sa[tostring(a.PenetrationValuePercent)]) + sa[tostring(a.PenetrationValue)])
    na[tostring(b.Penetration)] = math.max(0, na[tostring(b.PenetrationValue)] * v2p + ba[tostring(b.Penetration)] + sa[tostring(a.Penetration)])

    na[tostring(b.BearValue)] = math.max(0, ba[tostring(b.BearValue)] * (1 + sa[tostring(a.BearValuePercent)]) + sa[tostring(a.BearValue)])
    na[tostring(b.Bear)] = math.max(0, na[tostring(b.BearValue)] * v2p + ba[tostring(b.Bear)] + sa[tostring(a.Bear)])

    -- 命中
    na[tostring(b.HitValue)] = math.max(0, ba[tostring(b.HitValue)] * (1 + sa[tostring(a.HitValuePercent)]) + sa[tostring(a.HitValue)])
    na[tostring(b.Hit)] = math.max(0, na[tostring(b.HitValue)] * v2p + ba[tostring(b.Hit)] + sa[tostring(a.Hit)])

    --闪避
    na[tostring(b.DodgeValue)] = math.max(0, ba[tostring(b.DodgeValue)] * (1 + sa[tostring(a.DodgeValuePercent)]) + sa[tostring(a.DodgeValue)])
    na[tostring(b.Dodge)] = math.max(0, na[tostring(b.DodgeValue)] * v2p + ba[tostring(b.Dodge)] + sa[tostring(a.Dodge)])

    -- 暴击率 = 战斗外暴击率 + BUFF暴击率变化
    na[tostring(b.CriticalValue)] = math.max(0, ba[tostring(b.CriticalValue)] * (1 + sa[tostring(a.CritValuePercent)] ) + sa[tostring(a.CritValue)])
    na[tostring(b.Critical)] = math.max(0, na[tostring(b.CriticalValue)] * v2p + ba[tostring(b.Critical)] + sa[tostring(a.Crit)])

    --暴击抵抗
    na[tostring(b.CriticalResistValue)] = math.max(0, ba[tostring(b.CriticalResistValue)] * (1 + sa[tostring(a.CritResistValuePercent)] ) + sa[tostring(a.CritResistValue)])
    na[tostring(b.CriticalResist)] = math.max(0, na[tostring(b.CriticalResistValue)] * v2p + ba[tostring(b.CriticalResist)] + sa[tostring(a.CritResist)])

    -- 暴击伤害 = 战斗外暴击伤害 + BUFF暴击伤害变化
    na[tostring(b.CritDamageValue)] = math.max(0, ba[tostring(b.CritDamageValue)] * (1 + sa[tostring(a.CritDamageValuePercent)] ) + sa[tostring(a.CritDamageValue)])
    na[tostring(b.CritDamage)] = math.max(0, na[tostring(b.CritDamageValue)] * v2p + ba[tostring(b.CritDamage)] + sa[tostring(a.CritDamage)])

    -- 爆伤抵抗
    na[tostring(b.CritDamageResistValue)] = math.max(0, ba[tostring(b.CritDamageResistValue)] * (1 + sa[tostring(a.CritDamageResistValuePercent)] ) + sa[tostring(a.CritDamageResistValue)])
    na[tostring(b.CritDamageResist)] = math.max(0, na[tostring(b.CritDamageResistValue)] * v2p + ba[tostring(b.CritDamageResist)] + sa[tostring(a.CritDamageResist)])

    na[tostring(b.Luck)] = math.max( 0, ba[tostring(b.Luck)] + sa[tostring(a.Luck)] )

    na[tostring(b.TakeTreatment)] = ba[tostring(b.TakeTreatment)] + sa[tostring(a.TakeTreatment)]
    na[tostring(b.GiveTreatment)] = ba[tostring(b.GiveTreatment)] + sa[tostring(a.GiveTreatment)]

    na[tostring(b.Absorb)] = math.max( 0, ba[tostring(b.Absorb)] + sa[tostring(a.Absorb)])

    na[tostring(b.Cleave)] = math.max( 0, ba[tostring(b.Cleave)] + sa[tostring(a.Cleave)])

    na[tostring(b.BounceDamage)] = math.max(0, ba[tostring(b.BounceDamage)] + sa[tostring(a.BounceDamage)])
    na[tostring(b.BouncePercent)] = math.max(0, ba[tostring(b.BouncePercent)] + sa[tostring(a.BouncePercent)])

    na[tostring(b.EffectHit)] = math.max(0, ba[tostring(b.EffectHit)] + sa[tostring(a.EffectHit)])
    na[tostring(b.EffectDodge)] = math.max(0, ba[tostring(b.EffectDodge)] + sa[tostring(a.EffectDodge)])

    na[tostring(b.OverHealTransToShield)] =  math.max(0, ba[tostring(b.OverHealTransToShield)] + sa[tostring(a.OverHealTransToShield)])
    
    na[tostring(b.OverCritTransToCritDamage)] = math.max(0, ba[tostring(b.OverCritTransToCritDamage)] + sa[tostring(a.OverCritTransToCritDamage)])

    -- print(table.toString(na,"na"))
    na[tostring(b.TakeSpecialDamageChange01)] = ba[tostring(b.TakeSpecialDamageChange01)] + sa[tostring(a.TakeSpecialDamageChange01)]
    na[tostring(b.GiveSpecialDamageChange01)] = ba[tostring(b.GiveSpecialDamageChange01)] + sa[tostring(a.GiveSpecialDamageChange01)]
    na[tostring(b.TakeSpecialDamageChange02)] = ba[tostring(b.TakeSpecialDamageChange02)] + sa[tostring(a.TakeSpecialDamageChange02)]
    na[tostring(b.GiveSpecialDamageChange02)] = ba[tostring(b.GiveSpecialDamageChange02)] + sa[tostring(a.GiveSpecialDamageChange02)]
    na[tostring(b.TakeSpecialDamageChange03)] = ba[tostring(b.TakeSpecialDamageChange03)] + sa[tostring(a.TakeSpecialDamageChange03)]
    na[tostring(b.GiveSpecialDamageChange03)] = ba[tostring(b.GiveSpecialDamageChange03)] + sa[tostring(a.GiveSpecialDamageChange03)]
    na[tostring(b.TakeSpecialDamageChange04)] = ba[tostring(b.TakeSpecialDamageChange04)] + sa[tostring(a.TakeSpecialDamageChange04)]
    na[tostring(b.GiveSpecialDamageChange04)] = ba[tostring(b.GiveSpecialDamageChange04)] + sa[tostring(a.GiveSpecialDamageChange04)]
    na[tostring(b.TakeSpecialDamageChange05)] = ba[tostring(b.TakeSpecialDamageChange05)] + sa[tostring(a.TakeSpecialDamageChange05)]
    na[tostring(b.GiveSpecialDamageChange05)] = ba[tostring(b.GiveSpecialDamageChange05)] + sa[tostring(a.GiveSpecialDamageChange05)]
    na[tostring(b.TakeSpecialDamageChange06)] = ba[tostring(b.TakeSpecialDamageChange06)] + sa[tostring(a.TakeSpecialDamageChange06)]
    na[tostring(b.GiveSpecialDamageChange06)] = ba[tostring(b.GiveSpecialDamageChange06)] + sa[tostring(a.GiveSpecialDamageChange06)]
    na[tostring(b.TakeSpecialDamageChange07)] = ba[tostring(b.TakeSpecialDamageChange07)] + sa[tostring(a.TakeSpecialDamageChange07)]
    na[tostring(b.GiveSpecialDamageChange07)] = ba[tostring(b.GiveSpecialDamageChange07)] + sa[tostring(a.GiveSpecialDamageChange07)]
    na[tostring(b.TakeSpecialDamageChange08)] = ba[tostring(b.TakeSpecialDamageChange08)] + sa[tostring(a.TakeSpecialDamageChange08)]
    na[tostring(b.GiveSpecialDamageChange08)] = ba[tostring(b.GiveSpecialDamageChange08)] + sa[tostring(a.GiveSpecialDamageChange08)]
    na[tostring(b.TakeSpecialDamageChange09)] = ba[tostring(b.TakeSpecialDamageChange09)] + sa[tostring(a.TakeSpecialDamageChange09)]
    na[tostring(b.GiveSpecialDamageChange09)] = ba[tostring(b.GiveSpecialDamageChange09)] + sa[tostring(a.GiveSpecialDamageChange09)]
    na[tostring(b.TakeSpecialDamageChange10)] = ba[tostring(b.TakeSpecialDamageChange10)] + sa[tostring(a.TakeSpecialDamageChange10)]
    na[tostring(b.GiveSpecialDamageChange10)] = ba[tostring(b.GiveSpecialDamageChange10)] + sa[tostring(a.GiveSpecialDamageChange10)]
    na[tostring(b.TakeSpecialDamageChange11)] = ba[tostring(b.TakeSpecialDamageChange11)] + sa[tostring(a.TakeSpecialDamageChange11)]
    na[tostring(b.GiveSpecialDamageChange11)] = ba[tostring(b.GiveSpecialDamageChange11)] + sa[tostring(a.GiveSpecialDamageChange11)]
    na[tostring(b.TakeSpecialDamageChange12)] = ba[tostring(b.TakeSpecialDamageChange12)] + sa[tostring(a.TakeSpecialDamageChange12)]
    na[tostring(b.GiveSpecialDamageChange12)] = ba[tostring(b.GiveSpecialDamageChange12)] + sa[tostring(a.GiveSpecialDamageChange12)]
    na[tostring(b.TakeSpecialDamageChange13)] = ba[tostring(b.TakeSpecialDamageChange13)] + sa[tostring(a.TakeSpecialDamageChange13)]
    na[tostring(b.GiveSpecialDamageChange13)] = ba[tostring(b.GiveSpecialDamageChange13)] + sa[tostring(a.GiveSpecialDamageChange13)]
    na[tostring(b.TakeSpecialDamageChange14)] = ba[tostring(b.TakeSpecialDamageChange14)] + sa[tostring(a.TakeSpecialDamageChange14)]
    na[tostring(b.GiveSpecialDamageChange14)] = ba[tostring(b.GiveSpecialDamageChange14)] + sa[tostring(a.GiveSpecialDamageChange14)]
    na[tostring(b.TakeSpecialDamageChange15)] = ba[tostring(b.TakeSpecialDamageChange15)] + sa[tostring(a.TakeSpecialDamageChange15)]
    na[tostring(b.GiveSpecialDamageChange15)] = ba[tostring(b.GiveSpecialDamageChange15)] + sa[tostring(a.GiveSpecialDamageChange15)]
    na[tostring(b.TakeSpecialDamageChange16)] = ba[tostring(b.TakeSpecialDamageChange16)] + sa[tostring(a.TakeSpecialDamageChange16)]
    na[tostring(b.GiveSpecialDamageChange16)] = ba[tostring(b.GiveSpecialDamageChange16)] + sa[tostring(a.GiveSpecialDamageChange16)]


    na[tostring(b.TakeRaceDamageChange01)] = ba[tostring(b.TakeRaceDamageChange01)] + sa[tostring(a.TakeRaceDamageChange01)]
    na[tostring(b.GiveRaceDamageChange01)] = ba[tostring(b.GiveRaceDamageChange01)] + sa[tostring(a.GiveRaceDamageChange01)]
    na[tostring(b.TakeRaceDamageChange02)] = ba[tostring(b.TakeRaceDamageChange02)] + sa[tostring(a.TakeRaceDamageChange02)]
    na[tostring(b.GiveRaceDamageChange02)] = ba[tostring(b.GiveRaceDamageChange02)] + sa[tostring(a.GiveRaceDamageChange02)]
    na[tostring(b.TakeRaceDamageChange03)] = ba[tostring(b.TakeRaceDamageChange03)] + sa[tostring(a.TakeRaceDamageChange03)]
    na[tostring(b.GiveRaceDamageChange03)] = ba[tostring(b.GiveRaceDamageChange03)] + sa[tostring(a.GiveRaceDamageChange03)]
    na[tostring(b.TakeRaceDamageChange04)] = ba[tostring(b.TakeRaceDamageChange04)] + sa[tostring(a.TakeRaceDamageChange04)]
    na[tostring(b.GiveRaceDamageChange04)] = ba[tostring(b.GiveRaceDamageChange04)] + sa[tostring(a.GiveRaceDamageChange04)]
    na[tostring(b.TakeRaceDamageChange05)] = ba[tostring(b.TakeRaceDamageChange05)] + sa[tostring(a.TakeRaceDamageChange05)]
    na[tostring(b.GiveRaceDamageChange05)] = ba[tostring(b.GiveRaceDamageChange05)] + sa[tostring(a.GiveRaceDamageChange05)]
    na[tostring(b.TakeRaceDamageChange06)] = ba[tostring(b.TakeRaceDamageChange06)] + sa[tostring(a.TakeRaceDamageChange06)]
    na[tostring(b.GiveRaceDamageChange06)] = ba[tostring(b.GiveRaceDamageChange06)] + sa[tostring(a.GiveRaceDamageChange06)]

    na[tostring(b.TakeDotDamageChange01)] = ba[tostring(b.TakeDotDamageChange01)] + sa[tostring(a.TakeDotDamageChange01)]
    na[tostring(b.GiveDotDamageChange01)] = ba[tostring(b.GiveDotDamageChange01)] + sa[tostring(a.GiveDotDamageChange01)]
    na[tostring(b.TakeDotDamageChange02)] = ba[tostring(b.TakeDotDamageChange02)] + sa[tostring(a.TakeDotDamageChange02)]
    na[tostring(b.GiveDotDamageChange02)] = ba[tostring(b.GiveDotDamageChange02)] + sa[tostring(a.GiveDotDamageChange02)]
    na[tostring(b.TakeDotDamageChange03)] = ba[tostring(b.TakeDotDamageChange03)] + sa[tostring(a.TakeDotDamageChange03)]
    na[tostring(b.GiveDotDamageChange03)] = ba[tostring(b.GiveDotDamageChange03)] + sa[tostring(a.GiveDotDamageChange03)]
    na[tostring(b.TakeDotDamageChange04)] = ba[tostring(b.TakeDotDamageChange04)] + sa[tostring(a.TakeDotDamageChange04)]
    na[tostring(b.GiveDotDamageChange04)] = ba[tostring(b.GiveDotDamageChange04)] + sa[tostring(a.GiveDotDamageChange04)]
    na[tostring(b.TakeDotDamageChange05)] = ba[tostring(b.TakeDotDamageChange05)] + sa[tostring(a.TakeDotDamageChange05)]
    na[tostring(b.GiveDotDamageChange05)] = ba[tostring(b.GiveDotDamageChange05)] + sa[tostring(a.GiveDotDamageChange05)]
end

function Attribute:GetGiveSpecialDamage(damageTypeId)
    local b = Constants.AttrTypeId
    if damageTypeId == 2 then
        return self.values[tostring(b.GiveSpecialDamageChange01)]
    elseif damageTypeId == 3 then
        return self.values[tostring(b.GiveSpecialDamageChange02)]
    elseif damageTypeId == 4 then
        return self.values[tostring(b.GiveSpecialDamageChange03)]
    elseif damageTypeId == 5 then
        return self.values[tostring(b.GiveSpecialDamageChange04)]
    elseif damageTypeId == 9 then
        return self.values[tostring(b.GiveSpecialDamageChange05)]
    elseif damageTypeId == 10 then
        return self.values[tostring(b.GiveSpecialDamageChange06)]
    elseif damageTypeId == 7 then
        return self.values[tostring(b.GiveSpecialDamageChange07)]
    elseif damageTypeId == 17 then
        return self.values[tostring(b.GiveSpecialDamageChange08)]
    elseif damageTypeId == 23 then
        return self.values[tostring(b.GiveSpecialDamageChange09)]
    elseif damageTypeId == 25 then
        return self.values[tostring(b.GiveSpecialDamageChange10)]
    elseif damageTypeId == 6 then
        return self.values[tostring(b.GiveSpecialDamageChange11)]
    elseif damageTypeId == 12 then
        return self.values[tostring(b.GiveSpecialDamageChange12)]
    elseif damageTypeId == 27 then
        return self.values[tostring(b.GiveSpecialDamageChange13)]
    elseif damageTypeId == 11 then
        return self.values[tostring(b.GiveSpecialDamageChange14)]
    elseif damageTypeId == 15 then
        return self.values[tostring(b.GiveSpecialDamageChange15)]
    elseif damageTypeId == 28 then
        return self.values[tostring(b.GiveSpecialDamageChange16)]
    end
    return 0
end

function Attribute:GetTakeSpecialDamage(damageTypeId)
    local b = Constants.AttrTypeId
    if damageTypeId == 2 then
        return self.values[tostring(b.TakeSpecialDamageChange01)]
    elseif damageTypeId == 3 then
        return self.values[tostring(b.TakeSpecialDamageChange02)]
    elseif damageTypeId == 4 then
        return self.values[tostring(b.TakeSpecialDamageChange03)]
    elseif damageTypeId == 5 then
        return self.values[tostring(b.TakeSpecialDamageChange04)]
    elseif damageTypeId == 9 then
        return self.values[tostring(b.TakeSpecialDamageChange05)]
    elseif damageTypeId == 10 then
        return self.values[tostring(b.TakeSpecialDamageChange06)]
    elseif damageTypeId == 7 then
        return self.values[tostring(b.TakeSpecialDamageChange07)]
    elseif damageTypeId == 17 then
        return self.values[tostring(b.TakeSpecialDamageChange08)]
    elseif damageTypeId == 23 then
        return self.values[tostring(b.TakeSpecialDamageChange09)]
    elseif damageTypeId == 25 then
        return self.values[tostring(b.TakeSpecialDamageChange10)]
    elseif damageTypeId == 6 then
        return self.values[tostring(b.TakeSpecialDamageChange11)]
    elseif damageTypeId == 12 then
        return self.values[tostring(b.TakeSpecialDamageChange12)]
    elseif damageTypeId == 27 then
        return self.values[tostring(b.TakeSpecialDamageChange13)]
    elseif damageTypeId == 11 then
        return self.values[tostring(b.TakeSpecialDamageChange14)]
    elseif damageTypeId == 15 then
        return self.values[tostring(b.TakeSpecialDamageChange15)]
    elseif damageTypeId == 28 then
        return self.values[tostring(b.TakeSpecialDamageChange16)]
    end
    return 0
end

function Attribute:GetGiveRaceDamage(targetRace)
    local b = Constants.AttrTypeId
    if targetRace == 1 then
        return self.values[tostring(b.GiveRaceDamageChange01)]
    elseif targetRace == 2 then
        return self.values[tostring(b.GiveRaceDamageChange02)]
    elseif targetRace == 3 then
        return self.values[tostring(b.GiveRaceDamageChange03)]
    elseif targetRace == 4 then
        return self.values[tostring(b.GiveRaceDamageChange04)]
    elseif targetRace == 5 then
        return self.values[tostring(b.GiveRaceDamageChange05)]
    elseif targetRace == 6 then
        return self.values[tostring(b.GiveRaceDamageChange06)]
    end
    return 0
end

function Attribute:GetTakeRaceDamage(attackerRace)
    local b = Constants.AttrTypeId
    if attackerRace == 1 then
        return self.values[tostring(b.TakeRaceDamageChange01)]
    elseif attackerRace == 2 then
        return self.values[tostring(b.TakeRaceDamageChange02)]
    elseif attackerRace == 3 then
        return self.values[tostring(b.TakeRaceDamageChange03)]
    elseif attackerRace == 4 then
        return self.values[tostring(b.TakeRaceDamageChange04)]
    elseif attackerRace == 5 then
        return self.values[tostring(b.TakeRaceDamageChange05)]
    elseif attackerRace == 6 then
        return self.values[tostring(b.TakeRaceDamageChange06)]
    end
    return 0
end

function Attribute:GetGiveDotDamage(dotSubType)
    local b = Constants.AttrTypeId
    if dotSubType == 1 then
        return self.values[tostring(b.GiveDotDamageChange01)]
    elseif dotSubType == 2 then
        return self.values[tostring(b.GiveDotDamageChange02)]
    elseif dotSubType == 3 then
        return self.values[tostring(b.GiveDotDamageChange03)]
    elseif dotSubType == 4 then
        return self.values[tostring(b.GiveDotDamageChange04)]
    elseif dotSubType == 5 then
        return self.values[tostring(b.GiveDotDamageChange05)]
    end
    return 0
end

function Attribute:GetTakeDotDamage(dotSubType)
    local b = Constants.AttrTypeId
    if dotSubType == 1 then
        return self.values[tostring(b.TakeDotDamageChange01)]
    elseif dotSubType == 2 then
        return self.values[tostring(b.TakeDotDamageChange02)]
    elseif dotSubType == 3 then
        return self.values[tostring(b.TakeDotDamageChange03)]
    elseif dotSubType == 4 then
        return self.values[tostring(b.TakeDotDamageChange04)]
    elseif dotSubType == 5 then
        return self.values[tostring(b.TakeDotDamageChange05)]
    end
    return 0
end

function Attribute:GetOffenseAbilityEstimateValue(  )
    --估算输出能力=【角色攻击力*属性定义表的combatEff字段系数+角色穿透*属性定义表的combatEff字段系数+角色命中*属性定义表的combatEff字段系数+角色暴击值*属性定义表的combatEff字段系数+角色暴伤值*属性定义表的combatEff字段系数】*技能修正系数按照【估算输出能力】进行技能牌的降序
    local b = Constants.AttrTypeId
    local attrIds = {b.Attack, b.Penetration, b.Hit, b.Critical, b.CritDamage}
    local total = 0
    for i,attrId in ipairs(attrIds) do
        total = total + Core:GetAttributeEstimateValue(attrId, self:GetValue(attrId))
    end
    return total
end

function Attribute:GetHealAbilityEstimateValue(  )
    return self:GetValue(Constants.AttrTypeId.Hp) * 0.125 + self:GetValue(Constants.AttrTypeId.Attack)
end

function Attribute:ToString(  )
    local w = {}

    table.insert(w, "当前属性:\n")
    for k,v in pairs(Constants.AttrTypeId) do
        local value = self.values[tostring(v)]
        if not Tools.isNullKey(value) then
            table.insert(w, k)
            table.insert(w, ":          ")
            table.insert(w, value)
            table.insert(w, "\n")

        end
    end

    table.insert(w, "加成属性:\n")
    for k,v in pairs(Constants.AttrAdditionIdType) do
        local value = self.subValues[tostring(v)]
        if not Tools.isNullKey(value) then
            table.insert(w, k)
            table.insert(w, ":          ")
            table.insert(w, value)
            table.insert(w, "\n")
        end
    end

    local luckMultiplier = Core:GetBattleParamNum(Constants.BattleParam.LuckMultiplier)
    local luckAdd = Core:GetBattleParamNum(Constants.BattleParam.LuckAdd)
    local rate = self:GetValue(Constants.AttrTypeId.Luck) * luckMultiplier + luckAdd
    table.insert(w, string.format("幸运值公式结果:%f",rate))
    return table.concat( w )
end

function Attribute:LockAttr(idDict)
    for k, v in pairs(self.lockValues) do
        self.lockValues[k] = nil
    end
    
    local lockIdDict = idDict
    for k, v in pairs(lockIdDict) do
        self.lockValues[k] = self.values[k]
    end
end

function Attribute:UnlockAttr()
    for k, v in pairs(self.lockValues) do
        self.values[k] = self.lockValues[k]
    end
end

return  Attribute