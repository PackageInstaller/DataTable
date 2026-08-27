local bs_21013 = class("bs_21013", LuaSkillBase)
local base = LuaSkillBase
bs_21013.config = {buffId = 1252, effectId = 10942}

function bs_21013:ctor()
end

function bs_21013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_21013_1", 1, self.OnAfterHurt, nil, self.caster)
  self.HpPercent = 1
end

function bs_21013:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if target == self.caster and target.hp > 0 and target.hp * 1000 // target.maxHp < self.arglist[1] and self.HpPercent == 1 then
    self.HpPercent = 0
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2])
  end
end

function bs_21013:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21013
