local bs_301504 = class("bs_301504", LuaSkillBase)
local base = LuaSkillBase
bs_301504.config = {}

function bs_301504:ctor()
end

function bs_301504:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_301504:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_301504
