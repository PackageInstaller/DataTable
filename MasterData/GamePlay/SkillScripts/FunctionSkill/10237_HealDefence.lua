local bs_10237 = class("bs_10237", LuaSkillBase)
local base = LuaSkillBase
bs_10237.config = {buffId = 1090, buffTier = 1}

function bs_10237:ctor()
end

function bs_10237:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_10237_5", 1, self.OnAfterHeal, self.caster)
end

function bs_10237:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if sender == self.caster and not isTriggerSet and self:IsReadyToTake() then
    self:OnSkillTake()
    local buffTier = target:GetBuffTier(self.config.buffId)
    if buffTier < self.arglist[2] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, nil, true)
    elseif buffTier > self.arglist[2] then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.arglist[2], nil, true)
    end
  end
end

function bs_10237:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10237
