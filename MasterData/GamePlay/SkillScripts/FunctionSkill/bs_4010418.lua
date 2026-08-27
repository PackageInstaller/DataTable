local bs_4010418 = class("bs_4010418", LuaSkillBase)
local base = LuaSkillBase
bs_4010418.config = {}

function bs_4010418:ctor()
end

function bs_4010418:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_4010418:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010418
