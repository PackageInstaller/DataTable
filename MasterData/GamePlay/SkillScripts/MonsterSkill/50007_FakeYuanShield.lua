local bs_50007 = class("bs_50007", LuaSkillBase)
local base = LuaSkillBase
bs_50007.config = {}

function bs_50007:ctor()
end

function bs_50007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_50007_2", 1, self.OnSetHurt, nil, self.caster)
end

function bs_50007:OnSetHurt(context)
  if context.sender.attackRange > 1 and context.target == self.caster then
    context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
  end
end

function bs_50007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50007
