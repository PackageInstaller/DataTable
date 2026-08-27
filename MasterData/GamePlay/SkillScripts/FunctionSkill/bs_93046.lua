local bs_93046 = class("bs_93046", LuaSkillBase)
local base = LuaSkillBase
bs_93046.config = {}

function bs_93046:ctor()
end

function bs_93046:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_93046:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93046
