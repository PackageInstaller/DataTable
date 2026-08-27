local bs_30005 = class("bs_30005", LuaSkillBase)
local base = LuaSkillBase
bs_30005.config = {}

function bs_30005:ctor()
end

function bs_30005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnAfterShieldHurt, "bs_30005_1", 1, self.OnAfterShieldHurt)
end

function bs_30005:OnAfterShieldHurt(context)
  local target = context.target
  local shieldType = context.shield_type
  local costValue = context.shield_cost_hurt * self.arglist[1] // 1000
  if target == self.caster and shieldType ~= eShieldType.Beelneith then
    LuaSkillCtrl:CallHeal(costValue, self, self.caster, true)
  end
end

function bs_30005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30005
