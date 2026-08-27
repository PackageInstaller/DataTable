local bs_209206 = class("bs_209206", LuaSkillBase)
local base = LuaSkillBase
bs_209206.config = {
  buffId_fly = 209204,
  buffId_hurt = 209206,
  actionId_start = 1050,
  actionId_loop = 1049,
  actionId_end = 1051,
  actionId_end1 = 1052,
  action_speed = 1,
  actionId_start_time = 16,
  actionId_end_time = 35,
  actionId_end1_time = 38,
  effectId_fly = 209213,
  effectId_loop = 209214,
  effectId_aim = 209215,
  effectId_hit = 209216,
  effectId_interrupt = 209217,
  configId = 3
}

function bs_209206:ctor()
end

function bs_209206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.loopTime = self.arglist[2]
end

function bs_209206:PlaySkill(data)
  self:OnSkillTake()
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_209206_1", 1, self.OnBreakShield)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_fly, self)
  local tempTarget = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if tempTarget == nil then
    return
  end
  local target = tempTarget[0].targetRole
  self.caster:LookAtTarget(target)
  if target == nil or 0 >= target.hp then
    return
  end
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.loopTime
  self:CallCasterWait(time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  self.loopAttack = LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
    self.loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
  end, nil)
  self.finishAttack = LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time + self.loopTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    self:RemoveSkillTrigger(eSkillTriggerType.OnBreakShield)
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, time, true)
  self:AbandonSkillCdAutoReset(true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(self, time, callnextskill)
end

function bs_209206:OnAttackTrigger(target, data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_fly, 1, self.loopTime)
  local value = self.caster.maxHp * self.arglist[3] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Beelneith, value)
  self.aim = LuaSkillCtrl:CallEffect(target, self.config.effectId_aim, self)
  local shoot = BindCallback(self, self.ShootWave, target)
  self.onLoopAttack = LuaSkillCtrl:StartTimer(self, self.loopTime + 3, shoot, self, nil)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[2])
  self.boom = LuaSkillCtrl:StartTimer(self, self.arglist[2], function()
    local SelfShieldValue = LuaSkillCtrl:GetShield(self.caster, 3)
    if SelfShieldValue ~= 0 then
      LuaSkillCtrl:ClearShield(self.caster, 3)
    end
  end)
end

function bs_209206:ShootWave(target)
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
  if self.aim ~= nil then
    self.aim:Die()
    self.aim = nil
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arglist[1]
  })
  skillResult:EndResult()
end

function bs_209206:OnBreakShield(shieldType, sender, target)
  if target == self.caster and shieldType == 3 then
    if self.boom ~= nil then
      self.boom:Stop()
      self.boom = nil
    end
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
    if self.loop ~= nil then
      self.loop:Die()
      self.loop = nil
    end
    if self.aim ~= nil then
      self.aim:Die()
      self.aim = nil
    end
    local OnDropTrigger = BindCallback(self, self.OnDropTrigger)
    self:RemoveSkillTrigger(eSkillTriggerType.OnBreakShield)
    local time = self.config.actionId_end1_time
    self:CallCasterWait(time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_end1, self.config.action_speed, self.config.actionId_end1_time, OnDropTrigger)
  end
end

function bs_209206:OnDropTrigger()
  LuaSkillCtrl:DispelBuff(self.caster, 170, 1)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_fly, 1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_hurt, 1, self.arglist[4])
  self:EndSkillAndCallNext()
end

function bs_209206:EndSkillAndCallNext()
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

function bs_209206:OnBreakSkill()
  base.OnBreakSkill(self)
  if self.loopAttack == nil then
    return
  end
  if self.boom ~= nil then
    self.boom:Stop()
    self.boom = nil
  end
  local SelfShieldValue = LuaSkillCtrl:GetShield(self.caster, 3)
  if SelfShieldValue ~= 0 then
    LuaSkillCtrl:ClearShield(self.caster, 3)
  end
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
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
  if self.aim ~= nil then
    self.aim:Die()
    self.aim = nil
  end
  local OnDropTrigger = BindCallback(self, self.OnDropTrigger)
  self:RemoveSkillTrigger(eSkillTriggerType.OnBreakShield)
  local time = self.config.actionId_end1_time
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_end1, self.config.action_speed, self.config.actionId_end1_time, OnDropTrigger)
end

function bs_209206:OnCasterDie()
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
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
  if self.aim ~= nil then
    self.aim:Die()
    self.aim = nil
  end
end

return bs_209206
