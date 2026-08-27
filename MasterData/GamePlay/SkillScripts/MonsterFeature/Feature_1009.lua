local bs_1009 = class("bs_1009", LuaSkillBase)
local base = LuaSkillBase
bs_1009.config = {}

function bs_1009:ctor()
end

function bs_1009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_100301_2", 1, self.OnSetHurt, nil, self.caster)
end

function bs_1009:OnSetHurt(context)
  if context.target == self.caster and context.skill.SkillRange ~= nil and context.skill.SkillRange == 1 then
    context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
  end
  if context.target == self.caster and context.skill.SkillRange ~= nil and context.skill.SkillRange > 1 then
    context.hurt = context.hurt * (1000 + self.arglist[2]) // 1000
  end
end

function bs_1009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1009
