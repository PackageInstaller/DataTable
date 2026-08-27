local bs_92087 = class("bs_92087", LuaSkillBase)
local base = LuaSkillBase
bs_92087.config = {buffId = 1227, buffDuration = 90}

function bs_92087:ctor()
end

function bs_92087:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_92087_1", 1, self.OnSetHurt, nil, self.caster)
  self:AddAfterHurtTrigger("bs_92087", 2, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, nil, false)
end

function bs_92087:OnSetHurt(context)
  local buffTier = context.sender:GetBuffTier(self.config.buffId)
  if context.target == self.caster and buffTier ~= nil and 0 < buffTier then
    context.hurt = context.hurt - context.hurt * self.arglist[2] // 1000
  end
end

function bs_92087:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss or isTriggerSet or target ~= self.caster then
    return
  end
  local range = LuaSkillCtrl:CallRange(1, 1000)
  if range < self.arglist[1] and self:IsReadyToTake() then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, 1, self.config.buffDuration, true)
    self:OnSkillTake()
  end
end

function bs_92087:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92087
