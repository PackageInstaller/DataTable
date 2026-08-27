local bs_10003 = class("bs_10003", LuaSkillBase)
local base = LuaSkillBase
bs_10003.config = {
  effectId = 10344,
  effectAttackId = 10336,
  buffId = 82
}

function bs_10003:ctor()
end

function bs_10003:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10003_3", 3, self.OnAfterHurt, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10003_1", 2, self.OnAfterPlaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10003_11", 1, self.OnBeforePlaySkill)
  self.caster.recordTable["10003_atkFlag"] = false
end

function bs_10003:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and self.caster:GetBuffTier(self.config.buffId) > 0 and not isTriggerSet then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_10003:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    self:PlayChipEffect()
    self.caster.recordTable["10003_atkFlag"] = true
  end
end

function bs_10003:OnBeforePlaySkill(role, context)
  if role == self.caster and context.skill.isCommonAttack and self.caster.recordTable["10003_atkFlag"] then
    local passdata = {
      effectId = self.config.effectAttackId
    }
    context.passdata = passdata
    local dmgUp1 = self.caster.hp * self.arglist[1] // 1000
    local dmgUp2 = self.caster.hp * self.arglist[1] * self.arglist[2] // 10000
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, dmgUp2)
    LuaSkillCtrl:RemoveLife(dmgUp1, self, self.caster)
    self.caster.recordTable["10003_atkFlag"] = false
  end
end

function bs_10003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10003
