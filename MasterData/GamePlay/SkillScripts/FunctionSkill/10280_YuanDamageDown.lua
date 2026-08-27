local bs_10280 = class("bs_10280", LuaSkillBase)
local base = LuaSkillBase
bs_10280.config = {}

function bs_10280:ctor()
end

function bs_10280:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10280_setHurt", 1, self.OnSetHurt, nil, self.caster)
end

function bs_10280:OnSetHurt(context)
  if context.target == self.caster and context.skill.SkillRange > 1 then
    context.hurt = context.hurt - context.hurt * self.arglist[1] // 1000
  end
end

function bs_10280:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10280
