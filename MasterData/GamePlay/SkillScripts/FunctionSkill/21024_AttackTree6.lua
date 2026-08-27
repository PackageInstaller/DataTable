local bs_21024 = class("bs_21024", LuaSkillBase)
local base = LuaSkillBase
bs_21024.config = {}

function bs_21024:ctor()
end

function bs_21024:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_21024_13", 1, self.OnAfterPlaySkill)
end

function bs_21024:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 60, 10)
    if targetlist.Count ~= 0 then
      for i = 0, targetlist.Count - 1 do
        local value = targetlist[i].targetRole.hp * self.arglist[1] // 1000
        if value >= self.caster.skill_intensity * self.arglist[2] // 1000 then
          value = self.caster.skill_intensity * self.arglist[2] // 1000
        end
        LuaSkillCtrl:RemoveLife(value, self, targetlist[i].targetRole, true, nil, true, true, eHurtType.RealDmg)
      end
    end
  end
end

function bs_21024:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21024
