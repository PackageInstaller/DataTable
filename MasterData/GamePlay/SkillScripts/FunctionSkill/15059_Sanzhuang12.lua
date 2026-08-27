local bs_15059 = class("bs_15059", LuaSkillBase)
local base = LuaSkillBase
bs_15059.config = {}

function bs_15059:ctor()
end

function bs_15059:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_15059_4", 1, self.OnSetHeal, self.caster)
end

function bs_15059:OnSetHeal(context)
  if context.sender == self.caster and self:IsReadyToTake() and not context.isTriggerSet and context.target.maxHp - context.target.hp < context.heal then
    self:OnSkillTake()
    local exHeal = (context.heal - context.target.maxHp + context.target.hp) * self.arglist[1] // 1000
    if exHeal <= 0 then
      exHeal = context.heal
    end
    local sheildValue = exHeal
    LuaSkillCtrl:AddRoleShield(context.target, eShieldType.Normal, sheildValue)
  end
end

function bs_15059:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15059
