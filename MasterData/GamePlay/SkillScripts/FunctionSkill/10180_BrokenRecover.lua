local bs_10180 = class("bs_10180", LuaSkillBase)
local base = LuaSkillBase
bs_10180.config = {}

function bs_10180:ctor()
end

function bs_10180:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10180_1", 1000, self.OnSetHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.OnAfterShieldHurt, "bs_10180_1", 1, self.OnAfterShieldHurt)
end

function bs_10180:OnAfterShieldHurt(context)
  local sender = context.sender
  local shieldType = context.shield_type
  local costValue = context.shield_cost_hurt
  local healValue = costValue * self.arglist[2] // 1000
  if sender == self.caster and (shieldType == eShieldType.LongRange or shieldType == eShieldType.NoRange) then
    LuaSkillCtrl:CallHeal(healValue, self, self.caster, true)
  end
end

function bs_10180:OnSetHurt(context)
  if not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    if context.sender == self.caster and self.caster.attackRange > 1 and context.target:GetShield(eShieldType.LongRange) > 0 then
      context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
    end
    if context.sender == self.caster and self.caster.attackRange == 1 and 0 < context.target:GetShield(eShieldType.NoRange) then
      context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
    end
  end
end

function bs_10180:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10180
