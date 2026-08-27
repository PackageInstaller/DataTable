local bs_10052 = class("bs_10052", LuaSkillBase)
local base = LuaSkillBase
bs_10052.config = {buffId = 1015}

function bs_10052:ctor()
end

function bs_10052:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10052_1", 1, self.OnAfterBattleStart)
end

function bs_10052:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10052:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10052
