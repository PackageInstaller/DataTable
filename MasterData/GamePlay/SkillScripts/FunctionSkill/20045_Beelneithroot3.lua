local bs_20045 = class("bs_20045", LuaSkillBase)
local base = LuaSkillBase
bs_20045.config = {}

function bs_20045:ctor()
end

function bs_20045:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30003 and self.caster.roleDataId ~= 300030 then
    return
  end
  self.caster.recordTable["20044_root3arg1"] = self.arglist[1]
end

function bs_20045:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20045
