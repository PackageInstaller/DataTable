local bs_10234 = class("bs_10234", LuaSkillBase)
local base = LuaSkillBase
bs_10234.config = {
  buffId = 1088,
  buffId2 = 1161,
  buffTier = 1,
  heal_config = {
    baseheal_formula = 10087,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId = 10634,
  debuffId = 1119
}

function bs_10234:ctor()
end

function bs_10234:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_10234_5", 1, self.OnAfterHeal, self.caster)
end

function bs_10234:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if sender == self.caster and not isTriggerSet then
    self:PlayChipEffect()
    local debuffTier = target:GetBuffTier(self.config.debuffId)
    if 0 < debuffTier then
      return
    end
    LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buffId, self.arglist[1], 90, false, false, self.OnBuffExecute)
  end
end

function bs_10234:OnBuffExecute(buff, targetRole)
  LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true, true)
  skillResult:EndResult()
end

function bs_10234:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10234
