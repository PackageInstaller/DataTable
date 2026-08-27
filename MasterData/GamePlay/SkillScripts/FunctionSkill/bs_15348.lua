local bs_15348 = class("bs_15348", LuaSkillBase)
local base = LuaSkillBase
bs_15348.config = {}

function bs_15348:ctor()
end

function bs_15348:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_15348:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15348
