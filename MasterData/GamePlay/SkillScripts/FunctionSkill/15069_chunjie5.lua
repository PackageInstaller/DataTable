local bs_15069 = class("bs_15069", LuaSkillBase)
local base = LuaSkillBase
bs_15069.config = {
  buffId = 1266,
  buffId1 = 1266,
  buffTierFormula = 10036
}

function bs_15069:ctor()
end

function bs_15069:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15069_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_15069_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_15069_5", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_15069:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and target.hp > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil, true)
    end
  end
end

function bs_15069:OnAfterBattleStart()
  local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier)
end

function bs_15069:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil, true)
    end
  end
end

function bs_15069:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15069
