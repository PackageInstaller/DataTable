--
-- Author:luqucheng
-- Date: 2019-10-24 15:45:02
--

local Core = import('Game.Battle.Core.Core')
local Formula = import('Game.Battle.Script.DamageFormula')
local Ratio = import('Game.Battle.Script.DamageRatio')

--伤害类型效果的脚本基类，如果有后续伤害类型脚本需要改变流程的，可以重写方法
local DamageEffectBase = Class("DamageEffectBase")

function DamageEffectBase:IsHit(attacker, mainTarget, effectRec, damageRec)
    --判断命中
    local attacker = attacker
    local target = damageRec.target
    local eHit = Core:GetElementCounteHit(attacker.elementType, target.elementType)
    local eDodge = Core:GetElementCounteDodge(attacker.elementType, target.elementType)
    
    local finalHit = attacker:GetAttr(Constants.AttrTypeId.Hit) + eHit 
                    - target:GetAttr(Constants.AttrTypeId.Dodge) - eDodge

    -- print("IsHit", )

    --命中率百分百则不需要随机了
    if finalHit >= 1 then
        return true
    end
    if finalHit <= 0 then
        return false
    end
    -- print( table.toString(Core.elementCounte, 'elementCounte') )
    -- print('finalhit', attacker:GetAttr(Constants.AttrTypeId.Hit), attacker:GetAttr(Constants.AttrTypeId.Dodge), eHit, eDodge, finalHit)
    return Core.Random() <= finalHit
end

--- 计算税前伤害
--@effectRec: [Game.Battle.Record.SkillEffectRecord#SkillEffectRecord]
--@damageRec: [Game.Battle.Record.DamageRecord#DamageRecord]
function DamageEffectBase:GetDamage(attacker, mainTarget, effectRec, damageRec, effectParams, damageTypeVo)
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
    local pen = attacker:GetAttr(Constants.AttrTypeId.Penetration)
    local bear = target:GetAttr(Constants.AttrTypeId.Bear)
    
    --获得毛伤害
    local dmg = self:__GetDamage(attacker, mainTarget, effectRec, damageRec)    -- 三类 按角色属性对伤害进行加成
    local ratio = self:__GetRatio(attacker, mainTarget, effectRec, damageRec, damageTypeVo)   -- 二类 控制伤害的倍率系数
    -- local crid = (1 + attacker:GetAttr(Constants.AttrTypeId.CritDamage) )
    -- local elementDamage = (1 + Core:GetElementCounteDamage(attacker.elementType, damageRec.target.elementType) )
    -- for i,v in ipairs(dmgs) do
    --     dmgs[i] = v * elementDamage
    -- end
    -- if damageRec.IsCrit then
    --     for i,v in ipairs(dmgs) do
    --         dmgs[i] = v * crid
    --     end
    -- end
    --固定的附加伤害
    -- local dmg = math.max( 0, ( atk + matk ) * (0.7 + pen - bear) )
    -- table.insert(dmgs, dmg)
    return dmg, ratio
end

function DamageEffectBase:IsCrit(attacker, mainTarget, effectRec, damageRec, damageTypeVo)
    local dmgTags = damageTypeVo.damageTags
    --判断暴击
    if not Core:DamageCanCrit(dmgTags) then
        return false
    end
    local target = damageRec.target
    local crit = attacker:GetAttr(Constants.AttrTypeId.Critical)
    local critResist = target:GetAttr(Constants.AttrTypeId.CriticalResist)
    if Core:DamageFitTag(dmgTags, Constants.DamageTag.TripleCrit) then
        crit = crit * checkNumber(damageTypeVo.damageRatioParams[1])
    end
    -- print('Critical', attacker:GetAttr(Constants.AttrTypeId.Critical))
    local rate = crit - critResist
    if rate >= 1 then
        return true
    end
    if rate <= 0 then
        return false
    end
    return Core.Random() <= rate
end

--属性克制情况
function DamageEffectBase:GetElementCounteType(attacker, mainTarget, effectRec, damageRec)
    --判断暴击
    -- print('Critical', attacker:GetAttr(Constants.AttrTypeId.Critical))
    local rate = Core:GetElementCounteDamageWithBuff(attacker, damageRec.target)
    -- if rate > 0 then
    --     return 1
    -- elseif rate < 0 then
    --     return -1
    -- else
    --     return 0
    -- end
    return rate
end

-- 三类 按角色属性对伤害进行加成
function DamageEffectBase:__GetDamage( attacker, mainTarget, effectRec, damageRec)
    local formulaName = string.format("Formula%d", effectRec.effectData.miniEffectType)
    local param = effectRec.effectData.effectNum1
    for i,v in ipairs(param) do
        param[i] = param[i] - (RandomShift or 23)
    end
    local dmg = Formula[formulaName](attacker, mainTarget, effectRec, damageRec)
    for i,v in ipairs(param) do
        param[i] = param[i] + (RandomShift or 23)
    end
    return dmg
end

-- 二类 伤害倍率计算公式
function DamageEffectBase:__GetRatio(attacker, mainTarget, effectRec, damageRec, damageTypeVo)
    local formulaName = string.format("Formula%d", effectRec.effectData.subEffectType)
    local func = Ratio[formulaName]
    if not func then
        return 1
    end
    local param = effectRec.effectData.effectNum1
    for i,v in ipairs(param) do
        param[i] = param[i] - (RandomShift or 23)
    end
    local ratio = func(attacker, mainTarget, effectRec, damageRec, nil, damageTypeVo.damageRatioParams)
    for i,v in ipairs(param) do
        param[i] = param[i] + (RandomShift or 23)
    end
    return ratio
end

-- function DamageEffectBase:GetFinalDamage(skillRec, effectRec, damageRec)
--     local dmg = self:GetDamage(skillRec, effectRec)

--     --返回对于每个目标的真实伤害
-- end

return DamageEffectBase