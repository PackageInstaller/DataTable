local bs_25202 = class("bs_25202", LuaSkillBase)
local base = LuaSkillBase
bs_25202.config = {}

function bs_25202:ctor()
end

function bs_25202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["25202_Flag"] = true
  self.caster.recordTable["25202_arg"] = self.arglist[1]
end

function bs_25202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25202
