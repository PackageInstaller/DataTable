local bs_20046 = class("bs_20046", LuaSkillBase)
local base = LuaSkillBase
bs_20046.config = {}

function bs_20046:ctor()
end

function bs_20046:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30003 and self.caster.roleDataId ~= 300030 then
    return
  end
  self.caster.recordTable["20046_root4arg1"] = self.arglist[1]
end

function bs_20046:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20046
