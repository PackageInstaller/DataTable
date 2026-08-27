local bs_20044 = class("bs_20044", LuaSkillBase)
local base = LuaSkillBase
bs_20044.config = {}

function bs_20044:ctor()
end

function bs_20044:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30003 and self.caster.roleDataId ~= 300030 then
    return
  end
  self.caster.recordTable["20044_root2arg1"] = self.arglist[1]
  self.caster.recordTable["20044_root2arg2"] = self.arglist[2]
end

function bs_20044:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20044
