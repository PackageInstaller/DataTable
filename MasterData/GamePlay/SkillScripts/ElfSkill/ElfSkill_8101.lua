local bs_8101 = class("bs_8101", LuaSkillBase)
local base = LuaSkillBase
bs_8101.config = {buffId = 611}

function bs_8101:ctor()
end

function bs_8101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8101_1", 1, self.OnAfterBattleStart)
end

function bs_8101:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  local heal = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:CallHeal(heal, self, self.caster, true)
end

function bs_8101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8101
