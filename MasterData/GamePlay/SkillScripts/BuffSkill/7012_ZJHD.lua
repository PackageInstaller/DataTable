local bs_7012 = class("bs_7012", LuaSkillBase)
local base = LuaSkillBase
bs_7012.config = {
  formula = 10106,
  effectId = 10813,
  buffId = 1149
}

function bs_7012:ctor()
end

function bs_7012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_7012_2", 1, self.OnSetDeadHurt, nil, self.caster)
end

function bs_7012:OnSetDeadHurt(context)
  if context.target == self.caster then
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.formula, nil, context.target, self)
    LuaSkillCtrl:CallHeal(healNum, self, context.target, true)
    local buffId = LuaSkillCtrl:GetSkillBindBuffId(self)
    LuaSkillCtrl:DispelBuff(self.caster, buffId, 1)
  end
end

function bs_7012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7012
