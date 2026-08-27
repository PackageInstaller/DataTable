local bs_400002 = class("bs_400002", LuaSkillBase)
local base = LuaSkillBase
bs_400002.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10031,
    crit_formula = 0
  }
}

function bs_400002:ctor()
end

function bs_400002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_400002_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_400002:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and not isTriggerSet then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_400002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_400002
