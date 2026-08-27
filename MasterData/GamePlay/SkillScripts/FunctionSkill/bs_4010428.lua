local bs_4010428 = class("bs_4010428", LuaSkillBase)
local base = LuaSkillBase
bs_4010428.config = {}

function bs_4010428:ctor()
end

function bs_4010428:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_4010428:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010428
