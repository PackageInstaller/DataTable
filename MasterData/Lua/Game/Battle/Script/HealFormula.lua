local HealFormula = {}

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula1( attacker, mainTarget, effectRec, damageRec)
    return attacker:GetAttr(Constants.AttrTypeId.Attack) * effectRec.effectData.effectNum1[1]
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula2( attacker, mainTarget, effectRec, damageRec)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    return attacker:GetAttr(Constants.AttrTypeId.Hp) * param[1]
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula3( attacker, mainTarget, effectRec, damageRec)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    return target:GetAttr(Constants.AttrTypeId.Hp) * param[1]
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula4( attacker, mainTarget, effectRec, damageRec)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    local lostHP = target:GetAttr(Constants.AttrTypeId.Hp) - target:GetAttr(Constants.AttrTypeId.NowHp)

    return lostHP * param[1]
end

--根据所有敌方身上buffId=Num5的buff层数总和造成治疗
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula5( attacker, mainTarget, effectRec, damageRec)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    local totalLayNum = 0
    local rs = BattleMgr:GetAliveRoles(BattleMgr:GetOppoCamp(attacker.camp))
    for j,role in ipairs(rs) do
        role.buffMgr:WalkAllBuff(function ( v )
            if v.buffID == param[4] then
                totalLayNum = totalLayNum + math.max( 1, v.layNum )
            end
        end)
    end

    return (attacker:GetAttr(Constants.AttrTypeId.Hp) * param[1] ) * (param[2] + totalLayNum * param[3])
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula6( attacker, mainTarget, effectRec, damageRec )
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    local totalHpChange = 0
    local dmgs = BattleMgr:GetNowSkillDamageRecs()
    for i,v in ipairs(dmgs) do
        if v:IsDamage() then
            totalHpChange = totalHpChange + v.hpChange
        end
    end
    return totalHpChange * param[1]
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula7( attacker, mainTarget, effectRec, damageRec )
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    local shieldValue = 0
    attacker.buffMgr:WalkAllBuffEffects(function ( v )
        if v.buff.buffID == param[2] and v.data.mainEffectType == Constants.BuffType.Shield then
            shieldValue = shieldValue + v:GetValue()
        end
    end)

    return shieldValue * param[1]
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula8( attacker, mainTarget, effectRec, damageRec )
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target
    local maxHp = target:GetAttr(Constants.AttrTypeId.Hp)
    local def = target:GetAttr(Constants.AttrTypeId.Defense)


    return def * param[1] + maxHp * param[2]
end

--按BUFFID层数造成治疗
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula9( attacker, mainTarget, effectRec, damageRec )
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    local totalLayNum = 0
    attacker.buffMgr:WalkAllBuff(function ( v )
        if v.buffID == param[2] then
            totalLayNum = totalLayNum + math.max( 1, v.layNum )
        end
    end)

    return totalLayNum * param[1]
end

--按BUFF自身层数造成治疗
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula10( attacker, mainTarget, effectRec, damageRec )
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    local buff = BattleMgr:GetNowTriggerBuff()
    if not buff then
        return 0
    end

    return buff.layNum * param[1]
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula11( attacker, mainTarget, effectRec, damageRec )
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    local totalHpChange = 0
    local dmgs = BattleMgr:GetNowSkillDamageRecs()

    local targetIds = {}
    for i, v in ipairs(dmgs) do
        local targetId = v.targetId
        if not table.isContain(targetIds, targetId) then
            table.insert(targetIds, targetId)
        end
    end

    local ids = {}
    for i, targetId in ipairs(targetIds) do
        local target = Core:FindRole(targetId)
        if target.buffMgr:HasBuffByBuffTypeID(param[2]) then
            table.insert(ids, target.id)
        end
    end

    for i,v in ipairs(dmgs) do
        if v:IsDamage() and table.isContain(ids, v.targetId) then
            totalHpChange = totalHpChange + v.hpChange
        end
    end
    return totalHpChange * param[1]
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function HealFormula.Formula12( attacker, mainTarget, effectRec, damageRec )
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    local sourceType = param[2]     -- 来源类型 1 自身 2 全队

    local shieldValue = 0
    if sourceType == 1 then
        attacker.buffMgr:WalkAllBuffEffects(function ( v )
            if v.data.mainEffectType == Constants.BuffType.Shield then
                shieldValue = shieldValue + v:GetValue()
            end
        end)
    elseif sourceType == 2 then
        local roles = BattleMgr:GetAliveRoles(attacker.camp)
        for i, role in ipairs(roles) do
            role.buffMgr:WalkAllBuffEffects(function ( v )
                if v.data.mainEffectType == Constants.BuffType.Shield then
                    shieldValue = shieldValue + v:GetValue()
                end
            end)
        end
    end

    return shieldValue * param[1]
end

-- 治疗量=攻击者身上buffID=num1上HOT效果单回合生效量*Num2（没有则不生效）
function HealFormula.Formula13( attacker, mainTarget, effectRec, damageRec )
    local param = effectRec.effectData.effectNum1

    local healNum = 0
    local HotType = Constants.BuffType.Hot
    attacker.buffMgr:WalkAllBuff(function(buff)
        if buff.buffID == param[1] then
            buff:WalkAllEffects(function(buffEffect)
                if buffEffect.data.mainEffectType == HotType then
                    local dmg, dmgType = buffEffect:GetValue()
                    healNum = healNum + dmg
                    return true
                end
            end)
            return true
        end
    end)

    return healNum * param[2]
end

-- 治疗量=我方全体当前攻击力之和*Num1
function HealFormula.Formula14( attacker, mainTarget, effectRec, damageRec )
    local param = effectRec.effectData.effectNum1

    local totalAtk = 0

    local camp = attacker.camp
    local roles = BattleMgr:GetAliveRoles(camp)
    for i, role in ipairs(roles) do
        totalAtk = totalAtk + role:GetAttr(Constants.AttrTypeId.Attack)
    end

    return totalAtk * param[1]
end

-- 治疗量=《目标表》ID=num2的目标atk*Num1
function HealFormula.Formula15( attacker, mainTarget, effectRec, damageRec )
    local param = effectRec.effectData.effectNum1
    local num1 = param[1]
    local num2 = param[2]

    local atk = mainTarget:GetAttr(Constants.AttrTypeId.Attack)

    local roles = BattleMgr:GetAliveRoles()
    local targets = Core:SelectTargets(num2, attacker, mainTarget, roles)
    if #targets == 0 then
        return 0
    else
        local target = targets[#targets]
        local atk = target:GetAttr(Constants.AttrTypeId.Attack)
        return atk * num1
    end
end

-- function HealFormula.Formula7( attacker, mainTarget, effectRec, damageRec )
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
--     local target = damageRec.target
--     local lostHP = target:GetAttr(Constants.AttrTypeId.Hp) - target:GetAttr(Constants.AttrTypeId.NowHp)
--     local param = effectRec.effectData.effectNum1
--     return atk * param[1] + matk * param[2] + lostHP * param[3]
-- end



-- --恢复目标生命，会根据DEBUFF数量*NUM2获得百分比提升，最多判断NUM3层
-- function HealFormula.Formula8( attacker, mainTarget, effectRec, damageRec )
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1
--     --@RefType [Game.Battle.Entity.Role#Role]
--     local target = damageRec.target

--     local debuffNum = target.buffMgr:GetBuffOrDebuffNum(true)
--     debuffNum = math.min( debuffNum, param[3] )

--     return atk * param[1] * (1 + param[2] * debuffNum)
-- end

-- --恢复自身百分比的生命值
-- function HealFormula.Formula9( attacker, mainTarget, effectRec, damageRec )
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
--     local hp = attacker:GetAttr(Constants.AttrTypeId.Hp)
--     local param = effectRec.effectData.effectNum1
--     local target = damageRec.target
    
--     return hp * param[1]
-- end

-- function HealFormula.Formula10( attacker, mainTarget, effectRec, damageRec )
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
--     local param = effectRec.effectData.effectNum1
--     local target = damageRec.target
--     local hp = target:GetAttr(Constants.AttrTypeId.Hp)
    
--     return hp * param[1]
-- end

-- --根据本次技能里非自然移除的DEBUFF产生治疗
-- --@otherEffects: [Game.Battle.Record.SkillEffectRecord#SkillEffectRecord<>]
-- function HealFormula.Formula201( attacker, mainTarget, effectRec, damageRec, otherEffects )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local totalClearNum = 0
--     for i,v in ipairs(otherEffects) do
--         if v and v.debuffClearLayNum and v.debuffClearLayNum > 0 then
--             totalClearNum = totalClearNum + v.debuffClearLayNum
--         end
--     end

--     return atk * param[1] * totalClearNum
-- end

-- --根据对方流血效果的数量恢复生命值,判断时不得超过NUM2层
-- function HealFormula.Formula202( attacker, mainTarget, effectRec, damageRec )
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1
--     local target = damageRec.target

--     local DotType = Constants.BuffType.Dot
--     local Bleed = Constants.DotType.Bleed
--     local bleedNum = 0
--     for i,buff in ipairs(target.buffMgr.buffs) do
--         if buff.data.subEffectType == DotType and buff.data.miniEffectType == Bleed then
--             bleedNum = bleedNum + 1
--         end
--     end
--     bleedNum = math.min( bleedNum, param[2] )

--     return atk * param[1] * bleedNum
-- end

return HealFormula