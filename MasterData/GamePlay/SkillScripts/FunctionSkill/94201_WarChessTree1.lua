local bs_94201 = class("bs_94201", LuaSkillBase)
local base = LuaSkillBase
bs_94201.config = {}

function bs_94201:ctor()
end

function bs_94201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_94201_13", 1, self.OnAfterPlaySkill)
end

function bs_94201:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and (skill.dataId == 5031 or skill.dataId == 50310 or skill.dataId == 5032 or skill.dataId == 5033) then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 31, 10)
    if targetlist.Count < 0 then
      return
    end
    local targetRole = targetlist[0].targetRole
    if targetRole.roleType ~= 1 then
      return
    end
    local Shieldvalue = targetRole.def * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(targetRole, eShieldType.Normal, Shieldvalue)
  end
end

function bs_94201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94201
