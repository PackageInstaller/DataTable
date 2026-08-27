local bs_94207 = class("bs_94207", LuaSkillBase)
local base = LuaSkillBase
bs_94207.config = {buffId = 110063}

function bs_94207:ctor()
end

function bs_94207:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_94207_13", 1, self.OnAfterPlaySkill)
end

function bs_94207:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and (skill.dataId == 5011 or skill.dataId == 5012 or skill.dataId == 5013 or skill.dataId == 5014) then
    local targetRole = skill.selectRoles[0]
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0, false)
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, self.arglist[2], ture)
  end
end

function bs_94207:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94207
