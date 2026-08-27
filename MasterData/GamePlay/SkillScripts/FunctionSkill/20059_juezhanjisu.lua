local bs_20059 = class("bs_20059", LuaSkillBase)
local base = LuaSkillBase
bs_20059.config = {}

function bs_20059:ctor()
end

function bs_20059:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20059_1", 1, self.OnAfterBattleStart)
end

function bs_20059:OnAfterBattleStart()
  local Value = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, Value)
end

function bs_20059:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20059
