local bs_10223 = class("bs_10223", LuaSkillBase)
local base = LuaSkillBase
bs_10223.config = {
  buffId = 1121,
  buffTier = 1,
  effectId = 10640
}

function bs_10223:ctor()
end

function bs_10223:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10223_3", 1, self.OnAfterHurt, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10223_2", 1, self.OnAfterPlaySkill)
  self.isDouble = false
  self.atknum = 0
end

function bs_10223:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet then
    local restTier = sender:GetBuffTier(self.config.buffId)
    if LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and not self.isDouble and restTier == 0 then
      self:PlayChipEffect()
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
      self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
      self.isDouble = true
      self.atknum = 2
    end
  end
end

function bs_10223:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack then
    local restTier = self.caster:GetBuffTier(self.config.buffId)
    if self.isDouble and restTier ~= 0 then
      if 0 < self.atknum then
        self.atknum = 0
      end
      if self.atknum == 0 then
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
        if self.effect ~= nil then
          self.effect:Die()
          self.effect = nil
        end
        self.isDouble = false
      end
    end
  end
end

function bs_10223:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_10223:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_10223
