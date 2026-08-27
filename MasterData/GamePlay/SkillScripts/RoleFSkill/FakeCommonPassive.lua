local base = LuaSkillBase
local FakeCommonPassive = class("FakeCommonPassive", base)
FakeCommonPassive.config = {}

function FakeCommonPassive:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.hero_enemy = true
end

return FakeCommonPassive
