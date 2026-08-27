local bs_10289 = class("bs_10289", LuaSkillBase)
local base = LuaSkillBase
bs_10289.config = {buffId = 1059, buffTier = 1}

function bs_10289:ctor()
end

function bs_10289:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10289_3", 3, self.OnAfterPlaySkill)
end

function bs_10289:OnAfterPlaySkill(skill, role)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 45, 0)
    if targetlist.Count < 1 then
      return
    end
    local targetRole = targetlist[0].targetRole
    if 0 < targetRole.hp then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.arglist[1], self.arglist[2])
    end
  end
end

function bs_10289:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10289
