local bs_94102 = class("bs_94102", LuaSkillBase)
local base = LuaSkillBase
bs_94102.config = {}

function bs_94102:ctor()
end

function bs_94102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_94102_1", 1, self.OnAfterBattleStart)
end

function bs_94102:OnAfterBattleStart()
  local hurt = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, self.caster, true, nil, true, true, eHurtType.RealDmg)
end

function bs_94102:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94102
