local bs_50010 = class("bs_50010", LuaSkillBase)
local base = LuaSkillBase
bs_50010.config = {}

function bs_50010:ctor()
end

function bs_50010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_50010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50010
