local bs_30041 = class("bs_30041", LuaSkillBase)
local base = LuaSkillBase
bs_30041.config = {}

function bs_30041:ctor()
end

function bs_30041:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["30041_Flag"] = true
  self.caster.recordTable["30041_arg"] = self.arglist[1]
end

function bs_30041:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30041
