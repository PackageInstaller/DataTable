local bs_10025 = class("bs_10025", LuaSkillBase)
local base = LuaSkillBase
bs_10025.config = {buffId = 74}

function bs_10025:ctor()
end

function bs_10025:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_10025_5", 1, self.OnAfterHeal)
end

function bs_10025:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if self:IsReadyToTake() and not isTriggerSet then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
    self:OnSkillTake()
  end
end

function bs_10025:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10025
