local bs_70004 = class("bs_70004", LuaSkillBase)
local base = LuaSkillBase
bs_70004.config = {
  buffId = 1146,
  buffId2 = 1147,
  buffId3 = 198,
  buffTier = 1
}

function bs_70004:ctor()
end

function bs_70004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70004_1", 1, self.OnAfterBattleStart)
end

function bs_70004:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, self.config.buffTier, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, self.config.buffTier, nil, true)
end

function bs_70004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70004
