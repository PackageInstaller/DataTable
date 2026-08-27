local bs_92093 = class("bs_92093", LuaSkillBase)
local base = LuaSkillBase
bs_92093.config = {}

function bs_92093:ctor()
end

function bs_92093:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_92093:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92093
