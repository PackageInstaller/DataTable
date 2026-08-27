local bs_4007 = class("bs_4007", LuaSkillBase)
local base = LuaSkillBase
bs_4007.config = {buffId = 81, buffTier = 40}

function bs_4007:ctor()
end

function bs_4007:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4007_1", 1, self.OnAfterBattleStart)
end

function bs_4007:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier)
end

function bs_4007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4007
