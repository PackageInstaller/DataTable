local bs_10065 = class("bs_10065", LuaSkillBase)
local base = LuaSkillBase
bs_10065.config = {
  hurt_config = {basehurt_formula = 10007},
  effectId = 1002
}

function bs_10065:ctor()
end

function bs_10065:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10065_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddSetHurtTrigger("bs_10065_4", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, self.cskill.dataId)
end

function bs_10065:OnSetHurt(context)
  if context.sender == self.caster and context.skill == self.cskill then
    context.isTriggerSet = true
  end
end

function bs_10065:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and sender ~= nil and sender.hp > 0 and self:IsReadyToTake() and skill ~= self.cskill then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender, self.config)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    LuaSkillCtrl:CallEffect(sender, self.config.effectId, self)
    self:PlayChipEffect()
    skillResult:EndResult()
    self:OnSkillTake()
  end
end

function bs_10065:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10065
