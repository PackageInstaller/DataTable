local bs_93045 = class("bs_93045", LuaSkillBase)
local base = LuaSkillBase
bs_93045.config = {}

function bs_93045:ctor()
end

function bs_93045:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_93045:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93045
