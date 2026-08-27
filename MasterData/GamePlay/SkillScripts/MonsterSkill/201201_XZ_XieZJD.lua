local bs_40009 = class("bs_40009", LuaSkillBase)
local base = LuaSkillBase
bs_40009.config = {
  hurt_config = {
    basehurt_formula = 10076,
    hit_formula = 0,
    crit_formula = 0,
    correct_formula = 9989,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  hurt_config2 = {
    hit_formula = 0,
    basehurt_formula = 10114,
    crit_formula = 0,
    crithur_ratio = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  buffId_1007 = 1007,
  buffId_1130 = 1130,
  buffDispelEffectId = 10275,
  buffDamageFormula = 10078,
  audioId1 = 80,
  skillId = 201202
}

function bs_40009:ctor()
end

function bs_40009:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_40009_3", 1, self.OnAfterHurt, self.caster)
  self:AddAfterAddBuffTrigger("bs_40009_7", 1, self.OnAfterAddBuff, self.caster)
end

function bs_40009:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and skill.isCommonAttack then
    LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buffId_1007, 1, self.arglist[4], false, false, self.OnBuffExecute)
    LuaSkillCtrl:PlayAuSource(target, self.config.audioId1)
  end
end

function bs_40009:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:PlayAuHit(self, targetRole)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config2, {
    buff.tier
  }, true)
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(targetRole, self.config.buffDispelEffectId, self)
end

function bs_40009:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_1007 and target:GetBuffTier(self.config.buffId_1007) >= self.arglist[2] then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    LuaSkillCtrl:CallEffect(target, self.config.buffDispelEffectId, self)
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_1007, 0)
    skillResult:EndResult()
  end
  if buff.dataId == self.config.buffId_1130 then
    LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buffId_1007, 1, self.arglist[4], false, false, self.OnBuffExecute)
    LuaSkillCtrl:PlayAuSource(target, self.config.audioId1)
  end
end

function bs_40009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_40009
