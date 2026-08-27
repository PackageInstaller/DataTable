local bs_10185 = class("bs_10185", LuaSkillBase)
local base = LuaSkillBase
bs_10185.config = {
  sheildBuffId = 174,
  hurt_config = {basehurt_formula = 10007}
}

function bs_10185:ctor()
end

function bs_10185:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10185_2", 1, self.OnSetHurt, self.caster)
end

function bs_10185:OnSetHurt(context)
  if context.sender == self.caster and not context.isTriggerSet and self:IsReadyToTake() and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    local value = LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange)
    local value2 = LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange)
    if 0 < value or 0 < value2 then
      self:OnSkillTake()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
      skillResult:EndResult()
    end
  end
end

function bs_10185:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10185
