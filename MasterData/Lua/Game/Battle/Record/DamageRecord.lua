--
-- Author:luqucheng
-- Date: 2019-10-25 11:54:59
--
local Record = import('Game.Battle.Record.Record')
---@class Game.Battle.Record.DamageRecord
local DamageRecord = Class("DamageRecord", Record)



function DamageRecord:__init(target, attacker)
    self.targetId = target.id
    if attacker then
        self.attackerId = attacker.id
    end
    --@RefType [Game.Battle.Entity.Role#Role]
    self.target = target
    self.isHit = true
    self.isCrit = false
    self.damageType = 0--伤害类型，暂时用不到，以后说不定会加
    self.damage = 0--税前伤害
    self.finalDamage = 0--税后伤害
    self.hpChange = 0--血量变化
    self.nowShield = 0--剩余护盾
    self.shieldAbsorb = 0--护盾吸收值
    self.nowHp = 0--剩余血量
    self.element = 0--属性克制
    self.dotHotType = nil--伤害来源的dot hot 类型
    self.isSecondHand = false--二手，true表示是由其他伤害或治疗变更类造成的，防止无限循环
    self.isBounce = false --是否是反伤
end

function DamageRecord:IsDamage(  )
    return self.damageType ~= Constants.DamageType.Heal and self.damageType ~= Constants.DamageType.HPChange 
end

function DamageRecord:IsHeal()
    return self.damageType == Constants.DamageType.Heal 
end

function DamageRecord:ToData()
    return{
        r = Constants.RecordType.Damage,
        t = self.targetId,
        h = self.isHit,
        c = self.isCrit,
        dt = self.damageType,
        d = self.damage,
        fd = self.finalDamage,
        hc = self.hpChange,
        s = self.nowShield,
        hp = self.nowHp,
        dh = self.dotHotType,
        e = self.element,
        sa = self.shieldAbsorb,
        a = self.attackerId,
        ib = self.isBounce
    }
end

return  DamageRecord