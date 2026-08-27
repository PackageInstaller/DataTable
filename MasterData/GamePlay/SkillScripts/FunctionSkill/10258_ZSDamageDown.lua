local bs_10258 = class("bs_10258", LuaSkillBase)
local base = LuaSkillBase
bs_10258.config = {}

function bs_10258:ctor()
end

function bs_10258:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_10258:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10258
