local bs_27043 = class("bs_27043", LuaSkillBase)
local base = LuaSkillBase
bs_27043.config = {}

function bs_27043:ctor()
end

function bs_27043:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_27043", 1, self.OnAfterBattleStart)
end

function bs_27043:OnAfterBattleStart()
  local value = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, value)
end

function bs_27043:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_27043
