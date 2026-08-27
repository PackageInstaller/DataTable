local bs_4003 = class("bs_4003", LuaSkillBase)
local base = LuaSkillBase
bs_4003.config = {buffId = 99, buffDuration = 60}

function bs_4003:ctor()
end

function bs_4003:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_4003_3", 1, self.OnSetHurt, nil, self.caster)
end

function bs_4003:OnSetHurt(context)
  if context.target == self.caster and self:IsReadyToTake() and context.hurt >= self.caster.hp then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.config.buffDuration, true)
    self:OnSkillTake()
  end
end

function bs_4003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4003
