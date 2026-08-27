local bs_202102 = class("bs_202102", LuaSkillBase)
local base = LuaSkillBase
bs_202102.config = {}

function bs_202102:ctor()
end

function bs_202102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_202102:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202102
