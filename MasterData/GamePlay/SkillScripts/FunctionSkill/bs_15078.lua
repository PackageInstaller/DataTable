local bs_15078 = class("bs_15078", LuaSkillBase)
local base = LuaSkillBase
bs_15078.config = {}

function bs_15078:ctor()
end

function bs_15078:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15078_4", 1, self.OnAfterPlaySkill)
end

function bs_15078:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack then
    local shieldValue = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.normal, shieldValue)
  end
end

function bs_15078:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15078
