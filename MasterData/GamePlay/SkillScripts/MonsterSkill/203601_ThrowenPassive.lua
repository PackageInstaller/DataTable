local bs_203601 = class("bs_203601", LuaSkillBase)
local base = LuaSkillBase
bs_203601.config = {}

function bs_203601:ctor()
end

function bs_203601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.attack = 1
  self.caster.recordTable.arg = self.arglist[1]
end

function bs_203601:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203601
