local card_10015 = class("card_10015", LuaSkillBase)
local base = LuaSkillBase
card_10015.config = {}

function card_10015:ctor()
end

function card_10015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("card_10015_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill, nil)
end

function card_10015:OnSetHurt(context)
  if context.sender == self.caster and context.skill.skillTag == eSkillTag.ultSkill then
    context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
  end
end

function card_10015:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10015
