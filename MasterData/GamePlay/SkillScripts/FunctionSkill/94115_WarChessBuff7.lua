local bs_94115 = class("bs_94115", LuaSkillBase)
local base = LuaSkillBase
bs_94115.config = {}

function bs_94115:ctor()
end

function bs_94115:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_94115_1", 1, self.OnAfterBattleStart)
end

function bs_94115:OnAfterBattleStart()
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, self.caster.maxHp * self.arglist[1] * self.level // 1000)
end

function bs_94115:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94115
