local bs_200702 = class("bs_200702", LuaSkillBase)
local base = LuaSkillBase
bs_200702.config = {buffId = 1172, buffTier = 1}

function bs_200702:ctor()
end

function bs_200702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200702_1", 1, self.OnAfterBattleStart)
end

function bs_200702:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_200702:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200702
