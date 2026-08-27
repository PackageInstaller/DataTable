local bs_81004 = class("bs_81004", LuaSkillBase)
local base = LuaSkillBase
bs_81004.config = {}

function bs_81004:ctor()
end

function bs_81004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81004_4", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnBattleEnd, "bs_81004", 1, self.OnBattleEnd)
  self.flag = false
end

function bs_81004:OnAfterBattleStart()
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

function bs_81004:OnBattleEnd()
  if self.flag then
    LuaSkillCtrl:StartAvgWithPauseGame("23winter_s11_1", nil, nil)
  end
end

function bs_81004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81004
