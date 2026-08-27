local bs_92094 = class("bs_92094", LuaSkillBase)
local base = LuaSkillBase
bs_92094.config = {}

function bs_92094:ctor()
end

function bs_92094:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_92094:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92094
