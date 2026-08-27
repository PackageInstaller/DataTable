local bs_207402 = class("bs_207402", LuaSkillBase)
local base = LuaSkillBase
bs_207402.config = {}

function bs_207402:ctor()
end

function bs_207402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.AttackDamage = self.arglist[1]
end

function bs_207402:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207402
