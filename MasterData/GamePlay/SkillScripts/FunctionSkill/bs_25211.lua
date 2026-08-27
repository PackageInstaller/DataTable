local bs_25211 = class("bs_25211", LuaSkillBase)
local base = LuaSkillBase
bs_25211.config = {}

function bs_25211:ctor()
end

function bs_25211:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["25211_Flag"] = true
  self.caster.recordTable["25211_arg"] = self.arglist[1]
end

function bs_25211:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25211
