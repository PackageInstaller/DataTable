local bs_25200 = class("bs_25200", LuaSkillBase)
local base = LuaSkillBase
bs_25200.config = {}

function bs_25200:ctor()
end

function bs_25200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["25200_Flag"] = true
  self.caster.recordTable["25200_arg"] = self.arglist[1]
end

function bs_25200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25200
