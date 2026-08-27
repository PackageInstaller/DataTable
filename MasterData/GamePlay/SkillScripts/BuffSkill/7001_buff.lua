local bs_7001 = class("bs_7001", LuaSkillBase)
local base = LuaSkillBase
bs_7001.config = {
  buffId_sueyoiNormalAttack = 1045002,
  hurt_config = {
    crit_formula = 10010,
    lifesteal_formula = 10141,
    extra_arg = 700101
  }
}

function bs_7001:ctor()
end

function bs_7001:InitSkill(isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_20013_14", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_20013_15", 1, self.OnHurtResultEnd)
  self.replaceFormula = 0
end

function bs_7001:OnHurtResultStart(skill, context)
  if skill.isCommonAttack and context.sender == self.caster and context.isTriggerSet ~= true and context.extraArg ~= 99 then
    context.new_config = self.config.hurt_config
    setmetatable(context.new_config, {
      __index = context.config
    })
    self.replaceFormula = 1
  end
end

function bs_7001:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.isCommonAttack and skill.maker == self.caster and self.replaceFormula == 1 and 1 > self.caster:GetBuffTier(self.config.buffId_sueyoiNormalAttack) then
    local buffId = LuaSkillCtrl:GetSkillBindBuffId(self)
    LuaSkillCtrl:DispelBuff(self.caster, buffId, 1)
    self.replaceFormula = 0
  end
end

function bs_7001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7001
