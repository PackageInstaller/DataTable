local bs_94202 = class("bs_94202", LuaSkillBase)
local base = LuaSkillBase
bs_94202.config = {buffId = 110058}

function bs_94202:ctor()
end

function bs_94202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_94202_13", 1, self.OnAfterPlaySkill)
end

function bs_94202:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and (skill.dataId == 5141 or skill.dataId == 5142 or skill.dataId == 5143 or skill.dataId == 51410) then
    local enemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    if enemyList.Count > 0 then
      for i = 0, enemyList.Count - 1 do
        local enemyTarget = enemyList[i]
        LuaSkillCtrl:DispelBuff(enemyTarget, self.config.buffId, 0, false)
        LuaSkillCtrl:CallBuff(self, enemyTarget, self.config.buffId, 1, self.arglist[2], ture)
      end
    end
  end
end

function bs_94202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94202
