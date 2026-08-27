local bs_10030 = class("bs_10030", LuaSkillBase)
local base = LuaSkillBase
bs_10030.config = {hurtNumFormula = 10007}

function bs_10030:ctor()
end

function bs_10030:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_10030_1", 1, self.OnSetHurt, self.caster)
end

function bs_10030:OnSetHurt(context)
  if context.sender == self.caster and not context.isMiss and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    local damage = math.max(LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.hurtNumFormula, self.caster, context.target, self), 1)
    LuaSkillCtrl:RemoveLife(damage, self, context.target, true, nil, true, false, eHurtType.RealDmg)
  end
end

function bs_10030:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10030
