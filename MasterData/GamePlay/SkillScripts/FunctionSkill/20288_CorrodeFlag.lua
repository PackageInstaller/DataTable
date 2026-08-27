local bs_20288 = class("bs_20288", LuaSkillBase)
local base = LuaSkillBase
bs_20288.config = {}

function bs_20288:ctor()
end

function bs_20288:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.croode_degree = self.level
end

function bs_20288:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20288
