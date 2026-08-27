local bs_200603 = class("bs_200603", LuaSkillBase)
local base = LuaSkillBase
bs_200603.config = {buffId = 1169, buffTier = 1}

function bs_200603:ctor()
end

function bs_200603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200603_1", 1, self.OnAfterBattleStart)
end

function bs_200603:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_200603:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200603
