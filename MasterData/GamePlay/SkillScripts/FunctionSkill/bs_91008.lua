local bs_91008 = class("bs_91008", LuaSkillBase)
local base = LuaSkillBase
bs_91008.config = {}

function bs_91008:ctor()
end

function bs_91008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91008_1", 1, self.OnAfterBattleStart)
end

function bs_91008:OnAfterBattleStart()
  local shieldValue = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
end

function bs_91008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91008
