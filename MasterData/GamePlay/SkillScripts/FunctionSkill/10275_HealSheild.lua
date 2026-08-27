local bs_10275 = class("bs_10275", LuaSkillBase)
local base = LuaSkillBase
bs_10275.config = {}

function bs_10275:ctor()
end

function bs_10275:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10275_4", 1, self.OnSetHeal, self.caster)
end

function bs_10275:OnSetHeal(context)
  if context.sender == self.caster and not context.isTriggerSet then
    local shieldValue = context.heal * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(context.target, eShieldType.Normal, shieldValue)
  end
end

function bs_10275:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10275
