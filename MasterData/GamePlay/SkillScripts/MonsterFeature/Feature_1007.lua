local bs_1007 = class("bs_1007", LuaSkillBase)
local base = LuaSkillBase
bs_1007.config = {
  real_Config = {
    hit_formula = 0,
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0,
    hurt_type = 2
  }
}

function bs_1007:ctor()
end

function bs_1007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1007", 9, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, nil, false)
end

function bs_1007:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isTriggerSet ~= true and 0 < hurt and hurtType == 1 then
    LuaSkillCtrl:CallRealDamage(self, sender, nil, self.config.real_Config, {
      hurt * self.arglist[1] // 1000
    }, true)
  end
end

function bs_1007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1007
