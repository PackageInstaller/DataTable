local bs_20175 = class("bs_20175", LuaSkillBase)
local base = LuaSkillBase
bs_20175.config = {}

function bs_20175:ctor()
end

function bs_20175:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.shieldValue = self.caster.recordTable.shieldValue + self.caster.maxHp * self.arglist[1] // 1000
end

function bs_20175:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20175
