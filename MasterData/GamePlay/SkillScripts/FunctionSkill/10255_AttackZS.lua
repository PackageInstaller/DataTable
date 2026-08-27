local bs_10255 = class("bs_10255", LuaSkillBase)
local base = LuaSkillBase
bs_10255.config = {}

function bs_10255:ctor()
end

function bs_10255:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_10255:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10255
