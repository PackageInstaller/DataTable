local bs_10215 = class("bs_10215", LuaSkillBase)
local base = LuaSkillBase
bs_10215.config = {
  heal_config = {
    baseheal_formula = 10011,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId = 1048,
  buffId = 1125
}

function bs_10215:ctor()
end

function bs_10215:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10215_3", 1, self.OnAfterHurt, nil, nil, self.caster.belongNum)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10215_1", 1, self.OnAfterBattleStart)
end

function bs_10215:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_10215:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.belongNum == self.caster.belongNum and isCrit and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_10215:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.heal_config)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10215:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10215
