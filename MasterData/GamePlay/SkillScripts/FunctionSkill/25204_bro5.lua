local bs_25204 = class("bs_25204", LuaSkillBase)
local base = LuaSkillBase
bs_25204.config = {}

function bs_25204:ctor()
end

function bs_25204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["25204_Flag"] = true
  self.caster.recordTable["25204_arg"] = self.arglist[1]
end

function bs_25204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25204
