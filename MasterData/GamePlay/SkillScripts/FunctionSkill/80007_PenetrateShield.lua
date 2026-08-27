local bs_80007 = class("bs_80007", LuaSkillBase)
local base = LuaSkillBase
bs_80007.config = {
  real_Config = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 502,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 0,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hurt_type = 2
  }
}

function bs_80007:ctor()
end

function bs_80007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_80007_3", 1, self.OnSetHurt, self.caster)
end

function bs_80007:OnSetHurt(context)
  if context.sender == self.caster and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and LuaSkillCtrl:GetShield(context.target) > 0 then
    local Value = math.max(1, self.arglist[1] * context.hurt // 1000)
    LuaSkillCtrl:CallRealDamage(self, context.target, nil, self.config.real_Config, {Value}, true)
  end
end

function bs_80007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80007
