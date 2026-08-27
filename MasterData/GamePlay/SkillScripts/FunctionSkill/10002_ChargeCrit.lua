local bs_10002 = class("bs_10002", LuaSkillBase)
local base = LuaSkillBase
bs_10002.config = {
  crit_formula = 10003,
  buffId = 1034,
  effectCreat = 64,
  effectBoom = 64
}

function bs_10002:ctor()
end

function bs_10002:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10002_3", 1, self.OnAfterHurt, self.caster)
end

function bs_10002:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet and not isCrit then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
  end
  if sender == self.caster and isCrit and not isMiss then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_10002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10002
