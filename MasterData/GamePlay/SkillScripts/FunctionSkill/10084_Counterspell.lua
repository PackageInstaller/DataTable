local bs_10084 = class("bs_10084", LuaSkillBase)
local base = LuaSkillBase
bs_10084.config = {
  healFormula = 10048,
  audioId2 = 71,
  buffId_253 = 253
}

function bs_10084:ctor()
end

function bs_10084:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_10084_beforeBuff", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_10084_buffDie", 1, self.OnBuffDie)
  local buff_time = self.caster.recordTable.basebufftime
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_253, 1, buff_time, true)
end

function bs_10084:OnBeforeAddBuff(target, context)
  if context.buff.buffType == 2 and target == self.caster and self:IsReadyToTake() and target:GetBuffTier(self.config.buffId_253) == 0 then
    if self.caster.recordTable.CounterSpellCount ~= nil and 0 < self.caster.recordTable.CounterSpellCount then
      local counterSpellBuffId = target.recordTable.CounterSpellBuffId
      if counterSpellBuffId ~= nil then
        local buffTier = self.caster:GetBuffTier(counterSpellBuffId)
        context.active = false
        self.caster.recordTable.CounterSpellCount = self.caster.recordTable.CounterSpellCount - 1
        if 0 >= self.caster.recordTable.CounterSpellCount then
          LuaSkillCtrl:DispelBuff(self.caster, counterSpellBuffId, buffTier)
          self.caster.recordTable.CounterSpellCount = nil
        end
      end
    end
    self:OnSkillTake()
  end
end

function bs_10084:OnBuffDie(buff, target, removeType)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  if (removeType == eBuffRemoveType.Timeout or removeType == eBuffRemoveType.Conflict) and buff.dataId == self.config.buffId_253 then
    local healValue = LuaSkillCtrl:CallFormulaNumber(self.config.healFormula, target, target)
    LuaSkillCtrl:CallHeal(healValue, self, target, buff.maker)
  end
end

function bs_10084:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10084
