local bs_1060 = class("bs_1060", LuaSkillBase)
local base = LuaSkillBase
bs_1060.config = {buffId = 110155}

function bs_1060:ctor()
end

function bs_1060:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1060_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddSetHurtTrigger("bs_1060_2", 1, self.OnSetHurt, nil, self.caster)
end

function bs_1060:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.caster.hp <= self.caster.maxHp * self.arglist[1] // 1000 and 1 > self.caster:GetBuffTier(self.config.buff) then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
  end
end

function bs_1060:OnSetHurt(context)
  if self.caster.hp >= self.caster.maxHp * self.arglist[1] // 1000 and self.caster:GetBuffTier(self.config.buff) > 0 then
    LuaSkillCtrl:DispelBuff(self, self.caster, self.config.buffId, 1)
  end
end

function bs_1060:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1060
