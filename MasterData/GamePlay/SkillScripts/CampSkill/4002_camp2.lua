local bs_4002 = class("bs_4002", LuaSkillBase)
local base = LuaSkillBase
bs_4002.config = {buffId = 99, buffDuration = 45}

function bs_4002:ctor()
end

function bs_4002:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_4002_3", 1, self.OnSetHurt, nil, self.caster)
end

function bs_4002:OnSetHurt(context)
  if context.target == self.caster and self:IsReadyToTake() and context.hurt >= self.caster.hp then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.config.buffDuration, true)
    self:OnSkillTake()
  end
end

function bs_4002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4002
