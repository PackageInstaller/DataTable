local bs_7022 = class("bs_7022", LuaSkillBase)
local base = LuaSkillBase
bs_7022.config = {}

function bs_7022:ctor()
end

function bs_7022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_7022_1", 1, self.OnSetHurt, nil, self.caster)
end

function bs_7022:OnSetHurt(context)
  if context.hurt < self.arglist[1] then
    context.hurt = context.hurt * self.arglist[2] // 1000
  else
    context.hurt = context.hurt * self.arglist[3] // 1000
  end
end

function bs_7022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7022
