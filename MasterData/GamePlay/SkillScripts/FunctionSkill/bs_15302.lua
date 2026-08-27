local bs_15302 = class("bs_15302", LuaSkillBase)
local base = LuaSkillBase
bs_15302.config = {}

function bs_15302:ctor()
end

function bs_15302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15302_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_15302_5", 1, self.BeforeEndBattle)
  self.value = 0
end

function bs_15302:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(self, 1, function()
    self.value = self.caster.hp * self.arglist[1] // 1000
    self.caster:SubHp(self.value)
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, self.value)
    LuaSkillCtrl:RemoveLife(1, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
  end)
end

function bs_15302:BeforeEndBattle()
  if self.value ~= 0 then
    LuaSkillCtrl:CallHeal(self.value, self, self.caster, true)
  end
end

function bs_15302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15302
