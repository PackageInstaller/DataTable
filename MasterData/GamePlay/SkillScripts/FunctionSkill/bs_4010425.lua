local bs_4010425 = class("bs_4010425", LuaSkillBase)
local base = LuaSkillBase
bs_4010425.config = {buffId_fire = 1227}

function bs_4010425:ctor()
end

function bs_4010425:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010425", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
  self:AddSetHurtTrigger("bs_4010425", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
  self.MissCount = 0
  self.PowerHit = 0
end

function bs_4010425:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and isMiss and not isTriggerSet then
    self.MissCount = self.MissCount + 1
    if self.MissCount >= self.arglist[1] and self.PowerHit == 0 then
      self.PowerHit = self.arglist[2]
      self.MissCount = 0
    end
  end
end

function bs_4010425:OnSetHurt(context)
  if context.sender ~= self.caster or context.isTriggerSet then
    return
  end
  local fireTier = context.target:GetBuffTier(self.config.buffId_fire)
  local rate = self.arglist[3]
  if 0 < fireTier then
    rate = self.arglist[3] + self.arglist[4]
  end
  if 0 < self.PowerHit then
    context.hurt = context.hurt + context.hurt * rate // 1000
    self.PowerHit = self.PowerHit - 1
  end
end

function bs_4010425:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010425
