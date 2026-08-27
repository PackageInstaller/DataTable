local bs_21017 = class("bs_21017", LuaSkillBase)
local base = LuaSkillBase
bs_21017.config = {}

function bs_21017:ctor()
end

function bs_21017:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21017_1", 1, self.OnAfterBattleStart)
end

function bs_21017:OnAfterBattleStart()
  local Value = math.max(1, self.arglist[1] * self.caster.maxHp // 1000)
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, Value)
end

function bs_21017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21017
