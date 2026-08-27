local bs_20017 = class("bs_20017", LuaSkillBase)
local base = LuaSkillBase
bs_20017.config = {}

function bs_20017:ctor()
end

function bs_20017:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_20017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20017
