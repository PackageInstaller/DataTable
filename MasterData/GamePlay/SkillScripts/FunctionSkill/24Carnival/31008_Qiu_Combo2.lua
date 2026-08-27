local bs_31008 = class("bs_31008", LuaSkillBase)
local base = LuaSkillBase
bs_31008.config = {}

function bs_31008:ctor()
end

function bs_31008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.bs_31008 = true
end

function bs_31008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_31008
