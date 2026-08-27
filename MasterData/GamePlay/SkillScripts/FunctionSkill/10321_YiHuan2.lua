local bs_10321 = class("bs_10321", LuaSkillBase)
local base = LuaSkillBase
bs_10321.config = {}

function bs_10321:ctor()
end

function bs_10321:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_10321:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10321
