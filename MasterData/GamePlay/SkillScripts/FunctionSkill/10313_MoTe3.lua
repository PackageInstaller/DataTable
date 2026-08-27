local bs_10313 = class("bs_10313", LuaSkillBase)
local base = LuaSkillBase
bs_10313.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10077,
    crit_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  effectId = 12028
}

function bs_10313:ctor()
end

function bs_10313:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10313_3", 3, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_10313_2", 1, self.OnAfterHurt, self.caster)
  self:AddSetHurtTrigger("bs_10313_1", 90, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.isShouci = false
  self.isYunShi = false
end

function bs_10313:OnAfterPlaySkill(skill, role)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  if not skill.isCommonAttack and not self.isShouci then
    self.isYunShi = true
    self.isShouci = true
  end
end

function bs_10313:OnSetHurt(context)
  if self.isShouci and context.extra_arg ~= ConfigData.buildinConfig.HurtIgnoreKey and not context.isTriggerSet then
    self.isShouci = false
    context.hurt = context.hurt + context.hurt * self.arglist[1] // 1000
    if context.sender == self.caster and context.skill.isCommonAttack and context.target == self.caster.recordTable.lastAttackRole and self.isYunShi and not context.isTriggerSet then
      self.isYunShi = false
      self:PlayChipEffect()
      self:OnSkillTake()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target, self.config.aoe_config)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
      skillResult:EndResult()
    end
  end
end

function bs_10313:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
end

function bs_10313:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10313
