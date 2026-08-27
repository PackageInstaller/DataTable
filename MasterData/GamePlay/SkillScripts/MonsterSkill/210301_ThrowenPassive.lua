local bs_210301 = class("bs_210301", LuaSkillBase)
local base = LuaSkillBase
bs_210301.config = {}

function bs_210301:ctor()
end

function bs_210301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.attack = 1
  self.caster.recordTable.arg = self.arglist[1]
end

function bs_210301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_210301
