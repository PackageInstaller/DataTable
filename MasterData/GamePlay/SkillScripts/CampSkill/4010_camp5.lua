local bs_4010 = class("bs_4010", LuaSkillBase)
local base = LuaSkillBase
bs_4010.config = {buffId = 80, buffTier = 22}

function bs_4010:ctor()
end

function bs_4010:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4010_1", 1, self.OnAfterBattleStart)
end

function bs_4010:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier)
end

function bs_4010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010
