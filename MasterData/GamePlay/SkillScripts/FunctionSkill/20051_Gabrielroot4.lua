local bs_20051 = class("bs_20051", LuaSkillBase)
local base = LuaSkillBase
bs_20051.config = {}

function bs_20051:ctor()
end

function bs_20051:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30004 and self.caster.roleDataId ~= 300040 then
    return
  end
  self.caster.recordTable["20051_root4arg1"] = self.arglist[1]
end

function bs_20051:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20051
