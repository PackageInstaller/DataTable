local bs_10043 = class("bs_10043", LuaSkillBase)
local base = LuaSkillBase
bs_10043.config = {}

function bs_10043:ctor()
end

function bs_10043:InitSkill(isMidwaySkill)
end

function bs_10043:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10043
