local bs_60010 = class("bs_60010", LuaSkillBase)
local base = LuaSkillBase
bs_60010.config = {
  buffId1 = 179,
  buffId2 = 1033,
  buffId3 = 198,
  buffId4 = 88
}

function bs_60010:ctor()
end

function bs_60010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_60010_1", 1, self.OnAfterBattleStart)
end

function bs_60010:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId4, 1, nil, true)
end

function bs_60010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_60010
