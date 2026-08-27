local bs_209402 = class("bs_209402", LuaSkillBase)
local base = LuaSkillBase
bs_209402.config = {
  buffId_fly = 209204,
  buffId_hurt = 209205,
  buffId_lockCd = 170,
  actionId_start = 1008,
  actionId_loop = 1007,
  actionId_end = 1009,
  actionId_end1 = 1053,
  action_speed = 1,
  actionId_start_time = 15,
  actionId_end_time = 42,
  actionId_end1_time = 63,
  effectId_fly = 209403,
  effectId_shootLeft = 209404,
  effectId_shootRight = 209405,
  effectId_trail = 209406,
  effectId_trailHit = 209407,
  effectId_interrupt = 209408,
  configId = 3
}

function bs_209402:ctor()
end

function bs_209402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.loopTime = self.arglist[2]
end

function bs_209402:PlaySkill(data)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_209402_1", 1, self.OnBreakShield)
  self:OnSkillTake()
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_fly, self)
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.loopTime
  self:CallCasterWait(time)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_fly, 1, time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  self.loopAttack = LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
  end, nil)
  self.finishAttack = LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time + self.loopTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    self:RemoveSkillTrigger(eSkillTriggerType.OnBreakShield)
    if self.onLoopAttack ~= nil then
      self.onLoopAttack:Stop()
      self.onLoopAttack = nil
    end
    if self.onLoopAttackEffect ~= nil then
      self.onLoopAttackEffect:Stop()
      self.onLoopAttackEffect = nil
    end
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, time, true)
  self:AbandonSkillCdAutoReset(true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(self, time, callnextskill)
end

function bs_209402:OnAttackTrigger(data)
  local value = self.caster.maxHp * self.arglist[4] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Beelneith, value)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, self.cskill.SkillRange) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target == nil or target.hp <= 0 then
    return
  end
  local shoot = BindCallback(self, self.ShootWave, target)
  LuaSkillCtrl:StartTimer(self, 4, shoot, self)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[2])
  self.boom = LuaSkillCtrl:StartTimer(self, self.arglist[2], function()
    local SelfShieldValue = LuaSkillCtrl:GetShield(self.caster, 3)
    if SelfShieldValue ~= 0 then
      LuaSkillCtrl:ClearShield(self.caster, 3)
    end
    self:RemoveSkillTrigger(eSkillTriggerType.OnBreakShield)
  end)
  self.onLoopAttackEffect = LuaSkillCtrl:StartTimer(self, self.arglist[3], function()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_shootLeft, self)
  end, self, -1, self.arglist[3])
end

function bs_209402:ShootWave_loop(last_target)
  local target
  local tempTarget = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if tempTarget.Count > 0 then
    target = tempTarget[0].targetRole
  else
    target = last_target
  end
  self.caster:LookAtTarget(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self, self.SkillEventFunc)
end

function bs_209402:ShootWave(last_target)
  local target
  local tempTarget = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if tempTarget.Count > 0 then
    target = tempTarget[0].targetRole
  else
    target = last_target
  end
  self.caster:LookAtTarget(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self, self.SkillEventFunc)
  local shoot = BindCallback(self, self.ShootWave_loop, target)
  self.onLoopAttack = LuaSkillCtrl:StartTimer(self, self.arglist[3], shoot, self, -1)
end

function bs_209402:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target, 1, true)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        if targetList[i].belongNum ~= self.caster.belongNum then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
            self.arglist[1]
          })
          skillResult:EndResult()
        end
      end
    end
    LuaSkillCtrl:CallEffect(target, self.config.effectId_trailHit, self, nil, nil, nil, true)
  end
end

function bs_209402:OnBreakShield(shieldType, sender, target)
  if target == self.caster and shieldType == 3 then
    if self.boom ~= nil then
      self.boom:Stop()
      self.boom = nil
    end
    self:RemoveSkillTrigger(eSkillTriggerType.OnBreakShield)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_interrupt, self)
    if self.loopAttack ~= nil then
      self.loopAttack:Stop()
      self.loopAttack = nil
    end
    if self.finishAttack ~= nil then
      self.finishAttack:Stop()
      self.finishAttack = nil
    end
    if self.onLoopAttack ~= nil then
      self.onLoopAttack:Stop()
      self.onLoopAttack = nil
    end
    if self.onLoopAttackEffect ~= nil then
      self.onLoopAttackEffect:Stop()
      self.onLoopAttackEffect = nil
    end
    local OnDropTrigger = BindCallback(self, self.OnDropTrigger)
    self:CancleCasterWait()
    local time = self.config.actionId_end1_time
    self:CallCasterWait(time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_end1, self.config.action_speed, self.config.actionId_end1_time, OnDropTrigger)
  end
end

function bs_209402:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_lockCd, 1)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_fly, 1)
    self:EndSkillAndCallNext()
  end
end

function bs_209402:OnDropTrigger()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_lockCd, 1)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_fly, 1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_hurt, 1, self.arglist[5])
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:EndSkillAndCallNext()
end

function bs_209402:EndSkillAndCallNext()
  if self.loopAttack ~= nil then
    self.loopAttack:Stop()
    self.loopAttack = nil
  end
  if self.finishAttack ~= nil then
    self.finishAttack:Stop()
    self.finishAttack = nil
  end
  if self.onLoopAttack ~= nil then
    self.onLoopAttack:Stop()
    self.onLoopAttack = nil
  end
  if self.onLoopAttackEffect ~= nil then
    self.onLoopAttackEffect:Stop()
    self.onLoopAttackEffect = nil
  end
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self.caster:CallUnFreezeNextSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_209402:OnCasterDie()
  base.OnCasterDie(self)
  if self.loopAttack ~= nil then
    self.loopAttack:Stop()
    self.loopAttack = nil
  end
  if self.finishAttack ~= nil then
    self.finishAttack:Stop()
    self.finishAttack = nil
  end
  if self.onLoopAttack ~= nil then
    self.onLoopAttack:Stop()
    self.onLoopAttack = nil
  end
  if self.onLoopAttackEffect ~= nil then
    self.onLoopAttackEffect:Stop()
    self.onLoopAttackEffect = nil
  end
end

return bs_209402
