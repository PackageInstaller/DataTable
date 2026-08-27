local bs_104401 = class("bs_104401", LuaSkillBase)
local base = LuaSkillBase
bs_104401.config = {}

function bs_104401:ctor()
end

function bs_104401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["self.roll"] = self.arglist[1]
  self.caster.recordTable["self.number"] = self.arglist[2]
  self.caster.recordTable["self.max"] = self.arglist[3]
end

function bs_104401:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104401
