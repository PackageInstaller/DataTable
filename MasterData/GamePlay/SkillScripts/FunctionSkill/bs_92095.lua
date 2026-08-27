local bs_92095 = class("bs_92095", LuaSkillBase)
local base = LuaSkillBase
bs_92095.config = {}

function bs_92095:ctor()
end

function bs_92095:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_92095:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92095
