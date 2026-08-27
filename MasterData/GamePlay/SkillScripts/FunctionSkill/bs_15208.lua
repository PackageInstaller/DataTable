local bs_15208 = class("bs_15208", LuaSkillBase)
local base = LuaSkillBase
bs_15208.config = {
  buffId = 195,
  buffId1 = 110107,
  buffId2 = 110108
}

function bs_15208:ctor()
end

function bs_15208:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15208_1", 1, self.OnAfterBattleStart)
  self:AddAfterBuffRemoveTrigger("bs_15208_2", 4, self.AfterBuffRemove, self.caster, nil, self.config.buffId)
  self:AddAfterAddBuffTrigger("bs_15208_3", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffId)
end

function bs_15208:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil)
end

function bs_15208:AfterBuffRemove(buffId, target, removeType)
  if target == self.caster and buffId == self.config.buffId then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buffTier, nil, true)
  end
end

function bs_15208:OnAfterAddBuff(buff, target)
  if target == self.caster then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buffTier, nil, true)
  end
end

function bs_15208:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15208
