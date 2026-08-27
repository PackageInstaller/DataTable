local card_20016 = class("card_20016", LuaSkillBase)
local base = LuaSkillBase
card_20016.config = {}

function card_20016:ctor()
end

function card_20016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("card_20016_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, nil)
end

function card_20016:OnSetHurt(context)
  if context.sender == self.caster and context.skill.skillTag == eSkillTag.commonAttack then
    context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
  end
end

function card_20016:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20016
