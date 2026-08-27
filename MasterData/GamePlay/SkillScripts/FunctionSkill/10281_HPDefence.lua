local bs_10281 = class("bs_10281", LuaSkillBase)
local base = LuaSkillBase
bs_10281.config = {buffId = 1191, buffTierFormula = 10036}

function bs_10281:ctor()
end

function bs_10281:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10281_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_10281_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_10281_5", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_10281:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and target.hp > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil, true)
    end
  end
end

function bs_10281:OnAfterBattleStart()
  local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier)
end

function bs_10281:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster and target.hp > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier)
    end
  end
end

function bs_10281:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10281
