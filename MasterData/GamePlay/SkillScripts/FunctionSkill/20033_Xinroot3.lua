local bs_20033 = class("bs_20033", LuaSkillBase)
local base = LuaSkillBase
bs_20033.config = {}

function bs_20033:ctor()
end

function bs_20033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30000 then
    return
  end
  self:AddSetHurtTrigger("bs_20033_2", 1, self.OnSetHurt, self.caster)
end

function bs_20033:OnSetHurt(context)
  if context.sender == self.caster and context.skill.dataId == 300001 then
    context.hurt = context.hurt * 2
  end
end

function bs_20033:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20033
