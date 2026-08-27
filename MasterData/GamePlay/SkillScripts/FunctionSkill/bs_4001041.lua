local bs_4001041 = class("bs_4001041", LuaSkillBase)
local base = LuaSkillBase
bs_4001041.config = {}

function bs_4001041:ctor()
end

function bs_4001041:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_4001041:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001041
