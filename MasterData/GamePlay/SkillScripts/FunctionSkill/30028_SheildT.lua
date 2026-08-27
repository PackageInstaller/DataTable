local bs_30028 = class("bs_30028", LuaSkillBase)
local base = LuaSkillBase
bs_30028.config = {
  heal_config = {
    baseheal_formula = 10106,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_30028:ctor()
end

function bs_30028:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_30028_2", 1, self.OnBreakShield)
end

function bs_30028:OnBreakShield(shieldType, sender, target)
  if target.belongNum == self.caster.belongNum and shieldType ~= eShieldType.Beelneith and self:IsReadyToTake() then
    self:OnSkillTake()
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true, true)
    skillResult:EndResult()
  end
end

function bs_30028:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30028
