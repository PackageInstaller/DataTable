local bs_92092 = class("bs_92092", LuaSkillBase)
local base = LuaSkillBase
bs_92092.config = {}

function bs_92092:ctor()
end

function bs_92092:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_92092:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92092
