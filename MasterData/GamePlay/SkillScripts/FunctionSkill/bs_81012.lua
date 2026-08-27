local bs_81012 = class("bs_81012", LuaSkillBase)
local base = LuaSkillBase
bs_81012.config = {}

function bs_81012:ctor()
end

function bs_81012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81012_4", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnBattleEnd, "bs_81012", 2, self.OnBattleEnd)
  self.flag = false
end

function bs_81012:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 20097 then
      self.flag = true
    end
  end
end

function bs_81012:OnBattleEnd()
  if self.flag then
    LuaSkillCtrl:StartAvgWithPauseGame("23winter_s14_1", nil, nil)
  end
end

function bs_81012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81012
