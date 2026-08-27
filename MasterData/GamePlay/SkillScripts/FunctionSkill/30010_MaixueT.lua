local bs_30010 = class("bs_30010", LuaSkillBase)
local base = LuaSkillBase
bs_30010.config = {
  buffId = 1121,
  buffTier = 1,
  effectId = 10640
}

function bs_30010:ctor()
end

function bs_30010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_30010_3", 2, self.OnAfterHurt, self.caster)
  self.isDouble = false
  self.atknum = 0
end

function bs_30010:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet then
    local restTier = sender:GetBuffTier(self.config.buffId)
    if LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and not self.isDouble and restTier == 0 then
      self:PlayChipEffect()
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
      self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
      self.isDouble = true
      self.atknum = 2
    end
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

function bs_30010:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_30010:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_30010
