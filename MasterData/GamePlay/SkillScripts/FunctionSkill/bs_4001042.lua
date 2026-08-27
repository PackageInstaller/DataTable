local bs_4001042 = class("bs_4001042", LuaSkillBase)
local base = LuaSkillBase
bs_4001042.config = {}

function bs_4001042:ctor()
end

function bs_4001042:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_4001042:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001042
