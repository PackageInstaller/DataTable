local card_10016 = class("card_10016", LuaSkillBase)
local base = LuaSkillBase
card_10016.config = {}

function card_10016:ctor()
end

function card_10016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("card_10016_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, nil)
end

function card_10016:OnSetHurt(context)
  if context.sender == self.caster and context.skill.skillTag == eSkillTag.commonAttack then
    context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
  end
end

function card_10016:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10016
