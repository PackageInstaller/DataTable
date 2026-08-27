local bs_20036 = class("bs_20036", LuaSkillBase)
local base = LuaSkillBase
bs_20036.config = {}

function bs_20036:ctor()
end

function bs_20036:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30001 and self.caster.roleDataId ~= 30002 and self.caster.roleDataId ~= 300010 then
    return
  end
  self:AddSetHurtTrigger("bs_20036_2", 1, self.OnSetHurt, self.caster)
  self.caster.recordTable["20036_root2arg"] = true
end

function bs_20036:OnSetHurt(context)
  if context.sender == self.caster and context.skill.dataId == 200903 then
    context.hurt = context.hurt - context.hurt * self.arglist[1] // 1000
  end
end

function bs_20036:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20036
