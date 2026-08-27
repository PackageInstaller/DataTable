local bs_204203 = class("bs_204203", LuaSkillBase)
local base = LuaSkillBase
bs_204203.config = {}

function bs_204203:ctor()
end

function bs_204203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_204203:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_204203
