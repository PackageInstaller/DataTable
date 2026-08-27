local bs_2009802 = class("bs_2009802", LuaSkillBase)
local base = LuaSkillBase
bs_2009802.config = {
  effectId_1 = 2009804,
  effectId_2 = 2009805,
  effectId_3 = 2009806,
  effectId_4 = 2009807,
  effectId_5 = 2009808,
  actionId_start = 1022,
  action_speed = 1,
  start_time = 12,
  actionId_end = 1024,
  end_time = 13,
  buffId_170 = 170,
  actionId_loop = 1023,
  hurtConfigId = 2,
  audioId_start = 2009804,
  audioId_loop = 2009805,
  audioId_end = 2009806,
  audioId_attack = 2009807
}

function bs_2009802:ctor()
end

function bs_2009802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_2009802:PlaySkill(data)
  local target = self.caster.recordTable.lastAttackRole
  if target == nil or target.hp <= 0 or target.belongNum == eBattleRoleBelong.neutral then
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target == nil or target.hp <= 0 then
    return
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  self:CallCasterWait(self.config.start_time + self.arglist[1])
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_start)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.config.start_time + self.arglist[1], true)
  self.startEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_1, self, nil, nil, nil, true)
end

function bs_2009802:OnAttackTrigger(target)
  self.loopAudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_loop)
  self.loopEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_2, self)
  LuaSkillCtrl:StartTimer(self, 2, function()
    if self.startEffect ~= nil then
      self.startEffect:Die()
      self.startEffect = nil
    end
  end)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop)
  self.attack = LuaSkillCtrl:StartTimer(self, self.arglist[2], function()
    if self.loopEffect ~= nil then
      self.loopEffect:Die()
      self.loopEffect = nil
    end
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_attack)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_4, self, nil, nil, nil, true)
    LuaSkillCtrl:StartTimer(self, 6, function()
      self.loopEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_2, self, nil, nil, nil, true)
    end)
    LuaSkillCtrl:StartTimer(self, 1, function()
      self:OnAttack(target)
    end)
  end, self, -1, 15)
  LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    self:OnOver()
  end)
end

function bs_2009802:OnAttack(target)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, 1) then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, {
      self.arglist[3]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effectId_5, self)
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnFortitudeSkill, target, self.arglist[4])
  else
    self:OnOver()
  end
end

function bs_2009802:OnOver()
  if self.loopEffect ~= nil then
    self.loopEffect:Die()
    self.loopEffect = nil
  end
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.audioloop)
    self.loopAudio = nil
  end
  self:CancleCasterWait()
  self:CallCasterWait(self.config.end_time)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_end)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_3, self)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  if self.attack ~= nil then
    self.attack:Stop()
    self.attack = nil
  end
end

function bs_2009802:OnBreakSkill(role)
  if self.caster:GetBuffTier(self.config.buffId_170) > 0 then
    self:OnOver()
  end
  base.OnBreakSkill(self, role)
end

function bs_2009802:OnCasterDie()
  self:CallCasterWait(self.config.end_time)
  if self.loopEffect ~= nil then
    self.loopEffect:Die()
    self.loopEffect = nil
  end
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.audioloop)
    self.loopAudio = nil
  end
  base.OnCasterDie(self)
end

function bs_2009802:LuaDispose()
  base.LuaDispose(self)
  self.loopEffect = nil
  self.startEffect = nil
  self.loopAudio = nil
end

return bs_2009802
