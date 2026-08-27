local bs_15347 = class("bs_15347", LuaSkillBase)
local base = LuaSkillBase
bs_15347.config = {}

function bs_15347:ctor()
end

function bs_15347:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_15347:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15347
