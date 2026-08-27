local bs_10123 = class("bs_10123", LuaSkillBase)
local base = LuaSkillBase
bs_10123.config = {effectId = 10171, buffId = 1117}

function bs_10123:ctor()
end

function bs_10123:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10123_1", 1, self.OnAfterHurt, self.caster)
end

function bs_10123:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and skill.isCommonAttack and self:IsReadyToTake() and not isTriggerSet then
    if self.caster:GetBuffTier(self.config.buffId) < self.arglist[2] then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
      self:PlayChipEffect()
    elseif self.caster:GetBuffTier(self.config.buffId) > self.arglist[2] then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[2], nil, true)
    end
    self:OnSkillTake()
  end
  if sender == self.caster and not isMiss and skill.isCommonAttack and isCrit and not self.caster.recordTable["30033_Flag"] then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_10123:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10123
