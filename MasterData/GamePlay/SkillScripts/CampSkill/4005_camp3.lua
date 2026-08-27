local bs_4005 = class("bs_4005", LuaSkillBase)
local base = LuaSkillBase
bs_4005.config = {buffId = 81, buffTier = 18}

function bs_4005:ctor()
end

function bs_4005:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4005_1", 1, self.OnAfterBattleStart)
end

function bs_4005:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier)
end

function bs_4005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4005
