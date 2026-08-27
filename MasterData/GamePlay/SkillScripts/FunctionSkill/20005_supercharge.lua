local bs_20005 = class("bs_20005", LuaSkillBase)
local base = LuaSkillBase
bs_20005.config = {formula = 10106}

function bs_20005:ctor()
end

function bs_20005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_20005_2", 1, self.OnSetHurt, self.caster)
end

function bs_20005:OnSetHurt(context)
  if context.skill.isCommonAttack and context.sender == self.caster and context.target.intensity < 3 and not context.isMiss then
    local baseHurt = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.formula, self.caster, context.target, self)
    if baseHurt >= context.hurt then
      local triggerhurt = baseHurt - context.hurt
      local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 14, {triggerhurt}, true, true)
    end
  end
end

function bs_20005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20005
