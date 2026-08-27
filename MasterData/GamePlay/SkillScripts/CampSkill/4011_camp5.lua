local bs_4011 = class("bs_4011", LuaSkillBase)
local base = LuaSkillBase
bs_4011.config = {buffId = 80, buffTier = 30}

function bs_4011:ctor()
end

function bs_4011:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4011_1", 1, self.OnAfterBattleStart)
end

function bs_4011:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier)
end

function bs_4011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4011
