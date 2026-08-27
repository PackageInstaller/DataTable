local bs_25206 = class("bs_25206", LuaSkillBase)
local base = LuaSkillBase
bs_25206.config = {}

function bs_25206:ctor()
end

function bs_25206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["25206_Flag"] = true
  self.caster.recordTable["25206_arg"] = self.arglist[1]
end

function bs_25206:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25206
