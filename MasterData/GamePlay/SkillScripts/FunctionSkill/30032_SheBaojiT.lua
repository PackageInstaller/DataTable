local bs_30032 = class("bs_30032", LuaSkillBase)
local base = LuaSkillBase
bs_30032.config = {}

function bs_30032:ctor()
end

function bs_30032:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30032_1", 1, self.OnAfterPlaySkill)
  self:AddSetHurtTrigger("bs_30032_2", 2, self.OnSetHurt, self.caster)
  self.caster.recordTable["30032_AttackTime"] = 0
  self.caster.recordTable.DamageFlag = false
end

function bs_30032:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.isCommonAttack then
    self.caster.recordTable["30032_AttackTime"] = self.caster.recordTable["30032_AttackTime"] + 1
    if self.caster.recordTable["30032_AttackTime"] >= self.arglist[1] then
      self.caster.recordTable.DamageFlag = true
      self.caster.recordTable["30032_AttackTime"] = 0
    end
  end
end

function bs_30032:OnSetHurt(context)
  if context.sender == self.caster and context.skill.isCommonAttack and not context.isTriggerSet and self.caster.recordTable.DamageFlag then
    if self.caster.hp <= 1 then
      self.caster.recordTable.DamageFlag = false
      return
    end
    if context.isCrit then
      context.hurt = (1000 + self.caster.critDamage) * context.hurt // (1000 + self.caster.critDamage)
    else
      context.isCrit = true
      context.hurt = (1000 + self.caster.critDamage) * context.hurt // 1000
    end
    self.caster.recordTable.DamageFlag = false
  end
end

function bs_30032:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30032
