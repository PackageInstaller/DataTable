local bs_31003 = class("bs_31003", LuaSkillBase)
local base = LuaSkillBase
bs_31003.config = {}

function bs_31003:ctor()
end

function bs_31003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.bs_31003 = true
end

function bs_31003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_31003
