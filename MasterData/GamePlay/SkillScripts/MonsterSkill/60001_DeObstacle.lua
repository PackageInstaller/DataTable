local bs_60001 = class("bs_60001", LuaSkillBase)
local base = LuaSkillBase
bs_60001.config = {
  buffId1 = 175,
  buffId2 = 1033,
  buffId3 = 198,
  effectId1 = 10505,
  effectId2 = 10506,
  effectId3 = 12014,
  effectId4 = 12015,
  audioId_end = 355
}

function bs_60001:ctor()
end

function bs_60001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_60001_1", 1, self.OnAfterBattleStart)
end

function bs_60001:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
end

function bs_60001:OnCasterDie()
  base.OnCasterDie(self)
  if self.caster.roleDataId == 1001 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
  elseif self.caster.roleDataId == 1005 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  elseif self.caster.roleDataId == 1007 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
  elseif self.caster.roleDataId == 1009 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId4, self)
  end
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_end)
end

return bs_60001
