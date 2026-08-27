local bs_15349 = class("bs_15349", LuaSkillBase)
local base = LuaSkillBase
bs_15349.config = {}

function bs_15349:ctor()
end

function bs_15349:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_15349:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15349
