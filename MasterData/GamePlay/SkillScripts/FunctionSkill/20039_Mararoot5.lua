local bs_20039 = class("bs_20039", LuaSkillBase)
local base = LuaSkillBase
bs_20039.config = {}

function bs_20039:ctor()
end

function bs_20039:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30001 and self.caster.roleDataId ~= 30002 then
    return
  end
  self.caster.recordTable["20039_root5arg"] = true
end

function bs_20039:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20039
