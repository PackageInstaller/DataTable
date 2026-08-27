local bs_20178 = class("bs_20178", LuaSkillBase)
local base = LuaSkillBase
bs_20178.config = {}

function bs_20178:ctor()
end

function bs_20178:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.RootCurseUp = self.arglist[1]
end

function bs_20178:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20178
