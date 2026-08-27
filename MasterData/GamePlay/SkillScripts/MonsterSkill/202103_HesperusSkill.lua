local bs_202103 = class("bs_202103", LuaSkillBase)
local base = LuaSkillBase
bs_202103.config = {}

function bs_202103:ctor()
end

function bs_202103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_202103:PlaySkill(data)
end

function bs_202103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202103
