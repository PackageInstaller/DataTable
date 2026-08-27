local bs_20050 = class("bs_20050", LuaSkillBase)
local base = LuaSkillBase
bs_20050.config = {}

function bs_20050:ctor()
end

function bs_20050:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30004 and self.caster.roleDataId ~= 300040 then
    return
  end
  self.caster.recordTable["20050_root3arg1"] = self.arglist[1]
end

function bs_20050:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20050
