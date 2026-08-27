local bs_20174 = class("bs_20174", LuaSkillBase)
local base = LuaSkillBase
bs_20174.config = {}

function bs_20174:ctor()
end

function bs_20174:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.JudgeBuffTime = self.caster.recordTable.JudgeBuffTime + self.arglist[1]
end

function bs_20174:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20174
