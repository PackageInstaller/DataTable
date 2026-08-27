local bs_4008 = class("bs_4008", LuaSkillBase)
local base = LuaSkillBase
bs_4008.config = {buffId = 80, buffTier = 10}

function bs_4008:ctor()
end

function bs_4008:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4008_1", 1, self.OnAfterBattleStart)
end

function bs_4008:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier)
end

function bs_4008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4008
