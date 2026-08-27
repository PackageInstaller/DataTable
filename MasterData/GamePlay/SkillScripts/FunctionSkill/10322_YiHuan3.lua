local bs_10322 = class("bs_10322", LuaSkillBase)
local base = LuaSkillBase
bs_10322.config = {}

function bs_10322:ctor()
end

function bs_10322:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_10322:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10322
