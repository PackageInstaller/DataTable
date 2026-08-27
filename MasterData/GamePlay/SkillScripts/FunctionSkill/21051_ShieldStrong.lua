local bs_21051 = class("bs_21051", LuaSkillBase)
local base = LuaSkillBase
bs_21051.config = {}

function bs_21051:ctor()
end

function bs_21051:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_21051:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21051
