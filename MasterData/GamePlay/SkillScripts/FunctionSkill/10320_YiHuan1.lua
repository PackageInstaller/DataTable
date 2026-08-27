local bs_10320 = class("bs_10320", LuaSkillBase)
local base = LuaSkillBase
bs_10320.config = {}

function bs_10320:ctor()
end

function bs_10320:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_10320:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10320
