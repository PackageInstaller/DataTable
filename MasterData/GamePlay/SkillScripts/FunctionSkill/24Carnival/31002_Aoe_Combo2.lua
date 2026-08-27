local bs_31002 = class("bs_31002", LuaSkillBase)
local base = LuaSkillBase
bs_31002.config = {}

function bs_31002:ctor()
end

function bs_31002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.bs_31002 = true
end

function bs_31002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_31002
