local bs_10143 = class("bs_10143", LuaSkillBase)
local base = LuaSkillBase
bs_10143.config = {
  buffId = 1039,
  buffTier = 1,
  damageBuffId = 1075,
  effectId1 = 91,
  effectId2 = 10339,
  effectId3 = 10340,
  healFormula = 1047,
  healEffectId = 10286,
  heal_config = {baseheal_formula = 501}
}

function bs_10143:ctor()
end

function bs_10143:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10143_3", 3, self.OnAfterPlaySkill)
end

function bs_10143:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack and self:IsReadyToTake() then
    self:OnSkillTake()
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
    LuaSkillCtrl:CallEffect(self.caster, self.config.healEffectId, self)
    local healNum = math.max(LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.healFormula, self.caster, self.caster, self), 1)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.damageBuffId, self.config.buffTier)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, self.config.aoe_config)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {healNum}, true)
  end
end

function bs_10143:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10143
