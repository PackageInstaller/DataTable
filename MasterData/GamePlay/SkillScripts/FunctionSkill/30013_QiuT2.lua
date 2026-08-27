local bs_30013 = class("bs_30013", LuaSkillBase)
local base = LuaSkillBase
bs_30013.config = {}

function bs_30013:ctor()
end

function bs_30013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["30013_arg"] = true
end

function bs_30013:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30013
