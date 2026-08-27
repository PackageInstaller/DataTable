local bs_4001043 = class("bs_4001043", LuaSkillBase)
local base = LuaSkillBase
bs_4001043.config = {}

function bs_4001043:ctor()
end

function bs_4001043:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_4001043:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001043
