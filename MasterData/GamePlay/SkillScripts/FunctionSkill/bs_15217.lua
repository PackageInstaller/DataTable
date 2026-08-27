local bs_15217 = class("bs_15217", LuaSkillBase)
local base = LuaSkillBase
bs_15217.config = {
  buffId1 = 110114,
  buffId2 = 110115,
  buffId = 1059
}

function bs_15217:ctor()
end

function bs_15217:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15217_1", 1, self.OnAfterBattleStart)
  self:AddAfterBuffRemoveTrigger("bs_15217_2", 4, self.AfterBuffRemove, self.caster, nil, self.config.buffId)
  self:AddAfterAddBuffTrigger("bs_15217_3", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffId)
end

function bs_15217:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil)
end

function bs_15217:AfterBuffRemove(buffId, target, removeType)
  if target == self.caster and buffId == self.config.buffId then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buffTier, nil, true)
  end
end

function bs_15217:OnAfterAddBuff(buff, target)
  if target == self.caster then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buffTier, nil, true)
  end
end

function bs_15217:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15217
