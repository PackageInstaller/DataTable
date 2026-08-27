local bs_93021 = class("bs_93021", LuaSkillBase)
local base = LuaSkillBase
bs_93021.config = {}

function bs_93021:ctor()
end

function bs_93021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_93021_4", 1, self.OnAfterPlaySkill)
end

function bs_93021:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    local shieldValue = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.normal, shieldValue)
  end
end

function bs_93021:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93021
