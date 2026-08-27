local bs_10302 = class("bs_10302", LuaSkillBase)
local base = LuaSkillBase
bs_10302.config = {}

function bs_10302:ctor()
end

function bs_10302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["10302_arg"] = self.arglist[1]
end

function bs_10302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10302
