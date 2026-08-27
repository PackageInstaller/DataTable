local bs_70033 = class("bs_70033", LuaSkillBase)
local base = LuaSkillBase
bs_70033.config = {buffId = 1238, buffTierFormula = 10036}

function bs_70033:ctor()
end

function bs_70033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70033_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_70033_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_70033_5", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_70033:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil, true)
    end
  end
end

function bs_70033:OnAfterBattleStart()
  local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier)
end

function bs_70033:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier)
    end
  end
end

function bs_70033:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70033
