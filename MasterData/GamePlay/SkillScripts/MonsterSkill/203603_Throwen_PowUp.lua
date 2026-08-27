local bs_203603 = class("bs_203603", LuaSkillBase)
local base = LuaSkillBase
bs_203603.config = {buffId = 1172, buffTier = 1}

function bs_203603:ctor()
end

function bs_203603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_203603_1", 1, self.OnAfterBattleStart)
end

function bs_203603:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_203603:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203603
