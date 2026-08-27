local bs_25408 = class("bs_25408", LuaSkillBase)
local base = LuaSkillBase
bs_25408.config = {buffId1 = 2162, buffId2 = 2158}

function bs_25408:ctor()
end

function bs_25408:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25408_1", 1, self.OnAfterBattleStart)
end

function bs_25408:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_25408:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25408
