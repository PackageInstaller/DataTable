local bs_106103 = class("bs_106103", LuaSkillBase)
local base = LuaSkillBase
bs_106103.config = {
  actionId_start = 1005,
  actionId_loop = 1010,
  actionId_end = 1006,
  action_speed = 1,
  actionId_start_time = 15,
  actionId_end_time = 18,
  loopTime = 75,
  heal_resultId = 3,
  HurtConfigID = 17,
  effectId_hit = 106114,
  effectId_loop = 106113,
  audioIdStart = 106114,
  audioIdMovie = 106115,
  audioIdEnd = 106116
}

function bs_106103:ctor()
end

function bs_106103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106103:PlaySkill(data)
  self.caster.recordTable.NeedRestart = true
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
  self.caster:SetRoleState(CS.eBattleRoleState.Normal)
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.config.loopTime
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  self.loopAttack = LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
  end, nil)
  self.finishAttack = LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time + self.config.loopTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    if self.onLoopAttack ~= nil then
      self.onLoopAttack:Stop()
      self.onLoopAttack = nil
    end
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end, nil)
end

function bs_106103:OnAttackTrigger(data)
  local loop = BindCallback(self, self.loopattack)
  self.onLoopAttack = LuaSkillCtrl:StartTimer(self, self.arglist[6], loop, nil, -1, 3)
end

function bs_106103:loopattack()
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if playerList.Count > 0 then
    for i = 0, playerList.Count - 1 do
      local role = playerList[i]
      if role ~= nil and 0 < role.hp then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_resultId, {
          self.arglist[2]
        })
        skillResult:EndResult()
      end
    end
  end
  local extra = 0
  if playerList.Count > self.arglist[3] then
    extra = math.min(playerList.Count - self.arglist[3], 10)
  end
  local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if enemyList.Count > 0 then
    for i = 0, enemyList.Count - 1 do
      local role = enemyList[i].targetRole
      if role ~= nil and 0 < role.hp then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
          self.arglist[4] * (1 + extra * self.arglist[5] / 1000)
        })
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self)
      end
    end
  end
end

function bs_106103:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
end

function bs_106103:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_106103:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_106103:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_106103:OnCasterDie()
  base.OnCasterDie(self)
  if self.onLoopAttack ~= nil then
    self.onLoopAttack:Stop()
    self.onLoopAttack = nil
  end
  if self.loopAttack ~= nil then
    self.loopAttack:Stop()
    self.loopAttack = nil
  end
  if self.finishAttack ~= nil then
    self.finishAttack:Stop()
    self.finishAttack = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_106103:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_106103:LuaDispose()
  self.effect = nil
  base.LuaDispose(self)
end

return bs_106103
