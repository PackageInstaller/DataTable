local bs_1003 = class("bs_1003", LuaSkillBase)
local base = LuaSkillBase
bs_1003.config = {
  real_Config = {
    hit_formula = 0,
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0,
    hurt_type = 2
  }
}

function bs_1003:ctor()
end

function bs_1003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1003", 9, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, nil, false)
end

function bs_1003:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isTriggerSet ~= true and 0 < hurt and hurtType == 0 then
    LuaSkillCtrl:CallRealDamage(self, sender, nil, self.config.real_Config, {
      hurt * self.arglist[1] // 1000
    }, true)
  end
end

function bs_1003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1003
