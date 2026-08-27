local bs_25052 = class("bs_25052", LuaSkillBase)
local base = LuaSkillBase
bs_25052.config = {}

function bs_25052:ctor()
end

function bs_25052:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25052_1", 1, self.OnAfterBattleStart)
end

function bs_25052:OnAfterBattleStart()
  local value = self.arglist[1]
  if 0 <= value then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.normal, value)
  end
end

function bs_25052:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25052
