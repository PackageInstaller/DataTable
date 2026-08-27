local Feature_1024 = class("Feature_1024", LuaSkillBase)
local base = LuaSkillBase
Feature_1024.config = {}

function Feature_1024:ctor()
end

function Feature_1024:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "Feature_1024", 1, self.OnAfterBattleStart)
end

function Feature_1024:OnAfterBattleStart()
  local shieldValue = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
end

function Feature_1024:OnCasterDie()
  base.OnCasterDie(self)
end

return Feature_1024
