local bs_10209 = class("bs_10209", LuaSkillBase)
local base = LuaSkillBase
bs_10209.config = {buffId = 1059, effectId = 135}

function bs_10209:ctor()
end

function bs_10209:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_10209_1", 2, self.OnSetHurt, {
    sender = self.caster,
    extraArg2 = false,
    extraArg3 = false
  })
end

function bs_10209:OnSetHurt(context)
  if context.sender == self.caster and not context.isMiss and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and not context.isTriggerSet and context.hurt_type == 1 and self.arglist[3] > 0 and 0 < self.arglist[4] then
    local tier = 1
    self:PlayChipEffect()
    local time = self.arglist[4]
    local pre_tier = context.target:GetBuffTier(self.config.buffId)
    if pre_tier >= self.arglist[3] then
      LuaSkillCtrl:DispelBuff(context.target, self.config.buffId, tier)
    end
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId, tier, time)
  end
end

function bs_10209:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10209
