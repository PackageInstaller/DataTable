local bs_10126 = class("bs_10126", LuaSkillBase)
local base = LuaSkillBase
bs_10126.config = {
  buffId = 99,
  buffTier = 1,
  buffDuration = 45
}

function bs_10126:ctor()
end

function bs_10126:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_10126_3", 1, self.OnSetHurt, nil, self.caster)
end

function bs_10126:OnSetHurt(context)
  if context.target == self.caster and self:IsReadyToTake() and context.hurt >= self.caster.hp and self.caster.hp > 0 then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[1], true)
    self:OnSkillTake()
  end
end

function bs_10126:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10126
