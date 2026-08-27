local bs_7009 = class("bs_7009", LuaSkillBase)
local base = LuaSkillBase
bs_7009.config = {buffId = 1228}

function bs_7009:ctor()
end

function bs_7009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_7009_12", 1, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_7009_3", 1, self.OnAfterHurt, self.caster)
  self:AddAfterHealTrigger("bs_7009_5", 1, self.OnAfterHeal, self.caster)
  self.isFirst = false
end

function bs_7009:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    self.isFirst = true
  end
end

function bs_7009:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isTriggerSet and not isMiss and self.isFirst then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    self.isFirst = false
  end
end

function bs_7009:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if not isTriggerSet and self.isFirst then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    self.isFirst = false
  end
end

function bs_7009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7009
