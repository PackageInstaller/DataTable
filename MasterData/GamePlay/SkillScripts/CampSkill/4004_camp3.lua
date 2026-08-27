local bs_4004 = class("bs_4004", LuaSkillBase)
local base = LuaSkillBase
bs_4004.config = {buffId = 81, buffTier = 10}

function bs_4004:ctor()
end

function bs_4004:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4004_1", 1, self.OnAfterBattleStart)
end

function bs_4004:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier)
end

function bs_4004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4004
