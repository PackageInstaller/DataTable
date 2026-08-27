local bs_15056 = class("bs_15056", LuaSkillBase)
local base = LuaSkillBase
bs_15056.config = {}

function bs_15056:ctor()
end

function bs_15056:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15056_13", 1, self.OnAfterPlaySkill)
end

function bs_15056:OnAfterPlaySkill(skill, role)
  if not skill.isCommonAttack and role == self.caster then
    local sheildValue = self.caster.skill_intensity * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, sheildValue)
  end
end

function bs_15056:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15056
