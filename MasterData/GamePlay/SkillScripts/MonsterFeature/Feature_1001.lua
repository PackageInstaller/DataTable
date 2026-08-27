local bs_1001 = class("bs_1001", LuaSkillBase)
local base = LuaSkillBase
bs_1001.config = {}

function bs_1001:ctor()
end

function bs_1001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_100301_2", 1, self.OnSetHurt, nil, self.caster)
end

function bs_1001:OnSetHurt(context)
  if context.target == self.caster and context.hurt_type == 0 then
    context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
  end
  if context.target == self.caster and context.hurt_type == 1 then
    context.hurt = context.hurt * (1000 + self.arglist[2]) // 1000
  end
end

function bs_1001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1001
