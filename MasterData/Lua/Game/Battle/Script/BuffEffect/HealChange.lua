--
-- Author:luqucheng
-- Date: 2019-11-14 16:52:39
--

local BuffEffect = import('Game.Battle.Core.BuffEffect')
--@SuperType [Game.Battle.Core.BuffEffect#BuffEffect]
local HealChange = Class("HealChange", BuffEffect)

--比较效果等级
function HealChange:CanChange(dmgType, effectLv)
    if dmgType ~= Constants.DamageType.Pure then
        return true
    end
    if effectLv <= 0 then
        return true
    end

    return effectLv < self.data.effectLv
end

--@dmgRec: [Game.Battle.Record.DamageRecord#DamageRecord]
function  HealChange:ChangeHeal(healValue, dmgRec, attacker)

    local HealChangeType = Constants.HealChangeType
    --@RefType[Game.Battle.Data.EffectData#EffectData]
    local data = self.data
    --@RefType[Game.Battle.Entity.Role#Role]
    local owner = self.buff.owner
    local switch = {
        --伤害上限
        [HealChangeType.OverflowToShield] = function (  )
            if dmgRec.isSecondHand then
                return
            end
            if not self.buff.attacker or attacker.id ~= self.buff.attacker.id then
                --只有buff施加者和治疗施加者是同一人的情况下才会生效
                return
            end
            local overflowHealValue = healValue - (owner:GetAttr(Constants.AttrTypeId.Hp) - owner:GetNowHp())
            if overflowHealValue <= 0 then
                --治疗量不会溢出
                return
            end
            owner.buffMgr:AddBuff(attacker, Core:GetBuffData(data.effectNum1[2], 1, 1), 1, {shieldValue = overflowHealValue * data.effectNum1[1]})
            owner.buffMgr:AfterChangeBuff()
        end,
        [HealChangeType.OverflowToDamage] = function (  )
            if dmgRec.isSecondHand then
                return
            end
            local overflowHealValue = healValue - (owner:GetAttr(Constants.AttrTypeId.Hp) - owner:GetNowHp())
            if overflowHealValue <= 0 then
                --治疗量不会溢出
                return
            end
            local totalDmg = math.min(overflowHealValue * data.effectNum1[1], attacker:GetAttr(Constants.AttrTypeId.Hp) * data.effectNum1[3])
            local rs = BattleMgr:GetAliveRoles(BattleMgr:GetOppoCamp(owner.camp))
            if #rs <= 0 then
                return
            end
            local dmg = totalDmg / #rs
            for i,role in ipairs(rs) do
                local rec = RecordMgr.DamageRecord.New(role, attacker)
                rec.isSecondHand = true
                BattleMgr:Damage(dmg, Core:GetDamageData(data.effectNum1[2]), 0, role, attacker, 1, 1, rec)
            end
        end,
        [HealChangeType.CriticalHeal] = function (  )
            local miniEffectType = data.miniEffectType
            if miniEffectType == 2 then
                -- 8;3;2 额外判断buff施加者和治疗施加者是否是同一人
                if not self.buff.attacker or attacker.id ~= self.buff.attacker.id then
                    --只有buff施加者和治疗施加者是同一人的情况下才会生效
                    return
                end
            end
            local isCrit = false
            local rate = attacker:GetAttr(Constants.AttrTypeId.Critical)
            if rate <= 0 then
                return
            end
            if rate >= 1 then
                isCrit = true
            else
                isCrit = Core.Random() <= rate
            end

            if isCrit then
                local critValue = math.max(attacker:GetAttr(Constants.AttrTypeId.CritDamage), 1.0)
                healValue = healValue * critValue
                dmgRec.isCrit = true
            end
        end,
        [HealChangeType.OverflowToShield2] = function (  )
            if dmgRec.isSecondHand then
                return
            end
            local overflowHealValue = healValue - (owner:GetAttr(Constants.AttrTypeId.Hp) - owner:GetNowHp())
            if overflowHealValue <= 0 then
                --治疗量不会溢出
                return
            end
            owner.buffMgr:AddBuff(attacker, Core:GetBuffData(data.effectNum1[2], 1, 1), 1, {shieldValue = overflowHealValue * data.effectNum1[1]})
            owner.buffMgr:AfterChangeBuff()
        end,
    }

    local func = switch[data.subEffectType]
    assert(func, '找不到对应的治疗变更类型:'..data.subEffectType)
    func()

    return healValue
end

return  HealChange
