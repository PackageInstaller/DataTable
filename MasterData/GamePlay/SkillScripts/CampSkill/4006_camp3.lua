local bs_4006 = class("bs_4006", LuaSkillBase)
local base = LuaSkillBase
bs_4006.config = {buffId = 81, buffTier = 25}

function bs_4006:ctor()
end

function bs_4006:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4006_1", 1, self.OnAfterBattleStart)
end

function bs_4006:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier)
end

function bs_4006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4006
