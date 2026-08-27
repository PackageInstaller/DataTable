local bs_94205 = class("bs_94205", LuaSkillBase)
local base = LuaSkillBase
bs_94205.config = {buffId = 110061}

function bs_94205:ctor()
end

function bs_94205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_94205_13", 1, self.OnAfterPlaySkill)
end

function bs_94205:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and (skill.dataId == 5111 or skill.dataId == 5112 or skill.dataId == 5113) then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 51, 10)
    if targetlist.Count < 0 then
      return
    end
    local targetRole = targetlist[0].targetRole
    if targetRole.roleType ~= 1 then
      return
    end
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0, false)
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, self.arglist[2], ture)
  end
end

function bs_94205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94205
