local bs_30018 = class("bs_30018", LuaSkillBase)
local base = LuaSkillBase
bs_30018.config = {}

function bs_30018:ctor()
end

function bs_30018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30018_1", 1, self.OnAfterPlaySkill)
  self:AddSetHurtTriggerForTable("bs_30018_2", 90, self.OnSetHurt, {
    sender = self.caster,
    extraArg1 = eSkillTag.commonAttack,
    extraArg2 = false
  })
  self.flag = false
end

function bs_30018:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    self.flag = true
  end
end

function bs_30018:OnSetHurt(context)
  if context.skill.maker == self.caster and context.isTriggerSet ~= true and context.skill.isCommonAttack and self.flag == true and context.extra_arg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    self.flag = false
    if context.isCrit == false then
      context.isCrit = true
      context.hurt = (1000 + self.caster.critDamage) * context.hurt // 1000
    end
  end
end

function bs_30018:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30018
