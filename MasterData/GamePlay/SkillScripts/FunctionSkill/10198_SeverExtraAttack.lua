local bs_10198 = class("bs_10198", LuaSkillBase)
local base = LuaSkillBase
bs_10198.config = {damageFormula = 10011}

function bs_10198:ctor()
end

function bs_10198:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10198_2", 1, self.OnSetHurt, nil, self.caster, eBattleRoleBelong.neutral)
end

function bs_10198:OnSetHurt(context)
  if context.sender.belongNum == 0 and context.target == self.caster and not context.isTriggerSet then
    context.hurt = context.hurt + context.hurt * self.arglist[1] // 1000
    self:PlayChipEffect()
  end
end

function bs_10198:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10198
