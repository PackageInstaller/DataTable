local bs_20088 = class("bs_20088", LuaSkillBase)
local base = LuaSkillBase
bs_20088.config = {buffId = 1214}

function bs_20088:ctor()
end

function bs_20088:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20088_1", 1, self.OnAfterBattleStart)
end

function bs_20088:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_20088:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20088
