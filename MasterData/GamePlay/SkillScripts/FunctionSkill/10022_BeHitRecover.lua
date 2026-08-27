local bs_10022 = class("bs_10022", LuaSkillBase)
local base = LuaSkillBase
bs_10022.config = {
  effectId = 1008,
  heal_config = {
    baseheal_formula = 10087,
    correct_formula = 9990,
    heal_number = 0
  }
}

function bs_10022:ctor()
end

function bs_10022:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10022_3", 1, self.OnAfterHurt, nil, self.caster)
  self.heal_config = {}
end

function bs_10022:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] and self:IsReadyToTake() then
    self:PlayChipEffect()
    self:OnSkillTake()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillBack)
    self:PlayChipEffect()
  end
end

function bs_10022:SkillBack(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10022
