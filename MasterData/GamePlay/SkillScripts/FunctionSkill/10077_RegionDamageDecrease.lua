local bs_10077 = class("bs_10077", LuaSkillBase)
local base = LuaSkillBase
bs_10077.config = {}

function bs_10077:ctor()
end

function bs_10077:InitSkill(isMidwaySkill)
end

function bs_10077:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10077
