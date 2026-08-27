local bs_81026 = class("bs_81026", LuaSkillBase)
local base = LuaSkillBase
bs_81026.config = {}

function bs_81026:ctor()
end

function bs_81026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81026_4", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnBattleEnd, "bs_81026", 2, self.OnBattleEnd)
  self.flag = false
end

function bs_81026:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 20119 then
      self.flag = true
    end
  end
end

function bs_81026:OnBattleEnd()
  if self.flag then
    LuaSkillCtrl:StartAvgWithPauseGame("23carnival_s24_2", nil, nil)
  end
end

function bs_81026:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81026
