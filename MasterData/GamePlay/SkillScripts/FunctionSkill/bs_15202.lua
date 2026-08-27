local bs_15202 = class("bs_15202", LuaSkillBase)
local base = LuaSkillBase
bs_15202.config = {}

function bs_15202:ctor()
end

function bs_15202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15202_2", 1, self.OnAfterPlaySkill)
end

function bs_15202:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    local value = self.caster.maxHp * self.arglist[1] // 1000
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        LuaSkillCtrl:AddRoleShield(targetList[i].targetRole, eShieldType.Normal, value)
      end
    end
  end
end

function bs_15202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15202
