local bs_4001405 = class("bs_4001405", LuaSkillBase)
local base = LuaSkillBase
bs_4001405.config = {}

function bs_4001405:ctor()
end

function bs_4001405:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001405_1", 1, self.OnAfterBattleStart)
end

function bs_4001405:OnAfterBattleStart()
  if self.caster ~= nil and self.caster.maxHp > 0 then
    local value = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, value)
  end
end

function bs_4001405:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001405
