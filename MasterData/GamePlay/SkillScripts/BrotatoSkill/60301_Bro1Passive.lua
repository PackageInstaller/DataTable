local bs_60301 = class("bs_60301", LuaSkillBase)
local base = LuaSkillBase
bs_60301.config = {}

function bs_60301:ctor()
end

function bs_60301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.hurt = self.arglist[1]
end

function bs_60301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_60301
