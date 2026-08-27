local bs_15051 = class("bs_15051", LuaSkillBase)
local base = LuaSkillBase
bs_15051.config = {}

function bs_15051:ctor()
end

function bs_15051:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15051_2", 1, self.OnAfterHurt, self.caster)
end

function bs_15051:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and 0 < hurt and not isTriggerSet and 0 < hurt then
    local shieldValue = hurt * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.normal, shieldValue)
  end
end

function bs_15051:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15051
