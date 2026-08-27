local bs_202101 = class("bs_202101", LuaSkillBase)
local base = LuaSkillBase
bs_202101.config = {}

function bs_202101:ctor()
end

function bs_202101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_202101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202101
