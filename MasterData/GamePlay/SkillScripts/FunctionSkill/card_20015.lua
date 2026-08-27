local card_20015 = class("card_20015", LuaSkillBase)
local base = LuaSkillBase
card_20015.config = {}

function card_20015:ctor()
end

function card_20015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("card_20015_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill, nil)
end

function card_20015:OnSetHurt(context)
  if context.sender == self.caster and context.skill.skillTag == eSkillTag.ultSkill then
    context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
  end
end

function card_20015:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20015
