local bs_10256 = class("bs_10256", LuaSkillBase)
local base = LuaSkillBase
bs_10256.config = {}

function bs_10256:ctor()
end

function bs_10256:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_10256:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10256
