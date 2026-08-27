local bs_20179 = class("bs_20179", LuaSkillBase)
local base = LuaSkillBase
bs_20179.config = {}

function bs_20179:ctor()
end

function bs_20179:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.RootAddGrid = true
end

function bs_20179:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20179
