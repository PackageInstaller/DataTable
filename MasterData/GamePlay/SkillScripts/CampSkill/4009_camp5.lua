local bs_4009 = class("bs_4009", LuaSkillBase)
local base = LuaSkillBase
bs_4009.config = {buffId = 80, buffTier = 15}

function bs_4009:ctor()
end

function bs_4009:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4009_1", 1, self.OnAfterBattleStart)
end

function bs_4009:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier)
end

function bs_4009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4009
