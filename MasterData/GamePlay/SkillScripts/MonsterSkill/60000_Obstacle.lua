local bs_60000 = class("bs_60000", LuaSkillBase)
local base = LuaSkillBase
bs_60000.config = {
  buffId1 = 175,
  buffId2 = 1033,
  buffId3 = 198,
  buffId4 = 88
}

function bs_60000:ctor()
end

function bs_60000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_60000_1", 1, self.OnAfterBattleStart)
end

function bs_60000:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId4, 1, nil, true)
end

function bs_60000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_60000
