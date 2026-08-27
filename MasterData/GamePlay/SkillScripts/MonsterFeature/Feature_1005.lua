local bs_1005 = class("bs_1005", LuaSkillBase)
local base = LuaSkillBase
bs_1005.config = {}

function bs_1005:ctor()
end

function bs_1005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_1005", 1, self.OnSetHurt, nil, self.caster)
end

function bs_1005:OnSetHurt(context)
  if context.target == self.caster and context.hurt_type == 1 then
    context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
  end
  if context.target == self.caster and context.hurt_type == 0 then
    context.hurt = context.hurt * (1000 + self.arglist[2]) // 1000
  end
end

function bs_1005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1005
