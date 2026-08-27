local bs_25020 = class("bs_25020", LuaSkillBase)
local base = LuaSkillBase
bs_25020.config = {}

function bs_25020:ctor()
end

function bs_25020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25020_1", 1, self.OnAfterBattleStart)
end

function bs_25020:OnAfterBattleStart()
  local value = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:RemoveLife(value, self, self.caster, true, nil, true, true, eHurtType.RealDmg)
end

function bs_25020:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25020
