local bs_82032 = class("bs_82032", LuaSkillBase)
local base = LuaSkillBase
bs_82032.config = {buff_ExSkillPow = 712, buff_ExSkillSkill = 713}

function bs_82032:ctor()
end

function bs_82032:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_82032_1", 1, self.OnAfterBattleStart)
end

function bs_82032:OnAfterBattleStart()
  local MaxpowRole, MaxskillRole
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].roleType == eBattleRoleType.character then
        if MaxpowRole == nil then
          MaxpowRole = targetList[i]
        end
        if MaxskillRole == nil then
          MaxskillRole = targetList[i]
        end
        if targetList[i].pow >= MaxpowRole.pow then
          MaxpowRole = targetList[i]
        end
        if targetList[i].skill_intensity >= MaxskillRole.skill_intensity then
          MaxskillRole = targetList[i]
        end
      end
    end
    LuaSkillCtrl:CallBuff(self, MaxpowRole, self.config.buff_ExSkillPow, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, MaxskillRole, self.config.buff_ExSkillSkill, 1, nil, true)
  end
end

function bs_82032:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_82032
