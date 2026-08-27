local bs_60401 = class("bs_60401", LuaSkillBase)
local base = LuaSkillBase
bs_60401.config = {}

function bs_60401:ctor()
end

function bs_60401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.hurt = self.arglist[1]
end

function bs_60401:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_60401
