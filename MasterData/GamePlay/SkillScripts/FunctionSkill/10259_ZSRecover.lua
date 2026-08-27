local bs_10259 = class("bs_10259", LuaSkillBase)
local base = LuaSkillBase
bs_10259.config = {}

function bs_10259:ctor()
end

function bs_10259:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_10259:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10259
