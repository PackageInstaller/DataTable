local bs_15139 = class("bs_15139", LuaSkillBase)
local base = LuaSkillBase
bs_15139.config = {buffId = 1121, buffId1 = 110092}

function bs_15139:ctor()
end

function bs_15139:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15139_1", 1, self.OnAfterBattleStart)
end

function bs_15139:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  self:PlayChipEffect()
end

function bs_15139:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15139
