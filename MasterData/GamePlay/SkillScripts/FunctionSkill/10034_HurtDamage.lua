local bs_10034 = class("bs_10034", LuaSkillBase)
local base = LuaSkillBase
bs_10034.config = {
  hurt_config = {basehurt_formula = 10007},
  effectId = 1002
}

function bs_10034:ctor()
end

function bs_10034:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10034_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_10034:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss then
    if sender == nil then
      return
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender, self.config)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    LuaSkillCtrl:CallEffect(sender, self.config.effectId, self)
    self:PlayChipEffect()
    skillResult:EndResult()
  end
end

function bs_10034:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10034
