local bs_10193 = class("bs_10193", LuaSkillBase)
local base = LuaSkillBase
bs_10193.config = {buffId = 66, buffTier = 1}

function bs_10193:ctor()
end

function bs_10193:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10193_1", 1, self.OnAfterPlaySkill)
  self:AddSetHurtTrigger("bs_10193_2", 2, self.OnSetHurt, self.caster)
  self.caster.recordTable["10193_AttackTime"] = 0
  self.caster.recordTable.DamageFlag = false
end

function bs_10193:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.isCommonAttack then
    self.caster.recordTable["10193_AttackTime"] = self.caster.recordTable["10193_AttackTime"] + 1
    if self.caster.recordTable["10193_AttackTime"] > self.arglist[3] then
      self.caster.recordTable.DamageFlag = true
      self.caster.recordTable["10193_AttackTime"] = 0
    end
  end
end

function bs_10193:OnSetHurt(context)
  if context.sender == self.caster and context.skill.isCommonAttack and not context.isTriggerSet and self.caster.recordTable.DamageFlag and not context.isTriggerSet then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId, self.config.buffTier, self.arglist[2])
    self.caster.recordTable.DamageFlag = false
    self:PlayChipEffect()
  end
end

function bs_10193:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10193
