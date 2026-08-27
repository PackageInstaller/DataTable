local bs_25406 = class("bs_25406", LuaSkillBase)
local base = LuaSkillBase
bs_25406.config = {buffId1 = 2160, buffId2 = 2158}

function bs_25406:ctor()
end

function bs_25406:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25406_1", 1, self.OnAfterBattleStart)
end

function bs_25406:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_25406:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25406
