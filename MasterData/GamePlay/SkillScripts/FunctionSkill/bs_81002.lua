local bs_81002 = class("bs_81002", LuaSkillBase)
local base = LuaSkillBase
bs_81002.config = {buffId = 32, buffId2 = 88}

function bs_81002:ctor()
end

function bs_81002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_81002_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("104702_14", 90, self.OnSetHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  self.curTime = 0
end

function bs_81002:OnSetHurt(context)
  if context.target.roleDataId == 20057 then
    if LuaSkillCtrl:GetRoleAllShield(context.target) > 0 then
      context.hurt = LuaSkillCtrl:GetRoleAllShield(context.target)
    else
      context.hurt = context.target.maxHp // 80
    end
  end
end

function bs_81002:OnAfterBattleStart()
  LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s16_1", nil, nil)
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 20057 then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
      LuaSkillCtrl:RegisterRoleHpCostEvent(self, targetRole, {
        900,
        800,
        700,
        600,
        500,
        400,
        300,
        200,
        100,
        10
      }, self.OnHpSubCost, false)
    end
  end
end

function bs_81002:OnHpSubCost(curHp, TargetValue)
  self.curTime = self.curTime + 1
  if self.curTime == 1 then
    LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s16_2", nil, nil)
    self:Wudi()
  elseif self.curTime == 2 then
    LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s16_3", nil, nil)
    self:Wudi()
  elseif self.curTime == 3 then
    LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s16_4", nil, nil)
    self:Wudi()
  elseif self.curTime == 4 then
    LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s16_5", nil, nil)
    self:Wudi()
  elseif self.curTime == 5 then
    LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s16_6", nil, nil)
    self:Wudi()
  elseif self.curTime == 6 then
    LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s16_7", nil, nil)
    self:Wudi()
  elseif self.curTime == 7 then
    LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s16_8", nil, nil)
    self:Wudi()
  elseif self.curTime == 8 then
    LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s16_9", nil, nil)
    self:Wudi()
  elseif self.curTime == 9 then
  else
    LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s16_10", nil, nil)
    local arriveCallBack2 = BindCallback(self, self.OnArriveAction2)
    LuaSkillCtrl:StartTimer(nil, 3, arriveCallBack2)
  end
end

function bs_81002:OnArriveAction2()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 20057 then
      LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0)
    end
  end
end

function bs_81002:Wudi()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 20057 then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId2, 1, 60, true)
    end
  end
end

function bs_81002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81002
