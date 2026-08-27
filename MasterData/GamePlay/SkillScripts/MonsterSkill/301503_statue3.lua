local bs_301503 = class("bs_301503", LuaSkillBase)
local base = LuaSkillBase
bs_301503.config = {}

function bs_301503:ctor()
end

function bs_301503:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_301503:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_301503
