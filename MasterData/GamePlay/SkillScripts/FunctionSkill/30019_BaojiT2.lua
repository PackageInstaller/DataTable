local bs_30019 = class("bs_30019", LuaSkillBase)
local base = LuaSkillBase
bs_30019.config = {
  buffId = 1176,
  buffTier = 1,
  heal_config = {
    baseheal_formula = 10166,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_30019:ctor()
end

function bs_30019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30019_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_30019_3", 1, self.OnAfterHurt, self.caster)
end

function bs_30019:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_30019:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit and self:IsReadyToTake() then
    self:OnSkillTake()
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {hurt}, true, true)
  end
end

function bs_30019:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30019
