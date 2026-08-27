local bs_20176 = class("bs_20176", LuaSkillBase)
local base = LuaSkillBase
bs_20176.config = {}

function bs_20176:ctor()
end

function bs_20176:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.root4 = true
end

function bs_20176:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20176
