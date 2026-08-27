local bs_21039 = class("bs_21039", LuaSkillBase)
local base = LuaSkillBase
bs_21039.config = {}

function bs_21039:ctor()
end

function bs_21039:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_21039:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21039
