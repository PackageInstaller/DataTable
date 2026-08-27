local bs_92029 = class("bs_92029", LuaSkillBase)
local base = LuaSkillBase
bs_92029.config = {}

function bs_92029:ctor()
end

function bs_92029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_92029_4", 1, self.OnAfterPlaySkill)
end

function bs_92029:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack then
    local shieldValue = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.normal, shieldValue)
  end
end

function bs_92029:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92029
