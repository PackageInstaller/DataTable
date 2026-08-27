local bs_104501 = class("bs_104501", LuaSkillBase)
local base = LuaSkillBase
bs_104501.config = {}

function bs_104501:ctor()
end

function bs_104501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_104501_1", 10, self.OnAfterBattleStart)
  self.caster.recordTable.EnergyTire = self.arglist[1]
  self.caster.recordTable.DeriveHurt = self.arglist[2]
  self.caster.recordTable.CriticalRate = self.arglist[3]
  self.caster.recordTable.CriticaldamageRate = self.arglist[4]
  self.caster.recordTable.AttackEnergy = 0
end

function bs_104501:OnAfterBattleStart()
  self.caster.recordTable.currentTier = 0
end

function bs_104501:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104501
