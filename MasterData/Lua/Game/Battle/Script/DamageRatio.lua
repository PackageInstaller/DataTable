--[[
    author:luqucheng
    time:2022-12-14 18:19:29
]]

local DamageRatio = {}

--对有增益的目标造成2倍伤害
function DamageRatio.Formula9(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])

    local layer = target.buffMgr:GetBuffOrDebuffNum(false)

    if layer > 0 then
        return ratioParam1
    end

    return 1
end

--对有减益的目标造成3倍伤害
function DamageRatio.Formula10(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])

    local layer = target.buffMgr:GetBuffOrDebuffNum(true)

    if layer > 0 then
        return ratioParam1
    end

    return 1
end

--目标每拥有一层减益，造成伤害提升30%
function DamageRatio.Formula11(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])

    local layerMax = 10

    -- 如果目标身上有buff效果11,5,1，那么修改弱点层数上限为num1
    local buffMgr = attacker.buffMgr
    buffMgr:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect:IsType(11, 5, 1) then
            layerMax = buffEffect.data.effectNum1[1]
            return true
        end
    end)

    local layer = target.buffMgr:GetBuffOrDebuffLayers(true)
    layer = math.min(layer, layerMax)

    return 1 + layer * ratioParam1
end

--自身每有一层增益效果，造成伤害提升30%
function DamageRatio.Formula12(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    --local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])

    local layer = attacker.buffMgr:GetBuffOrDebuffLayers(false)
    layer = math.min(layer, 10)

    return 1 + layer * ratioParam1
end

--目标生命值大于70%时，造成2倍伤害
function DamageRatio.Formula13(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local ratioParam2 = checkNumber(damageRatioParams[2])
    local targetHpPer = target:GetAttr(Constants.AttrTypeId.NowHp) / target:GetAttr(Constants.AttrTypeId.Hp)
    return targetHpPer > ratioParam1 and ratioParam2 or 1
end

--目标生命值小于30%时，造成2倍伤害
function DamageRatio.Formula14(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local ratioParam2 = checkNumber(damageRatioParams[2])
    local targetHpPer = target:GetAttr(Constants.AttrTypeId.NowHp) / target:GetAttr(Constants.AttrTypeId.Hp)
    return targetHpPer < ratioParam1 and ratioParam2 or 1
end

--目标最大生命值每大于自身1%，造成伤害提升1%
function DamageRatio.Formula15(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local ratioParam2 = checkNumber(damageRatioParams[2])
    local attackerMaxHp = attacker:GetAttr(Constants.AttrTypeId.Hp)
    local targetMaxHp = target:GetAttr(Constants.AttrTypeId.Hp)
    return 1 + math.range(((targetMaxHp / attackerMaxHp) - 1) * ratioParam1, 0, ratioParam2 - 1)
end

--目标每损失1%生命值，造成伤害提升1.3%
function DamageRatio.Formula16(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local lostHpPer = (target:GetAttr(Constants.AttrTypeId.Hp) - target:GetAttr(Constants.AttrTypeId.NowHp))/ target:GetAttr(Constants.AttrTypeId.Hp)
    return 1 + lostHpPer * ratioParam1
end

--自身每损失1%生命值，造成伤害提升1%
function DamageRatio.Formula17(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local lostHpPer = (attacker:GetAttr(Constants.AttrTypeId.Hp) - attacker:GetAttr(Constants.AttrTypeId.NowHp))/ attacker:GetAttr(Constants.AttrTypeId.Hp)
    return 1 + lostHpPer * ratioParam1
end

--自身当前每有1%血量，造成伤害提升0.8%
function DamageRatio.Formula18(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local hpPer = attacker:GetAttr(Constants.AttrTypeId.NowHp)/ attacker:GetAttr(Constants.AttrTypeId.Hp)
    return 1 + hpPer * ratioParam1
end

--目标每有1点SP，造成伤害提升20%
function DamageRatio.Formula19(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local spPoint = target:GetUltraPoint()
    return 1 + spPoint * ratioParam1
end

--牌库中每有一张自己的技能卡，造成伤害提升20%
function DamageRatio.Formula20(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local num = 0
    local cardMgr = attacker:GetCardMgr()
    if cardMgr then
        local cards = cardMgr:FindCardsByFunc(function (card, pos)
            return card.roleId == attacker.id
        end)
        num = #cards
    end
    return 1 + num * ratioParam1
end

--自身每有1点SP，造成伤害提升20%
function DamageRatio.Formula23(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local spPoint = attacker:GetUltraPoint()

    -- 如果目标身上有buff效果11,1,1，那么认为sp点数为num1
    local buffMgr = attacker.buffMgr
    buffMgr:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect:IsType(11, 1, 1) then
            spPoint = buffEffect.data.effectNum1[1]
            return true
        end
    end)

    return 1 + spPoint * ratioParam1
end

--根据目标身上的buff层数计算倍率
--叠层追伤：系数=1+目标身上buffid=Num1的层数*Num2，最多计入Num3层；三个参数依次取效果参数的最后3个参数
function DamageRatio.Formula24(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    local param = effectRec.effectData.effectNum1
    if table.count(param) < 3 then
        printError(string.format("二类为24的伤害效果,效果参数最少需要3个 id:%s", tostring(effectRec.effectData.id)))
        return 1
    end

    local count = #param
    local num1 = param[count - 2]
    local num2 = param[count - 1]
    local num3 = param[count]
    local target = damageRec.target

    local totalLayNum = 0
    target.buffMgr:WalkAllBuff(function ( v )
        if v.buffID == num1 then
            totalLayNum = totalLayNum + math.max( 1, v.layNum )
        end
    end)
    totalLayNum = math.min(num3, totalLayNum)

    return 1 + totalLayNum * num2
end

-- 攻击时，目标每拥有1%生命值，提升1.3%伤害
-- 湮灭伤害：系数=1+（target_nowHp/target_maxHp）*1.3。（1.3取《伤害类型》的damageRatioParams）
function DamageRatio.Formula25(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local hpPer = target:GetAttr(Constants.AttrTypeId.NowHp) / target:GetAttr(Constants.AttrTypeId.Hp)
    return 1 + hpPer * ratioParam1
end

--自身每有1点SP，造成伤害提升20%
function DamageRatio.Formula27(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local spPoint = attacker:GetUltraPoint()

    -- 如果目标身上有buff效果11,1,1，那么认为sp点数为num1
    local buffMgr = attacker.buffMgr
    buffMgr:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect:IsType(11, 1, 1) then
            spPoint = buffEffect.data.effectNum1[1]
            return true
        end
    end)

    return 1 + spPoint * ratioParam1
end

--攻击时，牌库中每有一张不低于2星的非奥义技能牌，提升20%伤害，最多提升200%
function DamageRatio.Formula28(attacker, mainTarget, effectRec, damageRec, effectParams, damageRatioParams)
    --@RefType [Game.Battle.Entity.Role#Role]
    local target = damageRec.target
    local param = effectRec.effectData.effectNum1
    local ratioParam1 = checkNumber(damageRatioParams[1])
    local ratioParam2 = checkNumber(damageRatioParams[2])
    local num = 0
    local cardMgr = attacker:GetCardMgr()
    if cardMgr then
        local cards = cardMgr:FindCardsByFunc(function (card, pos)
            return card.star >= 2 and not card.isUltra
        end)
        num = #cards
    end
    return 1 + math.range(num * ratioParam1, 0, ratioParam2)
end

return DamageRatio