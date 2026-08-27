local bs_104402 = class("bs_104402", LuaSkillBase)
local base = LuaSkillBase
bs_104402.config = {
  start_time = 8,
  end_time = 35,
  buffId_170 = 170,
  actionId = 1008,
  actionId_end = 1009,
  actionId_speed = 1,
  effectId_Trail = 104406,
  effectId_Trail_Big = 104408,
  effectId_skillStart = 104414,
  effectId_Big_open = 104417,
  configId_trail = 3
}

function bs_104402:ctor()
end

function bs_104402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104402:PlaySkill(data)
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
  if target == nil then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  self.caster:LookAtTarget(target)
  local time = self.config.start_time + self.arglist[3] + self.config.end_time
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  self.skillLoop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillStart, self, nil, nil, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.config.start_time + self.arglist[3], true)
end

function bs_104402:OnAttackTrigger(target)
  if target ~= nil and target.hp > 0 then
    LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[3])
    local starttime = 1 - self.arglist[1]
    local beginTimer = LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
      self:beginAttack(target)
    end, self, -1, starttime)
    LuaSkillCtrl:StartTimer(self, self.arglist[3], function()
      if beginTimer ~= nil then
        beginTimer:Stop()
        beginTimer = nil
      end
      self:endAttack(target)
    end)
  else
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
  end
end

function bs_104402:beginAttack(target)
  if target ~= nil and target.hp > 0 and not target:ContainFeature(eBuffFeatureType.Exiled) and not target:ContainFeature(eBuffFeatureType.NotBeSelectedExceptSameBlong) then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_Trail, self, self.SkillEventFunc)
  else
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
  end
end

function bs_104402:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_Trail and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId_trail, {
      self.arglist[2]
    })
    skillResult:EndResult()
  end
  if effect.dataId == self.config.effectId_Trail_Big and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId_trail, {
      self.arglist[4]
    })
    skillResult:EndResult()
    self:OnSkillDamageEnd()
  end
end

function bs_104402:endAttack(target)
  if target == nil or target.hp <= 0 or target:ContainFeature(eBuffFeatureType.Exiled) or target:ContainFeature(eBuffFeatureType.NotBeSelectedExceptSameBlong) then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    return
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  LuaSkillCtrl:StartTimer(self, 18, function()
    if target ~= nil and target.hp > 0 and not target:ContainFeature(eBuffFeatureType.Exiled) and not target:ContainFeature(eBuffFeatureType.NotBeSelectedExceptSameBlong) then
      LuaSkillCtrl:CallEffect(target, self.config.effectId_Big_open, self)
      LuaSkillCtrl:CallEffect(target, self.config.effectId_Trail_Big, self, self.SkillEventFunc)
    end
  end)
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
  LuaSkillCtrl:StartTimer(nil, self.config.end_time, function()
    self:CancleCasterWait()
  end)
end

function bs_104402:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    if self.skillLoop ~= nil then
      self.skillLoop:Die()
      self.skillLoop = nil
    end
  end
end

function bs_104402:OnCasterDie()
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
  base.OnCasterDie(self)
end

return bs_104402
