--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2019-10-29 13:54:38
]]

local DamageFormula = {}
--@effectRec: [Game.Battle.Record.SkillEffectRecord#SkillEffectRecord]
function DamageFormula.Formula1( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    return atk * param[1]
end


--根据自身防御力判定伤害
function DamageFormula.Formula2( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local def = attacker:GetAttr(Constants.AttrTypeId.Defense)
    local param = effectRec.effectData.effectNum1

    return def * param[1]
end


--根据自身血量判定伤害
function DamageFormula.Formula3( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local hp = attacker:GetAttr(Constants.AttrTypeId.Hp)

    return hp * param[1]
end

--根据自身当前血量判定伤害
function DamageFormula.Formula4( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local nowHp = attacker:GetAttr(Constants.AttrTypeId.NowHp)

    return nowHp * param[1]
end

--根据目标血量判定伤害
function DamageFormula.Formula5( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local hp = target:GetAttr(Constants.AttrTypeId.Hp)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)

    return math.min(hp * param[1], atk * param[2]) 
end

--根据目标当前血量判定伤害
function DamageFormula.Formula6( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local nowHp = target:GetAttr(Constants.AttrTypeId.NowHp)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)

    return math.min(nowHp * param[1], atk * param[2]) 
end

--按技能对目标的跳字量造成伤害
function DamageFormula.Formula7( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1

    local preDamageRecs = BattleMgr:GetNowSkillDamageRecs()

    local preDamages = 0
    for i,rec in ipairs(preDamageRecs) do
        if rec.targetId == target.id and rec:IsDamage() then
            preDamages = preDamages + rec.finalDamage
        end
    end

    return preDamages * param[1]
end

--按BUFFID层数造成伤害
function DamageFormula.Formula8( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local totalLayNum = 0
    attacker.buffMgr:WalkAllBuff(function ( v )
        if v.buffID == param[3] then
            totalLayNum = totalLayNum + math.max( 1, v.layNum )
        end
    end)

    return atk * param[1] + totalLayNum * param[2]
end

--按BUFF自身层数造成伤害
function DamageFormula.Formula9( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local totalLayNum = 0
    
    --寻找触发器buff
    local buff = BattleMgr:GetNowTriggerBuff()
    if not buff then
        return 0
    end
 
    return buff.layNum * param[1]
end

-- 按目标最大血量造成伤害
function DamageFormula.Formula10( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local hp = target:GetAttr(Constants.AttrTypeId.Hp)

    return math.min(hp * param[1], param[2]) 
end

-- 按目标当前血量造成伤害
function DamageFormula.Formula11( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local hp = target:GetAttr(Constants.AttrTypeId.NowHp)

    return math.min(hp * param[1], param[2]) 
end

-- 按自己攻击力百分比+固定值造成伤害
function DamageFormula.Formula12( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)

    return atk * param[1] + param[2]
end

--min(min[DOT当前层数,num4]*剩余回合*当前每跳伤害*NUM1,AKT*NUM2),NUM3(DOT的类型)
function DamageFormula.Formula13( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local DotType = Constants.BuffType.Dot

    local totalDamage = 0
    local maxLayer = param[4]

    target.buffMgr:WalkAllBuffEffects(function ( buffEffect )
        local buff = buffEffect.buff
        if maxLayer > 0 and buffEffect.data.mainEffectType == DotType and param[3] == buffEffect.data.subEffectType then
            --结算伤害，直接单次伤害乘以剩余回合数
            totalDamage = totalDamage + buffEffect:GetValue() * buff.remainRound * math.min(buff.layNum, maxLayer)
            maxLayer = maxLayer - buff.layNum
        end
    end)

    return math.min(totalDamage * param[1], atk * param[2])
end

--min(min[DOT当前层数,num4]*1回合*当前每跳伤害*NUM1,AKT*NUM2),NUM3(DOT的类型)（和13相比，不计算剩余回合数，只计算1回合伤害）
function DamageFormula.Formula14( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local DotType = Constants.BuffType.Dot

    local totalDamage = 0
    local maxLayer = param[4]

    target.buffMgr:WalkAllBuffEffects(function ( buffEffect )
        local buff = buffEffect.buff
        if maxLayer > 0 and buffEffect.data.mainEffectType == DotType and param[3] == buffEffect.data.subEffectType then
            --结算伤害，只计算一回合的伤害
            totalDamage = totalDamage + buffEffect:GetValue() * math.min(buff.layNum, maxLayer)
            maxLayer = maxLayer - buff.layNum
        end
    end)

    return math.min(totalDamage * param[1], atk * param[2])
end

-- 按护盾剩余量造成伤害
function DamageFormula.Formula15( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local shieldValue = 0
    attacker.buffMgr:WalkAllBuffEffects(function ( v )
        if (v.buff.buffID == param[2] or param[2] == 0) and v.data.mainEffectType == Constants.BuffType.Shield then
            shieldValue = shieldValue + v:GetValue()
        end
    end)
    return shieldValue * param[1]
end

--造成自己攻击力*Num1的伤害，目标每有1%当前生命值，基础伤害量增加Num2*攻击力，至多造成Num3*攻击力的伤害
--atk*NUM1*(1+target_nowHp/target_maxHp*NUM2*100)，num3=最大伤害系数
function DamageFormula.Formula16( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1
    local nowHp = target:GetAttr(Constants.AttrTypeId.NowHp)
    local hp = target:GetAttr(Constants.AttrTypeId.Hp)

    return math.min(atk * param[1] * (1 + nowHp / hp * param[2] * 100), atk * param[3])
end

-- 造成自己攻击力（Num1*100%）的伤害，自身每有一层id=Num3的buff，伤害系数增加Num2*100%
-- atk*（NUM1+Num2*指定buff层数），Num3=指定buff的id
function DamageFormula.Formula17( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local totalLayNum = 0
    attacker.buffMgr:WalkAllBuff(function ( v )
        if v.buffID == param[3] then
            totalLayNum = totalLayNum + math.max( 1, v.layNum )
        end
    end)

    return atk * (param[1] + totalLayNum * param[2])
end

-- 造成自己攻击力（Num1*100%）的伤害，自身每有一个类型为Num3的buff，造成基础伤害提升Num2*100%，叠层的buff只算1个
-- atk*NUM1*（1+Num2*指定类型的buff数量），Num3=指定buff类型（0:全部；1:增益；2:减益），叠层的buff只算1个
function DamageFormula.Formula18(attacker, mainTarget, effectRec, damageRec)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local num1 = param[1]
    local num2 = param[2]
    local num3 = param[3]
    local num4 = param[4]

    local num5 = param[5] or 0
    local num6 = param[6] or 0
    local num7 = param[7] or 0

    local buffNum = attacker.buffMgr:GetBuffTypeNumber(num5, num6, num7, num3)

    return atk * num1 * (1 + math.min(num2 * buffNum, num4))
end

-- 造成全队存活队员的当前攻击力（NUM1*100%）的伤害
-- teamAtk*NUM1
function DamageFormula.Formula19(attacker, mainTarget, effectRec, damageRec)
    local teamAtk = 0
    local roles = BattleMgr:GetAliveRolesWithoutSpecialSummon(attacker.camp)
    for i, role in ipairs(roles) do
        local atk = role:GetAttr(Constants.AttrTypeId.Attack)
        teamAtk = teamAtk + atk
    end

    local param = effectRec.effectData.effectNum1
    local num1 = param[1]

    return teamAtk * num1
end

-- 按自己攻击力造成伤害，根据自己身上指定buff的层数，大于等于一定层数时，获得不同的增益
-- atk*NUM1*(1+Num4*100%)，num2为指定buffid，num3为增伤的层数判定
-- 配置示例  0.5;1900601; 1;3;8; 0.2;0.4;0.8
function DamageFormula.Formula20(attacker, mainTarget, effectRec, damageRec)
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local num1 = param[1]   -- 攻击力系数
    local num2 = param[2]   -- buffId
    local count = (#param - 2)   -- buff增伤系数公式 参数数量
    assert(count % 2 == 0, '参数数目必须为偶数')
    local levelCount = num_floor(count / 2)

    local totalLayNum = 0
    attacker.buffMgr:WalkAllBuff(function ( v )
        if v.buffID == num2 then
            totalLayNum = totalLayNum + math.max( 1, v.layNum )
        end
    end)

    local num4 = 0
    for i = 1, levelCount, 1 do
        if totalLayNum >= param[2 + i] then
            num4 = param[2 + levelCount + i]
        end
    end

    return atk * num1 * (1 + num4)
end

-- 造成自己攻击力（NUM1*100%）的伤害，牌库中每张类型为NUM2（技能牌逻辑表lable）（1、buff；2、进攻；3、DEBUFF；4、恢复）的技能牌，基础伤害量增加NUM3×100%，至多提升Num4*100%
-- atk*（NUM1×（1+min(牌库中num2类技能牌数量×num3,num4）)
function DamageFormula.Formula21(attacker, mainTarget, effectRec, damageRec)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1
    local num1 = param[1]
    local num2 = param[2]
    local num3 = param[3]
    local num4 = param[4]

    local cardMgr = attacker:GetCardMgr()
    if cardMgr == nil then
        return atk * num1 * (1 + math.min(0 * num3, num4))
    end

    -- 找到符合条件的卡牌
    local cards = cardMgr:FindCardsByFunc(function (card)
        local skillCard = cardMgr:GetSkillCard(card)
        local label = skillCard.label
        return label == num2
    end)

    local cardsNum = #cards

    return atk * num1 * (1 + math.min(cardsNum * num3, num4))
end

-- 造成自己攻击力（NUM1*100%）的伤害，使用技能牌时吞噬的牌每有1星，伤害提升num2（0-3）
-- atk*（NUM1×（1+技能牌吞噬的牌星级×num2）
function DamageFormula.Formula22(attacker, mainTarget, effectRec, damageRec)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1
    local num1 = param[1]
    local num2 = param[2]

    local star = 0

    local skillRecord = BattleMgr:GetNowSkillRecord()
    if skillRecord then
        local params = skillRecord.skillCardParams
        if params then
            local swallowCard = params.swallowCard
            if swallowCard then
                star = swallowCard.star
            end
        end
    end

    return atk * num1 * (1 + math.min(star, 3) * num2)
end

-- 造成自己攻击力（Num1*100%）的伤害，自身每有一个类型为Num3的buff，造成基础伤害提升Num2*100%
-- atk*NUM1*（1+Num2*指定类型的buff数量），Num3=指定buff类型（0:全部；1:增益；2:减益）
function DamageFormula.Formula23(attacker, mainTarget, effectRec, damageRec)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1
    local target = damageRec.target

    local num1 = param[1]
    local num2 = param[2]
    local num3 = param[3]
    local num4 = param[4]

    local num5 = param[5] or 0
    local num6 = param[6] or 0
    local num7 = param[7] or 0

    local layerNum = target.buffMgr:GetBuffTypeLayNum(num5, num6, num7, num3)

    if Config and (type(Config.DEBUG) ~= "boolean" or Config.DEBUG == false) then
    else
        print(string.format("[dmg] 三类23  %.2f = %.2f * %.2f * (1 + math.min(%.2f * %d, %.2f))", atk * num1 * (1 + math.min(num2 * layerNum, num4)), atk, num1, num2, layerNum, num4), table.dump(param, nil, 3))
    end

    return atk * num1 * (1 + math.min(num2 * layerNum, num4))
end

-- SP点数增伤
-- atk*（NUM1×（1+当前sp点数×num2）
function DamageFormula.Formula24(attacker, mainTarget, effectRec, damageRec)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local num1 = param[1]
    local num2 = param[2]

    local curSPNum = attacker:GetUltraPoint()

    return atk * num1 * (1 + curSPNum * num2)
end

--按技能的跳字量造成伤害
function DamageFormula.Formula25( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1

    local preDamageRecs = BattleMgr:GetNowSkillDamageRecs()

    local preDamages = 0
    for i,rec in ipairs(preDamageRecs) do
        if rec:IsDamage() then
            preDamages = preDamages + rec.finalDamage
        end
    end

    return preDamages * param[1]
end

-- 按我方全体剩余护盾量造成伤害
function DamageFormula.Formula26( attacker, mainTarget, effectRec, damageRec )
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local camp = attacker.camp
    local roles = BattleMgr:GetAliveRoles(camp)

    local Shield = Constants.BuffType.Shield
    local shieldValue = 0
    for i, role in ipairs(roles) do
        role.buffMgr:WalkAllBuffEffects(function ( v )
            if v.data.mainEffectType == Shield then
                shieldValue = shieldValue + v:GetValue()
            end
        end)
    end

    return math.min(shieldValue * param[1], atk * param[2])
end

-- 按触发器传入总伤害造成伤害(格挡减伤前)
function DamageFormula.Formula27(attacker, mainTarget, effectRec, damageRec)
    local param = effectRec.effectData.effectNum1
    local num1 = param[1]

    return attacker.roleContextData.beAtkDataInSkillRange.fdmgBeforeNormalDamageChange * num1
end

-- 按触发器传入1801格挡部分伤害造成伤害
function DamageFormula.Formula28(attacker, mainTarget, effectRec, damageRec)
    local param = effectRec.effectData.effectNum1
    local num1 = param[1]

    -- normalDamageChangeValue有正有负，这里取一下绝对值
    return math.abs(attacker.roleContextData.beAtkDataInSkillRange.normalDamageChangeValue) * num1
end

-- 按目标已损生命值造成伤害
function DamageFormula.Formula29(attacker, mainTarget, effectRec, damageRec)
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local target = damageRec.target
    local hp = target:GetAttr(Constants.AttrTypeId.Hp)
    local nowHp = target:GetAttr(Constants.AttrTypeId.NowHp)
    local deltaHp = hp - nowHp

    local param = effectRec.effectData.effectNum1
    local num1 = param[1]
    local num2 = param[2]

    return math.min(deltaHp * num1, atk * num2)
end

-- 按自身自身攻击力造成伤害，存在特殊计数器时伤害提升
function DamageFormula.Formula30( attacker, mainTarget, effectRec, damageRec )
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    return atk * param[1] + attacker.roleContextData:GetRegister1() * param[2]
end

-- 按自身自身攻击力造成伤害，不超过特殊计数器的x%
function DamageFormula.Formula31( attacker, mainTarget, effectRec, damageRec )
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    return math.min(atk * param[1], attacker.roleContextData:GetRegister1() * param[2])
end

-- 按目标BUFFID层数造成伤害
function DamageFormula.Formula32( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local totalLayNum = 0
    target.buffMgr:WalkAllBuff(function ( v )
        if v.buffID == param[3] then
            totalLayNum = totalLayNum + math.max( 1, v.layNum )
        end
    end)
    return atk * (param[1] + totalLayNum * param[2])
end

-- 按目标BUFFID层数造成伤害(两个buffID)
function DamageFormula.Formula33( attacker, mainTarget, effectRec, damageRec )
    local target = damageRec.target
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    local totalLayNum1 = 0
    local totalLayNum2 = 0
    target.buffMgr:WalkAllBuff(function ( v )
        if v.buffID == param[3] then
            totalLayNum1 = totalLayNum1 + math.max( 1, v.layNum )
        end
        if v.buffID == param[5] then
            totalLayNum2 = totalLayNum2 + math.max( 1, v.layNum )
        end
    end)

    return atk * (param[1] + totalLayNum1 * param[2] + totalLayNum2 * param[4])
end

-- 按自身自身攻击力造成伤害，存在特殊计数器时伤害提升
function DamageFormula.Formula34( attacker, mainTarget, effectRec, damageRec )
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local param = effectRec.effectData.effectNum1

    return atk * (param[1] + math.min(attacker.roleContextData:GetRegister1() * param[2], param[3]))
end

-- 暴击时额外提升伤害  atk*（NUM1+ ifcrit Min（crit*Num2，Num3)）
function DamageFormula.Formula35( attacker, mainTarget, effectRec, damageRec )
    local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    local crit = attacker:GetAttr(Constants.AttrTypeId.Critical)
    local param = effectRec.effectData.effectNum1
    local isCrit = damageRec.isCrit

    return atk * (param[1] + (isCrit and math.min(crit * param[2], param[3]) or 0))
end

-- --造成目标最大生命值的伤害,不超过攻击力的NUM2倍
-- function DamageFormula.Formula3( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)

--     local targetHp = target:GetAttr(Constants.AttrTypeId.Hp)

--     return math.min(targetHp * param[1], atk * param[2]) 
-- end


-- --根据目标损失的血量判定伤害
-- function DamageFormula.Formula3( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1
--     local lostHpPer = (target:GetAttr(Constants.AttrTypeId.Hp)  - target:GetAttr(Constants.AttrTypeId.NowHp))/ target:GetAttr(Constants.AttrTypeId.Hp)

--     return atk * param[1] * (1 + lostHpPer * param[2] * 100)
-- end


-- --（起爆伤害）计算伤害时，根据目标身上的能量豆数量造成额外伤害的伤害类型
-- function DamageFormula.Formula4( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1
--     local spPoint = target:GetUltraPoint()

--     return atk * param[1] * (1 + spPoint * param[2])
-- end

-- --（1、破裂伤害，2、弱点伤害）根据目标身上所拥有的增减益BUFF的种类计算伤害，NUM4表示增减益（1、增益,2、减益）
-- function DamageFormula.Formula5( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local num = target.buffMgr:GetBuffOrDebuffNum(param[4] == 2)

--     return atk * param[1] * (1 + math.min(num, param[3] or 999) * param[2] )
-- end

-- --（1、破裂伤害，2、弱点伤害）根据自身身上所拥有的增减益BUFF的种类计算伤害，NUM4表示增减益（1、增益,2、减益）
-- function DamageFormula.Formula6( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local num = attacker.buffMgr:GetBuffOrDebuffNum(param[4] == 2)

--     return atk * param[1] * (1 + math.min(num, param[3] or 999) * param[2] )
-- end

-- --造成攻击力（NUM1*100%）的伤害，根据自己身上（ID=NUM3）的buff的叠加层数总和造成额外伤害，每一层提升攻击力的（NUM2*100%）
-- function DamageFormula.Formula7( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local totalLayNum = 0
--     attacker.buffMgr:WalkAllBuff(function ( v )
--         if v.buffID == param[3] then
--             totalLayNum = totalLayNum + math.max( 1, v.layNum )
--         end
--     end)

--     return atk * param[1] * (1 + math.min(totalLayNum, param[4] or 999) * param[2])
-- end

-- --造成攻击力（NUM1*100%）的伤害，根据目标身上（ID=NUM3）的buff的叠加层数总和造成额外伤害，每一层提升攻击力的（NUM2*100%）
-- function DamageFormula.Formula8( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local totalLayNum = 0
--     target.buffMgr:WalkAllBuff(function ( v )
--         if v.buffID == param[3] then
--             totalLayNum = totalLayNum + math.max( 1, v.layNum )
--         end
--     end)

--     return atk * param[1] * (1 + math.min(totalLayNum, param[4] or 999) * param[2])
-- end


-- --根据目标当前血量值计算伤害,不超过攻击力的NUM2倍
-- function DamageFormula.Formula11( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local targetNowHp = target:GetAttr(Constants.AttrTypeId.NowHp)

--     return math.min(targetNowHp * param[1], atk * param[2]) 
-- end

-- --根据目标当前血量值计算伤害,不超过NUM2
-- function DamageFormula.Formula12( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local targetHp = target:GetAttr(Constants.AttrTypeId.Hp)

--     return math.min(targetHp * param[1], param[2]) 
-- end


-- --min(min[DOT当前层数,num4]*剩余回合*当前每跳伤害*NUM1,AKT*NUM2),NUM3(DOT的类型)
-- function DamageFormula.Formula13( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local DotType = Constants.BuffType.Dot

--     local totalDamage = 0
--     local maxLayer = param[4]

--     target.buffMgr:WalkAllBuffEffects(function ( buffEffect )
--         local buff = buffEffect.buff
--         if maxLayer > 0 and buffEffect.data.mainEffectType == DotType and param[3] == buffEffect.data.subEffectType then
--             --结算伤害，直接单次伤害乘以剩余回合数
--             totalDamage = totalDamage + buffEffect:GetValue() * buff.remainRound * math.min(buff.layNum, maxLayer)
--             maxLayer = maxLayer - buff.layNum
--         end
--     end)

--     return math.min(totalDamage * param[1], atk * param[2])
-- end

-- --对目标造成攻击力num1的伤害，目标的最大生命值每高出自己1%，造成的基础伤害就会提升num2，最多能提升num3
-- function DamageFormula.Formula14( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local targetHp = target:GetAttr(Constants.AttrTypeId.Hp)
--     local attackerHp = attacker:GetAttr(Constants.AttrTypeId.Hp)

--     return atk * param[1] * (1 + math.min( param[2] * 100 * (math.max(targetHp / attackerHp, 1) - 1), param[3]) )
-- end

-- --巨人公式，伤害公式=攻击力*num1+自身最大生命值*num2
-- function DamageFormula.Formula15( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local attackerHp = attacker:GetAttr(Constants.AttrTypeId.Hp)

--     return atk * param[1] + attackerHp * param[2]
-- end

-- function DamageFormula.Formula16( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local attackerHp = attacker:GetAttr(Constants.AttrTypeId.Hp)
--     local lostHpPer = (attacker:GetAttr(Constants.AttrTypeId.Hp) - attacker:GetAttr(Constants.AttrTypeId.NowHp)) / attacker:GetAttr(Constants.AttrTypeId.Hp)

--     return (atk * param[1] + attackerHp * param[2]) * ( 1 + lostHpPer * param[3] * 100)
-- end

-- function DamageFormula.Formula17( attacker, mainTarget, effectRec, damageRec, otherEffects, skillCardParams )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1


--     local p = 0
--     if skillCardParams and skillCardParams.swallowCard then
--         p = skillCardParams.swallowCard.star
--     end

--     return atk * param[1] * (1 + p * param[2])
-- end

-- function DamageFormula.Formula18( attacker, mainTarget, effectRec, damageRec, otherEffects, skillCardParams )
--     local target = damageRec.target
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local param = effectRec.effectData.effectNum1

--     local shieldValue = 0
--     attacker.buffMgr:WalkAllBuffEffects(function ( v )
--         if (v.buff.buffID == param[2] or param[2] == 0) and v.data.mainEffectType == Constants.BuffType.Shield then
--             shieldValue = shieldValue + v:GetValue()
--         end
--     end)
--     return shieldValue * param[1]
-- end

-- --min(目标当前hp*num1，当前生命值-1）
-- function DamageFormula.Formula19( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local nowHp = target:GetNowHp()
--     local param = effectRec.effectData.effectNum1

--     return math.min(nowHp * param[1], nowHp - 1)
-- end

-- --min(目标maxHp*num1，当前生命值-1）
-- function DamageFormula.Formula20( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local maxHp = target:GetAttr(Constants.AttrTypeId.Hp)
--     local nowHp = target:GetNowHp()
--     local param = effectRec.effectData.effectNum1
--     return math.min(maxHp * param[1], nowHp - 1)

-- end

-- --固定伤害
-- function DamageFormula.Formula21( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local param = effectRec.effectData.effectNum1
--     return param[1]
-- end

-- function DamageFormula.Formula22( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local param = effectRec.effectData.effectNum1
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local hpPer = target:GetAttr(Constants.AttrTypeId.NowHp) / target:GetAttr(Constants.AttrTypeId.Hp)
--     if hpPer >= param[3] then
--         return atk * param[1] * (1 + param[2])
--     end
--     return atk * param[1]
-- end


-- function DamageFormula.Formula23( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local param = effectRec.effectData.effectNum1
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local hpPer = target:GetAttr(Constants.AttrTypeId.NowHp) / target:GetAttr(Constants.AttrTypeId.Hp)
--     if hpPer <= param[3] then
--         return atk * param[1] * (1 + param[2])
--     end
--     return atk * param[1]
-- end

-- function DamageFormula.Formula24( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local param = effectRec.effectData.effectNum1
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local hpPer = attacker:GetAttr(Constants.AttrTypeId.NowHp) / attacker:GetAttr(Constants.AttrTypeId.Hp)
--     if hpPer >= param[3] then
--         return atk * param[1] * (1 + param[2])
--     end
--     return atk * param[1]
-- end


-- function DamageFormula.Formula25( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local param = effectRec.effectData.effectNum1
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
--     local hpPer = attacker:GetAttr(Constants.AttrTypeId.NowHp) / attacker:GetAttr(Constants.AttrTypeId.Hp)
--     if hpPer <= param[3] then
--         return atk * param[1] * (1 + param[2])
--     end
--     return atk * param[1]
-- end

-- function DamageFormula.Formula26( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local param = effectRec.effectData.effectNum1
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    
--     local player = BattleMgr:GetPlayer(attacker.camp)
--     local num = 0
--     if player.cardMgr then
--         local cards = player.cardMgr:FindCardsByFunc(function (card, pos)
--             local skillCardData = player.cardMgr:GetCardSkillByPos(pos)
--             return skillCardData.label == param[3]
--         end)
--         num = #cards
--     end
--     return atk * param[1] * (1 + num * param[2])
-- end

-- function DamageFormula.Formula27( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local param = effectRec.effectData.effectNum1
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    
--     local player = BattleMgr:GetPlayer(attacker.camp)
--     local num = 0
--     if player.cardMgr then
--         local cards = player.cardMgr:FindCardsByFunc(function (card, pos)
--             local skillCardData = player.cardMgr:GetCardSkillByPos(pos)
--             return skillCardData.id == param[3]
--         end)
--         num = #cards
--     end
--     return atk * param[1] * (1 + num * param[2])
-- end

-- function DamageFormula.Formula28( attacker, mainTarget, effectRec, damageRec )
--     local target = damageRec.target
--     local param = effectRec.effectData.effectNum1
--     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
    
--     local player = BattleMgr:GetPlayer(attacker.camp)
--     local num = 0
--     if player.cardMgr then
--         local cards = player.cardMgr:FindCardsByFunc(function (card, pos)
--             if param[3] == 0 then
--                 return true
--             else
--                 return card.roleId == attacker.id
--             end
--         end)
--         num = #cards
--     end
--     return atk * param[1] * (1 + num * param[2])
-- end

-- -- --造成攻击力（num1*100%）的伤害，根据主要目标身上（ID=NUM3）的buff叠加层数总和和造成额外伤害，主目标每一层buff提升攻击力（num2*100%）
-- -- function DamageFormula.Formula13( attacker, mainTarget, effectRec, damageRec )
-- --     local target = damageRec.target
-- --     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
-- --     local param = effectRec.effectData.effectNum1

-- --     local totalLayNum = 0
-- --     for i,v in ipairs(mainTarget.buffMgr.buffs) do
-- --         if v.buffID == param[3] then
-- --             totalLayNum = totalLayNum + math.max( 1, v.layNum )
-- --         end
-- --     end

-- --     return atk * param[1] + atk * totalLayNum * param[2]
-- -- end

-- -- --根据目标身上的某个ID的BUFF的层数计算伤害
-- -- function DamageFormula.Formula8( attacker, mainTarget, effectRec, damageRec )
-- --     --@RefType [Game.Battle.Entity.Role#Role]
-- --     local target = damageRec.target
-- --     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
-- --     local param = effectRec.effectData.effectNum1
-- --     local pen = attacker:GetAttr(Constants.AttrTypeId.Penetration)
-- --     local bear = target:GetAttr(Constants.AttrTypeId.Bear)

-- --     local totalLayNum = 0
-- --     for i,v in ipairs(target.buffMgr.buffs) do
-- --         if v.buffID == param[3] then
-- --             totalLayNum = totalLayNum + math.min( 1, v.layNum )
-- --         end
-- --     end

-- --     return atk * param[1] * (1 + totalLayNum * param[2]), atk * (Constants.PenetrateRate + pen - bear)
-- -- end




-- -- --（1、增幅伤害，2、一般不给卡牌作减益提升）根据攻击者身上所拥有的增减益BUFF的种类计算伤害，NUM4表示增减益（1、增益,2、减益）
-- -- function DamageFormula.Formula13( attacker, mainTarget, effectRec, damageRec )
-- --     local target = damageRec.target
-- --     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
-- --     local param = effectRec.effectData.effectNum1
-- --     local pen = attacker:GetAttr(Constants.AttrTypeId.Penetration)
-- --     local bear = target:GetAttr(Constants.AttrTypeId.Bear)
    
-- --     local num = attacker.buffMgr:GetBuffOrDebuffNum(param == 2)

-- --     return atk * param[1] * (1 + math.min(num, param[3]) * param[2] ), atk * (Constants.PenetrateRate + pen - bear)
-- -- end

-- -- --（破盾伤害）在伤害本身生效前，先对目标的护盾造成伤害本身*NUM的只对护盾生效的伤害
-- -- function DamageFormula.Formula14( attacker, mainTarget, effectRec, damageRec )
-- --     local target = damageRec.target
-- --     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
-- --     local param = effectRec.effectData.effectNum1
-- --     local pen = attacker:GetAttr(Constants.AttrTypeId.Penetration)
-- --     local bear = target:GetAttr(Constants.AttrTypeId.Bear)

-- --     return atk * param[1] * param[2], atk * param[1], atk * (Constants.PenetrateRate + pen - bear)
-- -- end

-- -- --（贯穿伤害）计算伤害时，使自己的穿透率乘法加成系数增加x%
-- -- function DamageFormula.Formula15( attacker, mainTarget, effectRec, damageRec )
-- --     local target = damageRec.target
-- --     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
-- --     local param = effectRec.effectData.effectNum1
-- --     local pen = attacker:GetAttr(Constants.AttrTypeId.Penetration)
-- --     local bear = target:GetAttr(Constants.AttrTypeId.Bear)

-- --     return atk * param[1], atk * (Constants.PenetrateRate + pen * (1 + param[1]) - bear)
-- -- end

-- -- function DamageFormula.Formula101( attacker, mainTarget, effectRec, damageRec )
-- --     local target = damageRec.target
-- --     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
-- --     local param = effectRec.effectData.effectNum1

-- --     return atk * param[1]
-- -- end

-- -- function DamageFormula.Formula102( attacker, mainTarget, effectRec, damageRec )
-- --     local target = damageRec.target
-- --     local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
-- --     local param = effectRec.effectData.effectNum1

-- --     return matk * param[1]
-- -- end

-- -- --@effectRec: [Game.Battle.Record.SkillEffectRecord#SkillEffectRecord]
-- -- function DamageFormula.Formula103(attacker, mainTarget, effectRec, damageRec)
-- --     local target = damageRec.target
-- --     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
-- --     local matk = attacker:GetAttr(Constants.AttrTypeId.MAttack)
-- --     local param = effectRec.effectData.effectNum1
-- --     local pen = attacker:GetAttr(Constants.AttrTypeId.Penetration)
-- --     local bear = target:GetAttr(Constants.AttrTypeId.Bear)

-- --     return atk * param[1], matk * param[2]
-- -- end

-- -- --根据目标当前血量值计算伤害,不超过攻击力的NUM1倍
-- -- function DamageFormula.Formula104( attacker, mainTarget, effectRec, damageRec )
-- --     local target = damageRec.target
-- --     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
-- --     local param = effectRec.effectData.effectNum1

-- --     local curHp = target:GetAttr(Constants.AttrTypeId.NowHp)

-- --     return math.min( curHp * param[1], atk * param[2] ) 
-- -- end

-- -- --根据目标身上的某种DOT的剩余伤害产生伤害。
-- -- function DamageFormula.Formula105( attacker, mainTarget, effectRec, damageRec )
-- --     local target = damageRec.target
-- --     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
-- --     local param = effectRec.effectData.effectNum1

-- --     local DotType = Constants.BuffType.Dot

-- --     local totalDamage = 0

-- --     for i,buff in ipairs(target.buffMgr.buffs) do
-- --         if buff.data.subEffectType == DotType then
-- --             if param[2] == buff.data.miniEffectType then
-- --                 --结算伤害，直接单次伤害乘以剩余回合数
-- --                 totalDamage = totalDamage + buff:GetValue() * buff.remainRound
-- --             end
-- --         end
-- --     end

-- --     return totalDamage * param[1]
-- -- end

-- -- --根据本次技能里非自然移除的增益BUFF产生伤害
-- -- --@otherEffects: [Game.Battle.Record.SkillEffectRecord#SkillEffectRecord<>]
-- -- function DamageFormula.Formula201( attacker, mainTarget, effectRec, damageRec, otherEffects )
-- --     local target = damageRec.target
-- --     local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
-- --     local param = effectRec.effectData.effectNum1
-- --     local pen = attacker:GetAttr(Constants.AttrTypeId.Penetration)
-- --     local bear = target:GetAttr(Constants.AttrTypeId.Bear)

-- --     local totalClearNum = 0
-- --     for i,v in ipairs(otherEffects) do
-- --         if v and v.buffClearLayNum and v.buffClearLayNum > 0 then
-- --             totalClearNum = totalClearNum + v.buffClearLayNum
-- --         end
-- --     end

-- --     return atk * param[1] * totalClearNum, atk * (Constants.PenetrateRate + pen - bear)
-- -- end

return DamageFormula

