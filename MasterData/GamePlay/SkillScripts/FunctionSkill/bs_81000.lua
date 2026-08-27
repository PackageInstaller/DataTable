local bs_81000 = class("bs_81000", LuaSkillBase)
local base = LuaSkillBase
bs_81000.config = {buffStatue = 110013}

function bs_81000:ctor()
end

function bs_81000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_81000_1", 1, self.OnAfterBattleStart)
end

function bs_81000:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffStatue, 0)
  end
  LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s06_1", nil, nil)
  local arriveCallBack2 = BindCallback(self, self.OnArriveAction2)
  LuaSkillCtrl:StartTimer(nil, 30, arriveCallBack2)
end

function bs_81000:OnArriveAction2()
  LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s06_2", nil, nil)
end

function bs_81000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81000
