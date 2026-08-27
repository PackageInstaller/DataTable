local bs_8102 = class("bs_8102", LuaSkillBase)
local base = LuaSkillBase
bs_8102.config = {buffId = 612}

function bs_8102:ctor()
end

function bs_8102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8102_1", 1, self.OnAfterBattleStart)
end

function bs_8102:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8102:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8102
