local bs_15152 = class("bs_15152", LuaSkillBase)
local base = LuaSkillBase
bs_15152.config = {buffId = 2068}

function bs_15152:ctor()
end

function bs_15152:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_15152:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15152
