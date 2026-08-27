local bs_81013 = class("bs_81013", LuaSkillBase)
local base = LuaSkillBase
bs_81013.config = {}

function bs_81013:ctor()
end

function bs_81013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81013_4", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnBattleEnd, "bs_81013", 2, self.OnBattleEnd)
  self.flag = false
end

function bs_81013:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 20097 then
      self.flag = true
    end
  end
end

function bs_81013:OnBattleEnd()
  if self.flag then
    LuaSkillCtrl:StartAvgWithPauseGame("23winter_s18_2", nil, nil)
  end
end

function bs_81013:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81013
