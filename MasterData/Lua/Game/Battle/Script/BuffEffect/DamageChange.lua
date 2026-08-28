--
-- Author:luqucheng
-- Date: 2019-11-14 16:52:39
--

local BuffEffect = import('Game.Battle.Core.BuffEffect')
--@SuperType [Game.Battle.Core.BuffEffect#BuffEffect]
local DamageChange = Class("DamageChange", BuffEffect)

--比较效果等级
function DamageChange:CanChange(dmgType, dmgTags, effectLv)
    if not Core:DamageFitTag(dmgTags, Constants.DamageTag.Pure) then
        return true
    end
    if effectLv <= 0 then
        return true
    end

    return effectLv < self.data.effectLv
end

--@dmgRec: [Game.Battle.Record.DamageRecord#DamageRecord]
function  DamageChange:ChangeDamage(baseDmg, finalDmg, damageTypeVo, effectLv, dmgRec, attacker)

    local dmgTypeId = damageTypeVo.id
    local dmgType = damageTypeVo.damageType
    local dmgTags = damageTypeVo.damageTags

    local canChange = self:CanChange(dmgType, dmgTags, effectLv)
    if not canChange then
        return finalDmg
    end

    local DamageChangeType = Constants.DamageChangeType
    --@RefType[Game.Battle.Data.EffectData#EffectData]
    local data = self.data
    local owner = self.buff.owner
    local switch = {
        --伤害上限
        [DamageChangeType.UpperLimit] = function (  )
            if Core:DamageFitTag(dmgTags, Constants.DamageTag.Execute) then
                return
            end
            local value = data.effectNum1[1]
            finalDmg = finalDmg > value and value or finalDmg
        end,

        [DamageChangeType.UpperLimitHPPercent] = function (  )
            if Core:DamageFitTag(dmgTags, Constants.DamageTag.Execute) then
                return
            end
            local value = data.effectNum1[1] * owner:GetAttr(Constants.AttrTypeId.Hp)
            finalDmg = finalDmg > value and value or finalDmg
        end,

        [DamageChangeType.LockHp] = function (  )
            if Core:DamageFitTag(dmgTags, Constants.DamageTag.Execute) then
                return
            end
            local value = data.effectNum1[1]
            local nowHp = owner:GetNowHp()
            --超过锁血的界限
            if nowHp - finalDmg < value then
                finalDmg = math.max(0, nowHp - value) 
            end
        end,

        [DamageChangeType.DamageShare] = function (  )
            if not dmgRec.isSecondHand then--来源自伤害分享的伤害是不分享的
                if not self.buff.attacker then
                    return
                end

                -- 参数6，指定触发伤害分享的伤害类型，不指定时按旧逻辑生效
                local triggerDamageTypeId = data.effectNum1[6] or 0
                if triggerDamageTypeId > 0 then
                    -- 只有指定的伤害类型可以触发溅射
                    if dmgTypeId ~= triggerDamageTypeId then
                        return
                    end
                else
                    --间接和纯粹伤害不触发溅射
                    if dmgType == Constants.DamageType.Indirect or dmgType == Constants.DamageType.Pure then
                        return
                    end
                end
                
                --寻找标记buff的持有者
                -- 参数1: 次要BUFF的ID;
                -- 参数2伤害承担类型(1.转移全部2.转移均分3.直接平摊);
                -- 参数3主要目标承担的伤害比例;（主要目标受到的伤害=最终伤害*参数3）
                -- 参数4次要目标的伤害比例（该伤害=被攻击目标受到的最终伤害*参数4）
                -- 参数5：是否广播受击事件（默认0.不广播，1.广播）
                local markBuffId = data.effectNum1[1]
                local shareType = data.effectNum1[2]
                local reduce = data.effectNum1[3]
                local suffer = data.effectNum1[4]
                local broadcast = data.effectNum1[5] or 0
                local targetRoles = {}
                for i,role in ipairs(BattleMgr.roles) do
                    if not role:IsDead() and role.id ~= owner.id and role.buffMgr:HasBuffByBuffTypeIDAndAttackerID(markBuffId, self.buff.attacker.id) then
                        table.insert(targetRoles, role)
                    end
                end

                --无人分担则自身受到100%伤害
                if #targetRoles <= 0 then
                    return
                end

                --全部受伤和均摊伤害
                local shareDmg = 0
                if shareType == 1 then
                    shareDmg = finalDmg * suffer
                    finalDmg = finalDmg * reduce
                elseif shareType == 2 then
                    shareDmg = finalDmg * suffer / #targetRoles
                    finalDmg = finalDmg * reduce
                elseif shareType == 3 then
                    shareDmg = finalDmg / (#targetRoles + 1)
                    finalDmg = shareDmg
                end

                local dmgVo = Core:GetDamageData(Core:GetBattleParamNum(Constants.BattleParam.LinkDamageTypeId))
                --给与这些目标伤害
                local originShareDmg = shareDmg
                for i,role in ipairs(targetRoles) do
                    shareDmg = originShareDmg
                    
                    -- 如果目标身上有buff效果11,2,1，那么额外增加伤害
                    local buffMgr = role.buffMgr
                    buffMgr:WalkAllBuffEffects(function ( buffEffect )
                        if buffEffect:IsType(11, 2, 1) then
                            local param1 = buffEffect.data.effectNum1[1]
                            shareDmg = shareDmg * (1 + param1)
                            return true
                        end
                    end)

                    local rec = RecordMgr.DamageRecord.New(role, attacker)
                    rec.isSecondHand = true
                    rec.hitFromType = Constants.HitFromType.DamageLink
                    BattleMgr:Damage(shareDmg, dmgVo, 0, role, attacker, 1, 1, rec)

                    -- 触发一次受击事件(注意：这里触发的事件没有技能信息，也不能使用技能的触发规则)
                    if broadcast == 1 then
                        BattleMgr:Trig(rec.target, Constants.TriggerMainType.BeAttack, {damageRec = rec, skillRec = nil}, attacker, nil)
                    end
                end
            end
        end,

        [DamageChangeType.LockPercentHp] = function (  )
            if Core:DamageFitTag(dmgTags, Constants.DamageTag.Execute) then
                return
            end
            local nowHp = owner:GetNowHp()
            local maxHp = owner:GetAttr(Constants.AttrTypeId.Hp)
            local value = data.effectNum1[1] * maxHp
            --超过锁血的界限
            if nowHp - finalDmg < value then
                finalDmg = math.max(0, nowHp - value) 
            end
        end,

        [DamageChangeType.Perseverance] = function (  )
            if Core:DamageFitTag(dmgTags, Constants.DamageTag.Execute) then
                return
            end
            local nowHp = owner:GetNowHp()
            local maxHp = owner:GetAttr(Constants.AttrTypeId.Hp)
            local value = data.effectNum1[1] * maxHp--触发大毅力下限

            if finalDmg >= nowHp and nowHp >= value then
                finalDmg = 0
                --减少自己一层buff
                owner.buffMgr:RemoveBuff(self.buff, 1)
            end

        end,

        [DamageChangeType.ElementAdvantageEnhance] = function (  )
            local rate = Core:GetElementCounteDamage(attacker.elementType, owner.elementType)
            if rate > 0 then
                finalDmg = finalDmg * (1 + data.effectNum1[1])
            end 
        end,

        [DamageChangeType.PerseverancePerSkill] = function (  )
            if Core:DamageFitTag(dmgTags, Constants.DamageTag.Execute2) then
                return
            end
            local nowHp = owner:GetNowHp()
            local maxHp = owner:GetAttr(Constants.AttrTypeId.Hp)
            local value = data.effectNum1[1] * maxHp--触发大毅力下限
            
            if finalDmg >= nowHp and nowHp >= value then
                self.perSkillPerseveranceValue = self.perSkillPerseveranceValue or 0 + finalDmg
                finalDmg = 0
                -- 不会立即移除大毅力buff，等技能结束再移除
                BattleMgr:Trig(owner, Constants.TriggerMainType.PerseverancePerSkill, {buff = self.buff}, attacker)
            end
        end,
        -- 单次技能伤害上限
        [DamageChangeType.UpperLimitHPPercentPerSkill] = function (  )
            if not BattleMgr.isInSkill then
                -- 只限制技能过程中的伤害，以及技能过程中触发的dot
                -- 回合结束时的dot不限制
                return
            end
            local limit = data.effectNum1[1] * owner:GetAttr(Constants.AttrTypeId.Hp)

            local thisSkillTotalDamage = 0
            local dmgRecs = BattleMgr:GetNowSkillDamageRecs()
            for i, dmgRec in ipairs(dmgRecs) do
                if dmgRec:IsDamage() and dmgRec.targetId == owner.id then
                    thisSkillTotalDamage = thisSkillTotalDamage + dmgRec.finalDamage
                end
            end
            -- 如果已经造成的伤害加上这次造成的伤害，超过了limit，那么修改finalDmg
            if thisSkillTotalDamage + finalDmg > limit then
                finalDmg = limit - thisSkillTotalDamage
            end
        end,
        -- 大毅力版本的锁血：每层大毅力使一次【超过maxHp*NUM1】的【致死】技能无效化，用于防止秒杀(当牌库里存在技能牌ID=Num3；Num4；Num5……的Num2星技能牌时才会生效)
        [DamageChangeType.PerseverancePerSkill2] = function()
            if Core:DamageFitTag(dmgTags, Constants.DamageTag.Execute2) then
                return
            end
            local nowHp = owner:GetNowHp()
            local maxHp = owner:GetAttr(Constants.AttrTypeId.Hp)
            local value = data.effectNum1[1] * maxHp--触发大毅力下限
            
            local star = data.effectNum1[2]
            
            local targetCardIdList = {}
            for i = 3, #data.effectNum1, 1 do
                local cardId = data.effectNum1[i]
                table.insert(targetCardIdList, cardId)
            end

            local cardMgr = owner:GetCardMgr()
            if cardMgr then
                local cards = cardMgr:FindCardsByFunc(function (card, pos)
                    return card.star == star and table.isContain(targetCardIdList, cardMgr:GetSkillCardId(card))
                end)

                if #cards > 0 and finalDmg >= nowHp and nowHp >= value then
                    self.perSkillPerseveranceValue2 = self.perSkillPerseveranceValue2 or 0 + finalDmg
                    finalDmg = 0
                    -- 不会立即移除大毅力buff，等技能结束再移除
                end
            end
        end,
    }

    local func = switch[data.subEffectType]
    assert(func, '找不到对应的伤害变更类型:'..data.subEffectType)
    func()

    return finalDmg
end

return  DamageChange
